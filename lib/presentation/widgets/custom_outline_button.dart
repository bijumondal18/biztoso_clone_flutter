import 'package:flutter/material.dart';

import '../../core/themes/app_sizes.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? hasIcon;
  final IconData? iconPath;
  final bool hasRoundedCorner;

  const CustomOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.hasIcon = false,
    this.iconPath,
    this.hasRoundedCorner = false,
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
          border: Border.all(
            width: 0.5,
            color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(80),
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
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Icon(
                  iconPath,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  size: 18,
                ),
              ),
            ),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
