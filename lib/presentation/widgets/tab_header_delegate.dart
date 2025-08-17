import 'package:flutter/material.dart';

class TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  TabHeaderDelegate(this.tabBar);

  @override
  double get minExtent => kTextTabBarHeight;
  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor, // stays white under AppBar
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant TabHeaderDelegate oldDelegate) => false;
}