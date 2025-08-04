import 'package:biztoso/core/themes/app_colors.dart';
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
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: Icon(
          iconPath ?? EvaIcons.arrowBack,
          color: AppColors.white??Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
