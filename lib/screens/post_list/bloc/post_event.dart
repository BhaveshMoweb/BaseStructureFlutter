part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class PostListEvent extends PostEvent {
  final String? limit;
  final String? page;
  PostListEvent({this.page, this.limit});
}
