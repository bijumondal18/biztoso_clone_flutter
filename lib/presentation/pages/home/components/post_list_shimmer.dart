import 'package:flutter/material.dart';


class PostListShimmer extends StatelessWidget {
  const PostListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // reuse your shimmer item widget; just make it a sliver list
    const skeletonCount = 6;
    return SliverList.builder(
      itemCount: skeletonCount,
      itemBuilder: (_, __) => const SizedBox(), // your shimmer row
    );
  }
}