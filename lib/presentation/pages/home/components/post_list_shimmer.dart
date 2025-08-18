import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/themes/app_sizes.dart';


class PostListShimmer extends StatelessWidget {
  const PostListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).dividerColor.withAlpha(130);
    final highlight = Theme.of(context).dividerColor.withAlpha(60);

    return SliverList.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: const _PostSkeleton(),
        );
      },
    );
  }
}

class _PostSkeleton extends StatelessWidget {
  const _PostSkeleton();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final imageH = (MediaQuery.sizeOf(context).height * 0.28).clamp(160.0, 280.0);

    Widget bar({double h = 12, double? w, double r = 8}) => Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding / 2),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(
          width: 1.0,
          color: Theme.of(context).dividerColor.withAlpha(100),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(200),
            blurRadius: AppSizes.blurRadius,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header: avatar + two lines + menu dot
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // avatar
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSizes.kDefaultPadding / 2),
              // name/time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bar(h: 14, w: width * 0.35, r: 6),
                    const SizedBox(height: 6),
                    bar(h: 10, w: width * 0.25, r: 6),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.kDefaultPadding / 2),
              // menu icon
              bar(h: 18, w: 18, r: 6),
            ],
          ),

          // description lines
          const SizedBox(height: AppSizes.kDefaultPadding / 2),
          bar(h: 12, w: width * 0.85),
          const SizedBox(height: 8),
          bar(h: 12, w: width * 0.70),
          const SizedBox(height: 8),
          bar(h: 12, w: width * 0.55),

          // image box
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
            child: Container(
              height: imageH,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}