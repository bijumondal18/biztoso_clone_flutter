import 'package:biztoso/presentation/widgets/custom_outline_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/navigation/screens.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../widgets/custom_primary_button.dart';
import '../../../widgets/profile_avatar.dart';

class ConnectionCard extends StatelessWidget {
  final String screenFlag;

  const ConnectionCard({super.key, required this.screenFlag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding / 2,
        vertical: AppSizes.kDefaultPadding / 1.2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor.withAlpha(100),
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
      ),
      child: Row(
        spacing: AppSizes.kDefaultPadding,
        children: [
          ProfileAvatar(
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuNhTZJTtkR6b-ADMhmzPvVwaLuLdz273wvQ&s',
            onPressed: () => appRouter.push(Screens.profile, extra: true),
            // isPublicProfile = true
            radius: 48,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.0,
              children: [
                Text(
                  'Wade Warren',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Networking Professional',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          _buildTrailingButton(context: context, screenFlag: screenFlag),
        ],
      ),
    );
  }

  Widget _buildTrailingButton({
    required BuildContext context,
    required String screenFlag,
  }) {
    switch (screenFlag) {
      case 'connectionScreen':
        return CustomPrimaryButton(
          label: 'Message',
          onPressed: () {},
          hasIcon: true,
          iconPath: Iconsax.message5,
          height: AppSizes.smallButtonHeight,
        );
      case 'peopleYouMayKnow':
        return CustomPrimaryButton(
          label: 'Connect',
          onPressed: () {},
          hasIcon: true,
          iconPath: CupertinoIcons.person_add_solid,
          height: AppSizes.smallButtonHeight,
        );
      case 'receivedInvitation':
        return Row(
          spacing: AppSizes.kDefaultPadding / 2,
          children: [
            CustomPrimaryButton(
              label: 'Accept',
              onPressed: () {},
              height: AppSizes.smallButtonHeight,
            ),
            CustomOutlineButton(
              label: 'Decline',
              onPressed: () {},
              labelColor: Theme.of(context).colorScheme.error,
              borderColor: Theme.of(context).colorScheme.error,
              height: AppSizes.smallButtonHeight,
            ),
          ],
        );
      case 'sentInvitation':
        return CustomOutlineButton(
          label: 'Cancel Request',
          onPressed: () {},
          labelColor: Theme.of(context).colorScheme.surfaceContainer,
          borderColor: Theme.of(context).colorScheme.surfaceContainer,
          height: AppSizes.smallButtonHeight,
        );
    }
    return CustomPrimaryButton(
      label: 'Message',
      onPressed: () {},
      hasIcon: true,
      iconPath: Iconsax.message5,
      height: AppSizes.smallButtonHeight,
    );
  }
}
