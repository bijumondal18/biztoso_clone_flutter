import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ConnectionsHeaderShimmer extends StatelessWidget {
  const ConnectionsHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).dividerColor.withAlpha(130);
    final highlight = Theme.of(context).dividerColor.withAlpha(60);

    // Mimics: “8 Connections”  → small box (number) + big box (text)
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Row(
        children: [
          Container(width: 18, height: 18, color: base),
          const SizedBox(width: 8),
          Container(width: 140, height: 18, color: base),
        ],
      ),
    );
  }
}