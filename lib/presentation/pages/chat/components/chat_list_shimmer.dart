import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/themes/app_sizes.dart';
import '../../../widgets/horizontal_divider.dart';

class ChatListShimmer extends StatelessWidget {
  final int itemCount;

  const ChatListShimmer({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).dividerColor.withAlpha(130);
    final highlight = Theme.of(context).dividerColor.withAlpha(60);

    Widget circle(double s) => Container(
      width: s,
      height: s,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );

    Widget bar({double h = 12, double? w, double r = 8}) => Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
      ),
    );

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.kDefaultPadding,
              vertical: AppSizes.kDefaultPadding / 2,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // avatar + online dot
                Stack(
                  children: [
                    circle(44),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: circle(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSizes.kDefaultPadding),

                // name + last message lines
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bar(h: 14, w: 160),
                      const SizedBox(height: 6),
                      bar(h: 12, w: double.infinity, r: 6),
                      const SizedBox(height: 6),
                      bar(h: 12, w: 220, r: 6),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // time + unread badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    bar(h: 10, w: 46, r: 6),
                    const SizedBox(height: 8),
                    circle(20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Padding(
        padding: EdgeInsets.only(left: 76),
        child: HorizontalDivider(),
      ),
    );
  }
}
