part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

final class BlogStateInitial extends BlogState {}

final class BlogStateLoading extends BlogState {}

final class BlogStateLoaded extends BlogState {
  final List<TitledRow> rows;

  const BlogStateLoaded({required this.rows});

  @override
  List<Object> get props => [rows];
}

final class BlogStateFailed extends BlogState {
  final String error;

  const BlogStateFailed({required this.error});

  @override
  List<Object> get props => [error];
}
