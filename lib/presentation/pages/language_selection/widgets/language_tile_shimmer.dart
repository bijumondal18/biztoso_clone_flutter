import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LanguageTileShimmer extends StatelessWidget {
  const LanguageTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).dividerColor.withAlpha(80);
    final highlight = Theme.of(context).dividerColor.withAlpha(30);

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      direction: ShimmerDirection.ltr,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor.withAlpha(200),
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: Row(
          children: [
            // leading circle (icon/avatar placeholder)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: base,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            // two lines of text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14, width: double.infinity, color: base),
                  const SizedBox(height: 8),
                  Container(height: 12, width: 160, color: base),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // trailing check/arrow placeholder
            Container(width: 16, height: 16, decoration: BoxDecoration(color: base, shape: BoxShape.circle)),
          ],
        ),
      ),
    );
  }
}