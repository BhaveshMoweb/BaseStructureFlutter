import 'dart:async';

import 'package:base_structure/model/posts_response.dart';

import '../../../api_helper/api_result.dart';
import '../../../constants/handle_api_error.dart';
import '../../../utils/strings.dart';
import 'post_list_datasource.dart';

/// Repository class for Posts
class PostListRepository {
  PostListRepository({
    required PostListDataSource postListDataSource,
  }) : _postListSource = postListDataSource;

  final PostListDataSource _postListSource;

  final _controller = StreamController();

  /// Method to get posts list data
  Future<ApiResult<List<PostsResponse?>?>> getPostList(
      String currentPage, String limit) async {
    try {
      final result = await _postListSource.getPosts(currentPage, limit);
      List<PostsResponse?>? postsResponse = [];
      for (var i in result) {
        postsResponse.add(PostsResponse.fromJson(i));
      }

      if ((result[0] as Map).containsKey("id")) {
        return ApiResult.success(data: postsResponse);
      } else {
        return const ApiResult.failure(error: Label.somethingWentWrong);
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  void dispose() => _controller.close();
}
