import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_sizes.dart';

class VerifiedBadge extends StatelessWidget {
  final IconData iconData;
  final bool isVerified;

  const VerifiedBadge({
    super.key,
    required this.iconData,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 60,
          height: 64,
          child: Stack(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: isVerified
                      ? AppColors.primaryGradient
                      : AppColors.secondaryGradient,
                  borderRadius: BorderRadius.circular(
                    AppSizes.cardCornerRadius*1.8,
                  ),
                ),
                child: Icon(
                  iconData,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 36,
                ),
              ),
              Visibility(
                visible: isVerified,
                child: Positioned(
                  right: 0,
                  top: -3,
                  child: Icon(
                    Iconsax.verify5,
                    color: Colors.green,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
