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
  final Color? borderColor;
  final Color? iconColor;
  final bool? hasBorder;

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
    this.hasBorder = false,
    this.borderColor = Colors.transparent,
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
          border: Border.all(
            width: 1.0,
            color: hasBorder == true ? borderColor! : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
