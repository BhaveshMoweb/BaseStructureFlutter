part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostListStateBusy extends PostState {
  final bool isBusy;

  PostListStateBusy(this.isBusy);
}

class PostListStateFailure extends PostState {
  final String error;

  PostListStateFailure(this.error);
}

class PostListStateSuccess extends PostState {
  final List<PostsResponse?>? postResponse;

  PostListStateSuccess(this.postResponse);
}
