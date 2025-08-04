import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? hasIcon;
  final IconData? iconPath;
  final double? height;
  bool? isGradient;

  CustomPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.hasIcon = false,
    this.iconPath,
    this.height,
    this.isGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
      child: Container(
        height: height ?? AppSizes.buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          gradient: isGradient == true ? AppColors.primaryGradient : null,
          border: Border.all(
            width: 0.5,
            color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(80),
          ),
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: hasIcon == true,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppSizes.kDefaultPadding / 2,
                ),
                child: Icon(
                  iconPath,
                  color: isGradient == true
                      ? AppColors.white
                      : Theme.of(context).scaffoldBackgroundColor,
                  size: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding / 2,
              ),
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isGradient == true
                      ? AppColors.white
                      : Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
