import 'package:biztoso/presentation/pages/home/components/post_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/post/post_bloc.dart';
import '../widgets/post_card.dart';

class BuildPostList extends StatelessWidget {
  const BuildPostList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.status == PostStatus.initial || state.status == PostStatus.loadingInitial) {
          // shimmer as sliver
          return PostListShimmer();
        }

        if (state.status == PostStatus.failure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(child: Text('Failed to load posts')),
            ),
          );
        }

        final items = state.items;
        if (items.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: Text('No posts yet')),
            ),
          );
        }

        return SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => PostCard(post: items[index]),
        );
      },
    );
  }
}
