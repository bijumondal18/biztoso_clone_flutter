part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object?> get props => [];
}

class FetchBlogsEvent extends BlogEvent {}

class RefreshBlogsEvent extends BlogEvent {}
