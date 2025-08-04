import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/themes/app_sizes.dart';

class BuildConnectionsList extends StatefulWidget {
  final String? screenFlag;

  const BuildConnectionsList({super.key, this.screenFlag = 'connectionScreen'});

  @override
  State<BuildConnectionsList> createState() => _BuildConnectionsListState();
}

class _BuildConnectionsListState extends State<BuildConnectionsList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.kDefaultPadding / 2),
          child: Text(
            widget.screenFlag == 'peopleYouMayKnow'
                ? 'People You May Know'
                : '36 Connections',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        ListView.separated(
          itemCount: 36,
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding / 2,
                vertical: AppSizes.kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withAlpha(100),
                borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
                border: Border.all(
                  width: 1.0,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              child: Row(
                spacing: AppSizes.kDefaultPadding,
                children: [
                  ProfileAvatar(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuNhTZJTtkR6b-ADMhmzPvVwaLuLdz273wvQ&s',
                    onPressed: () =>
                        appRouter.push(Screens.profile, extra: true),
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
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Networking Professional',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: Theme.of(context).hintColor),
                        ),
                      ],
                    ),
                  ),
                  CustomPrimaryButton(
                    label: _buildTrailingButtonLabel(
                      screenFlag: widget.screenFlag ?? 'connectionScreen',
                    ),
                    onPressed: () {},
                    hasIcon: true,
                    iconPath: _buildTrailingButtonIcon(
                      screenFlag: widget.screenFlag ?? 'connectionScreen',
                    ),
                    height: AppSizes.smallButtonHeight,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: AppSizes.kDefaultPadding / 2),
        ),
      ],
    );
  }

  String _buildTrailingButtonLabel({required String screenFlag}) {
    switch (screenFlag) {
      case 'connectionScreen':
        return 'Message';
      case 'peopleYouMayKnow':
        return 'Connect';
    }
    return 'Message';
  }

  IconData _buildTrailingButtonIcon({required String screenFlag}) {
    switch (screenFlag) {
      case 'connectionScreen':
        return Iconsax.message5;
      case 'peopleYouMayKnow':
        return CupertinoIcons.person_add_solid;
    }
    return Iconsax.message5;
  }
}
