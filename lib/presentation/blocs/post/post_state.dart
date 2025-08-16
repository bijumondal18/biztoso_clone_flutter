part of 'post_bloc.dart';

enum PostStatus { initial, loadingInitial, success, failure }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> items;
  final bool hasNextPage;
  final int? nextPage;
  final bool isLoadingMore;
  final String? error;

  const PostState({
    required this.status,
    required this.items,
    required this.hasNextPage,
    required this.nextPage,
    required this.isLoadingMore,
    required this.error,
  });

  const PostState.initial()
      : status = PostStatus.initial,
        items = const [],
        hasNextPage = false,
        nextPage = 1,
        isLoadingMore = false,
        error = null;

  PostState copyWith({
    PostStatus? status,
    List<Post>? items,
    bool? hasNextPage,
    int? nextPage,
    bool? isLoadingMore,
    String? error,
  }) {
    return PostState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      nextPage: nextPage ?? this.nextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, items, hasNextPage, nextPage, isLoadingMore, error];
}