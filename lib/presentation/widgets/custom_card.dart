import 'package:flutter/material.dart';

import '../../core/themes/app_sizes.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CustomCard({super.key, required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(AppSizes.kDefaultPadding),
      margin: margin ?? EdgeInsets.all(AppSizes.kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(
          width: 1.0,
          color: Theme.of(context).dividerColor.withAlpha(150),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: AppSizes.blurRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
