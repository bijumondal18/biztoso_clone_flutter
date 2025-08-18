import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/themes/app_sizes.dart';

class VerificationShimmer extends StatelessWidget {
  const VerificationShimmer({super.key});

  Widget _shimmerBox({
    required BuildContext context,
    double height = 20,
    double width = 100,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).dividerColor.withAlpha(130),
      highlightColor: Theme.of(context).dividerColor.withAlpha(60),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget _shimmerRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.kDefaultPadding / 1.5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _shimmerBox(context: context, height: 50, width: 50, radius: 50),
          // Circle placeholder
          const SizedBox(width: AppSizes.kDefaultPadding),
          Expanded(
            child: _shimmerBox(
              context: context,
              height: 20,
              width: double.infinity,
              radius: 6,
            ), // Text placeholder
          ),
          const SizedBox(width: AppSizes.kDefaultPadding),
          _shimmerBox(context: context, height: 30, width: 80, radius: 6),
          // Button placeholder
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
      children: [
        const SizedBox(height: 8),
        _shimmerBox(context: context, height: 28, width: 200, radius: 6),
        const SizedBox(height: 12),
        _shimmerBox(
          context: context,
          height: 18,
          width: double.infinity,
          radius: 6,
        ),
        const SizedBox(height: AppSizes.kDefaultPadding / 2),
        _shimmerBox(
          context: context,
          height: 18,
          width: double.infinity,
          radius: 6,
        ),
        const SizedBox(height: AppSizes.kDefaultPadding * 2),
        _shimmerRow(context),
        _shimmerRow(context),
        _shimmerRow(context),
      ],
    );
  }
}
