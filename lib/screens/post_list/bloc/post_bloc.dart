import 'package:base_structure/model/posts_response.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/post_list_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostListRepository _postListRepository;

  PostBloc({
    required PostListRepository postListRepository,
  })  : _postListRepository = postListRepository,
        super(PostInitial()) {
    on<PostEvent>((event, emit) {});

    on<PostListEvent>((event, emit) => getPosts(event, emit));
  }

  getPosts(PostListEvent event, emit) async {
    emit(PostListStateBusy(true));
    final result =
        await _postListRepository.getPostList(event.page!, event.limit!);
    result.when(success: (List<PostsResponse?>? postsResponse) {
      emit(PostListStateBusy(true));
      emit(PostListStateSuccess(postsResponse));
    }, failure: (failure) {
      emit(PostListStateBusy(true));
      emit(PostListStateFailure(failure.toString()));
    });
  }
}
