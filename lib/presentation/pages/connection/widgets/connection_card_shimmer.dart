import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/themes/app_sizes.dart';

class ConnectionCardShimmer extends StatelessWidget {
  final String screenFlag; // to shape trailing placeholders, optional

  const ConnectionCardShimmer({super.key, required this.screenFlag});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness != Brightness.dark;
    final base = isDark ? Colors.grey[600]! : Colors.grey[100]!;
    final highlight = isDark ? Colors.grey[800]! : Colors.grey[400]!;

    Widget trailing() {
      switch (screenFlag) {
        case 'receivedInvitation':
          return Row(
            children: [
              _pill(base, width: 84),
              const SizedBox(width: AppSizes.kDefaultPadding / 2),
              _pill(base, width: 84),
            ],
          );
        default:
          return _pill(base, width: 110);
      }
    }

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.kDefaultPadding / 2,
          vertical: AppSizes.kDefaultPadding / 1.2,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor.withAlpha(200),
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
          border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            // avatar
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: Container(color: base),
            ),
            const SizedBox(width: AppSizes.kDefaultPadding / 2),
            // two text lines
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 16, width: double.infinity, color: base),
                  const SizedBox(height: 8),
                  Container(height: 14, width: 160, color: base),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.kDefaultPadding / 2),
            // trailing button(s)
            trailing(),
          ],
        ),
      ),
    );
  }

  Widget _pill(Color base, {double width = 100, double height = 36}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}