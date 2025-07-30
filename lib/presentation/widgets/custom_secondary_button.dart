import 'package:flutter/material.dart';

import '../../core/themes/app_sizes.dart';

class CustomSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? hasIcon;
  final IconData? iconPath;
  final bool hasRoundedCorner;
  final Color? bgColor;
  final Color? labelColor;
  final Color? iconColor;

  const CustomSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.hasIcon = false,
    this.iconPath,
    this.hasRoundedCorner = false,
    this.bgColor,
    this.labelColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(
        hasRoundedCorner
            ? AppSizes.cardCornerRadius * 5
            : AppSizes.cardCornerRadius,
      ),
      child: Container(
        height: AppSizes.buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(
            hasRoundedCorner
                ? AppSizes.cardCornerRadius * 5
                : AppSizes.cardCornerRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: hasIcon == true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Icon(
                  iconPath,
                  color:
                      iconColor ??
                      Theme.of(context).colorScheme.surfaceContainer,
                  size: 18,
                ),
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color:
                    labelColor ??
                    Theme.of(context).colorScheme.surfaceContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
