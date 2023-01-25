import 'package:base_structure/components/custom_listview.dart';
import 'package:base_structure/components/custom_text.dart';
import 'package:base_structure/model/posts_response.dart';
import 'package:base_structure/screens/base_screen/base_screen.dart';
import 'package:base_structure/screens/post_list/data/post_list_datasource.dart';
import 'package:base_structure/utils/cm_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../utils/strings.dart';
import 'bloc/post_bloc.dart';
import 'data/post_list_repository.dart';

///    Created By Bhavesh Makwana on 18/01/23

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  /// variables to manage pagination
  int _page = 0;
  final int _limit = 10;
  final bool _hasNextPage = true;
  int _totalSize = 0;

  List<PostsResponse?>? postsList = [];

  /// this is the variable to manage loading
  bool isInLoadingState = false;
  late ScrollController _controller;

  /// Used to display loading indicators when firstTimePostsLoading function is running
  bool _isFirstLoadRunning = false;

  /// Used to display loading indicators at bottom when _loadMore function is running
  bool _isLoadMoreRunning = false;

  PostBloc postBloc = PostBloc(
      postListRepository:
          PostListRepository(postListDataSource: PostListDataSource()));

  @override
  void initState() {
    super.initState();
    firstTimePostsLoading();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: getPostListBody(),
      title: Label.posts,
      shouldShowBackButton: true,
    );
  }

  getPostListBody() {
    return SafeArea(
      child: BlocListener<PostBloc, PostState>(
        bloc: postBloc,
        listener: (context, state) {
          if (state is PostListStateFailure) {
            isInLoadingState = false;
            _isLoadMoreRunning = false;
          }
          if (state is PostListStateBusy) {
            isInLoadingState = true;
          }
          if (state is PostListStateSuccess) {
            isInLoadingState = false;
            _isFirstLoadRunning = false;
            _isLoadMoreRunning = false;
            _totalSize = state.postResponse!.length;
            if (state.postResponse!.isEmpty) {
              //_hasNextPage = false;
            } else {
              if (_page == 0) {
                postsList = state.postResponse!;
              } else {
                postsList!.addAll(state.postResponse!);
              }
            }
            if (postsList!.length == _totalSize) {
              // _hasNextPage = false;
            }
          }
        },
        child: BlocBuilder<PostBloc, PostState>(
          bloc: postBloc,
          builder: (context, state) {
            /// CustomGridView<TYPE OF YOUR LIST, index>, change your list class like below is String
            /// dataList : pass your list in dataList params
            /// noDataFoundText: if list empty, what message we want to show when list is empty
            return Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(2.w),
                    child: CustomListview(
                        controller: _controller,
                        isInLoadingState: isInLoadingState,
                        noDataFoundText: "Posts not found!",
                        listItemView: (PostsResponse? item, int index) {
                          return Card(
                              child: Container(
                            padding: EdgeInsets.all(2.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Title text
                                CustomText(
                                  text: "Title: " + item!.title!,
                                  maxLine: 2,
                                  textAlign: TextAlign.start,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),

                                CM.sb(2.h),

                                /// Body text
                                CustomText(
                                  text: "Description: " + item.body!,
                                  maxLine: 10,
                                  textAlign: TextAlign.start,
                                )
                              ],
                            ),
                          ));
                        },
                        dataList: postsList!),
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Center(child: CM.loadingView())),
              ],
            );
          },
        ),
      ),
    );
  }

  void firstTimePostsLoading() {
    setState(() {
      _isFirstLoadRunning = true;
    });

    postBloc
        .add(PostListEvent(page: _page.toString(), limit: _limit.toString()));
  }

  void _loadMore() {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1

      postBloc
          .add(PostListEvent(page: _page.toString(), limit: _limit.toString()));
    }
  }
}
