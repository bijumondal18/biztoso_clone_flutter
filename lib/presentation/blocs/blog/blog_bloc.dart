import 'package:biztoso/data/repositories/blog_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/blog_response.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository repo;

  BlogBloc({required this.repo}) : super(BlogStateInitial()) {
    on<FetchBlogsEvent>(_onFetch);
  }

  Future<void> _onFetch(FetchBlogsEvent event, Emitter<BlogState> emit) async {
    emit(BlogStateLoading());
    await _load(emit);
  }

  Future<void> _load(Emitter<BlogState> emit) async {
    try {
      final res = await repo.fetchBlogs();
      final rows = _toRows(res);
      emit(BlogStateLoaded(rows: rows));
    } catch (e) {
      emit(BlogStateFailed(error: e.toString()));
    }
  }

  List<TitledRow> _toRows(BlogResponse response) {
    final r = response.result;
    if (r == null) return [];

    // Build a map of {Section Title: List<BlogContent>}
    final sections = <String, List<BlogContent>>{
      if (r.marketing != null && r.marketing!.isNotEmpty)
        'Marketing': r.marketing!,
      if (r.technologyInnovation != null && r.technologyInnovation!.isNotEmpty)
        'Technology & Innovation': r.technologyInnovation!,
      if (r.lifestyle != null && r.lifestyle!.isNotEmpty)
        'Lifestyle': r.lifestyle!,
      if (r.inspirationPersonalGrowth != null &&
          r.inspirationPersonalGrowth!.isNotEmpty)
        'Inspiration & Personal Growth': r.inspirationPersonalGrowth!,
      if (r.test != null && r.test!.isNotEmpty) 'Tests': r.test!,
      if (r.sampleText != null && r.sampleText!.isNotEmpty)
        'Sample Text': r.sampleText!,
    };

    final rows = <TitledRow>[];
    sections.forEach((title, list) {
      rows.add(HeaderRow(title));
      rows.addAll(list.map((b) => BlogRow(b)));
    });
    return rows;
  }
}
