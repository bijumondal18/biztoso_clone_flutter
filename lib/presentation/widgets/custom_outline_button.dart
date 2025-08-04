import 'package:flutter/material.dart';

import '../../core/themes/app_sizes.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? hasIcon;
  final IconData? iconPath;
  final bool hasRoundedCorner;
  final double? height;
  final Color? iconColor;
  final Color? labelColor;
  final Color? borderColor;

  const CustomOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.hasIcon = false,
    this.iconPath,
    this.hasRoundedCorner = false,
    this.height,
    this.iconColor,
    this.labelColor,
    this.borderColor,
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
        height: height ?? AppSizes.buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color:
                borderColor ?? Theme.of(context).colorScheme.surfaceContainer.withAlpha(100),
          ),
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
                padding: const EdgeInsets.only(
                  left: AppSizes.kDefaultPadding / 2,
                  top: 2.0,
                ),
                child: Icon(
                  iconPath,
                  color:
                      iconColor ??
                      Theme.of(context).colorScheme.surfaceContainer,
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
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      labelColor ??
                      Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
