import 'package:biztoso/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/themes/app_sizes.dart';
import '../../../../widgets/custom_primary_button.dart';

class VerifyNowButton extends StatelessWidget {
  final bool isVerifiedAll;

  const VerifyNowButton({super.key, required this.isVerifiedAll});

  @override
  Widget build(BuildContext context) {
    return isVerifiedAll
        ? Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.greenLight,
              border: Border.all(
                width: 0.5,
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainer.withAlpha(80),
              ),
              borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
            ),
            height: AppSizes.smallButtonHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSizes.kDefaultPadding / 2,
                    top: 2.0,
                  ),
                  child: Icon(
                    Iconsax.verify5,
                    color: AppColors.white,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.kDefaultPadding / 2,
                  ),
                  child: Text(
                    'Verified',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        : CustomPrimaryButton(
            label: 'Verify Now',
            height: AppSizes.smallButtonHeight,
            hasIcon: true,
            iconPath: Iconsax.verify5,
            onPressed: () {},
          );
  }
}
