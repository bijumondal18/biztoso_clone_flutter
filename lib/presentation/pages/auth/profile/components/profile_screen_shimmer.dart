import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/themes/app_sizes.dart';
class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  static const double kBannerHeight = 200; // same as expandedHeight you use
  static const double kAvatarSize = 122;   // matches real avatar (diameter)

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
        // Cover + overlapped avatar (like SliverAppBar + flexibleSpace)
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Cover shimmer
              Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: Container(
                  height: kBannerHeight,
                  color: Colors.white,
                ),
              ),

              // Overlapped circular avatar shimmer
              Positioned(
                left: AppSizes.kDefaultPadding,
                bottom: -kAvatarSize / 2, // hang half below the banner
                child: Shimmer.fromColors(
                  baseColor: base,
                  highlightColor: highlight,
                  child: Container(
                    padding: const EdgeInsets.all(3), // white ring
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.08),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Container(
                      width: kAvatarSize,
                      height: kAvatarSize,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Optional: tiny verify-badge placeholder on avatar
              Positioned(
                left: AppSizes.kDefaultPadding + kAvatarSize - 26,
                bottom: -kAvatarSize / 2 - 6,
                child: Shimmer.fromColors(
                  baseColor: base,
                  highlightColor: highlight,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Spacer so content doesn't sit under the overlapped avatar
        SliverToBoxAdapter(
          child: SizedBox(height: kAvatarSize / 2 + AppSizes.kDefaultPadding),
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
                          borderRadius:
                          BorderRadius.circular(AppSizes.cardCornerRadius),
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

              // three big icons (badges)
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