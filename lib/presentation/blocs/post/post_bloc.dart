import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repo;

  PostBloc({required this.repo}) : super(const PostState.initial()) {
    on<PostFirstLoadRequested>(_onFirstLoad);
    on<PostNextPageRequested>(_onNextPage);
    on<PostRefreshed>(_onRefresh);
  }

  Future<void> _onFirstLoad(
    PostFirstLoadRequested e,
    Emitter<PostState> emit,
  ) async {
    if (state.status == PostStatus.loadingInitial) return;
    emit(
      state.copyWith(status: PostStatus.loadingInitial, error: null, items: []),
    );
    try {
      final page = await repo.fetchPage(page: 1);
      emit(
        state.copyWith(
          status: PostStatus.success,
          items: page.posts,
          hasNextPage: page.hasNextPage,
          nextPage: page.nextPage,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: PostStatus.failure, error: err.toString()));
    }
  }

  Future<void> _onNextPage(
    PostNextPageRequested e,
    Emitter<PostState> emit,
  ) async {
    if (!state.hasNextPage ||
        state.isLoadingMore ||
        state.status != PostStatus.success)
      return;
    emit(state.copyWith(isLoadingMore: true));
    try {
      final page = await repo.fetchPage(page: state.nextPage ?? 1);
      emit(
        state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...page.posts],
          hasNextPage: page.hasNextPage,
          nextPage: page.nextPage,
        ),
      );
    } catch (_) {
      // keep current list; just stop loader
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onRefresh(PostRefreshed e, Emitter<PostState> emit) async {
    try {
      final page = await repo.fetchPage(page: 1);
      emit(
        state.copyWith(
          status: PostStatus.success,
          items: page.posts,
          hasNextPage: page.hasNextPage,
          nextPage: page.nextPage,
          error: null,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: PostStatus.failure, error: err.toString()));
    }
  }
}
