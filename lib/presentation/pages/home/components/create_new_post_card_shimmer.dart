import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/themes/app_sizes.dart';

class CreateNewPostCardShimmer extends StatelessWidget {
  const CreateNewPostCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final base = Theme.of(context).dividerColor.withAlpha(80);
    final highlight = Theme.of(context).dividerColor.withAlpha(30);

    Widget box({double? w, double h = 12, double r = 8}) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
      ),
    );

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSizes.kDefaultPadding,
        children: [
          Row(
            spacing: AppSizes.kDefaultPadding / 2,
            children: [
              // avatar
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              // name + username
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    box(w: width * 0.35, h: 14, r: 6), // name line
                    box(w: width * 0.25, h: 12, r: 6), // username line
                  ],
                ),
              ),
            ],
          ),
          // input placeholder
          Container(
            width: width,
            padding: EdgeInsets.all(AppSizes.kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
            ),
            child: box(w: width * 0.4, h: 14, r: 6),
          ),
        ],
      ),
    );
  }
}