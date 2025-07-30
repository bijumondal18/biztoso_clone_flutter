import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../core/themes/app_sizes.dart';

class AppbarIcon extends StatelessWidget {
  final IconData? iconPath;
  final VoidCallback onPressed;

  const AppbarIcon({super.key, this.iconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding / 3),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(15),
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: Icon(
          iconPath ?? EvaIcons.arrowBack,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
