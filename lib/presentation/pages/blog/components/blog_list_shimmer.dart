import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/themes/app_sizes.dart';

class ShimmerBlogList extends StatelessWidget {
  const ShimmerBlogList({super.key});

  @override
  Widget build(BuildContext context) {
    final baseHighlight = _shimmerColors(context);

    // Mimic your real list's padding
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: AppSizes.kDefaultPadding,
        bottom: AppSizes.kDefaultPadding,
        left: AppSizes.kDefaultPadding,
        right: AppSizes.kDefaultPadding,
      ),
      itemCount: 12, // e.g., 3 headers + 9 tiles (patterned below)
      itemBuilder: (context, index) {
        // Simple pattern: every 0th item of a group of 4 is a header
        final isHeader = index % 4 == 0;
        if (isHeader) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
            child: Shimmer.fromColors(
              baseColor: baseHighlight.base,
              highlightColor: baseHighlight.highlight,
              child: _ShimmerHeader(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
          child: Shimmer.fromColors(
            baseColor: baseHighlight.base,
            highlightColor: baseHighlight.highlight,
            child: const _ShimmerBlogTile(),
          ),
        );
      },
    );
  }
}

class _ShimmerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Matches your _Header typography space
    return Container(
      height: 20,
      width: MediaQuery.sizeOf(context).width * 0.4,
      decoration: BoxDecoration(
        color: _placeholderColor(context),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class _ShimmerBlogTile extends StatelessWidget {
  const _ShimmerBlogTile();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // image placeholder
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
          child: Container(
            width: width * 0.2,
            height: width * 0.2,
            color: _placeholderColor(context),
          ),
        ),
        const SizedBox(width: AppSizes.kDefaultPadding),
        // text placeholders
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title line
              Container(
                height: 14,
                width: width * 0.45,
                decoration: BoxDecoration(
                  color: _placeholderColor(context),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              // subtitle line 1
              Container(
                height: 12,
                width: width * 0.65,
                decoration: BoxDecoration(
                  color: _placeholderColor(context),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 6),
              // subtitle line 2 (shorter)
              Container(
                height: 12,
                width: width * 0.5,
                decoration: BoxDecoration(
                  color: _placeholderColor(context),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              // date line (calendar + date)
              Container(
                height: 10,
                width: width * 0.35,
                decoration: BoxDecoration(
                  color: _placeholderColor(context),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShimmerColors {
  final Color base;
  final Color highlight;

  _ShimmerColors(this.base, this.highlight);
}

_ShimmerColors _shimmerColors(BuildContext context) {
  return _ShimmerColors(
    Theme.of(context).dividerColor.withAlpha(130),
    Theme.of(context).dividerColor.withAlpha(60),
  );
}

Color _placeholderColor(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? Colors.grey.shade800 : Colors.grey.shade300;
}
