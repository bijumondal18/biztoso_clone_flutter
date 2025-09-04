import 'package:biztoso/core/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_sizes.dart';

class VerifiedBadge extends StatelessWidget {
  final IconData iconData;
  final bool isVerified;
  final double radius;

  const VerifiedBadge({
    super.key,
    required this.iconData,
    required this.isVerified,
    this.radius = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            gradient: isVerified
                ? AppColors.primaryGradient
                : AppColors.secondaryGradient,
            borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius * 2),
          ),
          child: Icon(iconData, color: AppColors.white, size: radius * 0.5),
        ),
        Visibility(
          visible: isVerified,
          child: Positioned(
            right: -8,
            top: -8,
            child: SvgPicture.asset(
              AppImages.icGreenCheck,
              width: 28,
              height: 28,
            ),
          ),
        ),
      ],
    );
  }
}
