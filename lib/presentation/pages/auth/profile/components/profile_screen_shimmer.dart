import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/themes/app_sizes.dart';

class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).dividerColor.withAlpha(130);
    final highlight = Theme.of(context).dividerColor.withAlpha(60);

    Widget bar({double h = 14, double? w, double r = 8}) => Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
      ),
    );

    return CustomScrollView(
      slivers: [
        // Banner shimmer (SliverAppBar replacement)
        SliverToBoxAdapter(
          child: Shimmer.fromColors(
            baseColor: base,
            highlightColor: highlight,
            child: Container(height: 200 + kToolbarHeight, color: Colors.white),
          ),
        ),

        // Body shimmer
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.kDefaultPadding,
            vertical: AppSizes.kDefaultPadding,
          ),
          sliver: SliverList.list(
            children: [
              // top action row (share / buttons area)
              Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    bar(h: 36, w: 36, r: 10),
                    const SizedBox(width: 12),
                    bar(h: 36, w: 120, r: 12),
                    const SizedBox(width: 12),
                    bar(h: 36, w: 36, r: 10),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.kDefaultPadding),

              // name/email/phone + connections card
              Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bar(h: 22, w: 180),
                          const SizedBox(height: 10),
                          bar(h: 14, w: 220),
                          const SizedBox(height: 8),
                          bar(h: 14, w: 160),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSizes.kDefaultPadding),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.kDefaultPadding * 1.5),

              // bio block
              Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bar(h: 12, w: double.infinity),
                    const SizedBox(height: 8),
                    bar(h: 12, w: double.infinity),
                    const SizedBox(height: 8),
                    bar(h: 12, w: 220),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.kDefaultPadding),

              // verified badges header + button
              Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: Row(
                  children: [
                    Expanded(child: bar(h: 16, w: 140)),
                    const SizedBox(width: 12),
                    bar(h: 36, w: 120, r: 10),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.kDefaultPadding),

              // three big icons
              Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: Row(
                  children: [
                    Flexible(child: bar(h: 56, w: 56, r: 16)),
                    const SizedBox(width: AppSizes.kDefaultPadding),
                    Flexible(child: bar(h: 56, w: 56, r: 16)),
                    const SizedBox(width: AppSizes.kDefaultPadding),
                    Flexible(child: bar(h: 56, w: 56, r: 16)),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.kDefaultPadding),

              // Social presence title
              Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: bar(h: 16, w: 140),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
