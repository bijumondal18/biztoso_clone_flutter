import 'package:biztoso/data/models/profile_response.dart';
import 'package:biztoso/presentation/pages/auth/profile/components/build_connections_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/navigation/app_router.dart';
import '../../../../../core/navigation/screens.dart';
import '../../../../../core/themes/app_sizes.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../widgets/appbar_icon.dart';
import '../../../../widgets/custom_outline_button.dart';
import '../../../../widgets/horizontal_divider.dart';
import '../widgets/verified_badge.dart';
import '../widgets/verify_now_button.dart';
import 'build_social_presence_list.dart';

class BuildProfileBody extends StatelessWidget {
  final bool isPublicProfile;
  final ProfileResponse profileResponse;

  const BuildProfileBody({
    super.key,
    required this.isPublicProfile,
    required this.profileResponse,
  });

  @override
  Widget build(BuildContext context) {
    String? bio = '';
    if (profileResponse.result != null &&
        profileResponse.result?.userinfo != null &&
        profileResponse.result!.userinfo!.isNotEmpty &&
        profileResponse.result!.userinfo!.first != null &&
        profileResponse.result!.userinfo!.first.userBio != null &&
        profileResponse.result!.userinfo!.first.userBio!.isNotEmpty) {
      bio = profileResponse.result!.userinfo!.first.userBio;
    }

    bool isIdentityVerified = profileResponse.result?.documentVerify == true;
    bool isEmailVerified = profileResponse.result?.emailVerify == true;
    bool isPhoneVerified = profileResponse.result?.phoneVerify == true;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.kDefaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: isPublicProfile == false,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AppbarIcon(
                      onPressed: () {},
                      iconPath: EvaIcons.share,
                    ),
                  ),
                ),
                Visibility(
                  visible: isPublicProfile == true,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: AppSizes.kDefaultPadding,
                      ),
                      child: CustomOutlineButton(
                        label: 'Offline',
                        onPressed: () {},
                        height: AppSizes.smallButtonHeight,
                        labelColor: Theme.of(context).hintColor,
                        iconColor: Theme.of(context).hintColor,
                        borderColor: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isPublicProfile == true,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomOutlineButton(
                      label: 'Send Message',
                      onPressed: () {},
                      hasIcon: true,
                      height: AppSizes.smallButtonHeight,
                      iconPath: Iconsax.message5,
                      labelColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainer,
                      iconColor: Theme.of(context).colorScheme.surfaceContainer,
                      borderColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainer,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      popupMenuTheme: PopupMenuThemeData(
                        color: Theme.of(context).dividerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius,
                          ),
                        ),
                      ),
                    ),
                    child: PopupMenuButton(
                      onSelected: (value) {},
                      elevation: AppSizes.elevationLarge,
                      borderRadius: BorderRadius.circular(
                        AppSizes.cardCornerRadius,
                      ),
                      surfaceTintColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      position: PopupMenuPosition.under,
                      menuPadding: EdgeInsets.symmetric(
                        vertical: AppSizes.kDefaultPadding,
                      ),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'EditProfile',
                              height: 30,
                              onTap: () => appRouter.push(Screens.editProfile),
                              child: Row(
                                spacing: AppSizes.kDefaultPadding / 2,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    EvaIcons.edit,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                  ),
                                  Text(
                                    'Edit Profile',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Saved',
                              height: 30,
                              child: Row(
                                spacing: AppSizes.kDefaultPadding / 2,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    EvaIcons.save,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                  ),
                                  Text(
                                    'Saved',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Archived',
                              height: 30,
                              child: Row(
                                spacing: AppSizes.kDefaultPadding / 2,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    EvaIcons.archive,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                  ),
                                  Text(
                                    'Archived',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'ProfileAnalytics',
                              height: 30,
                              onTap: () => appRouter.push(Screens.profileAnalytics),
                              child: Row(
                                spacing: AppSizes.kDefaultPadding / 2,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.analytics,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                  ),
                                  Text(
                                    'Profile Analytics',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'FeedAnalytics',
                              height: 30,
                              child: Row(
                                spacing: AppSizes.kDefaultPadding / 2,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.analytics,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                  ),
                                  Text(
                                    'Feed Analytics',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'StoreAnalytics',
                              height: 30,
                              child: Row(
                                spacing: AppSizes.kDefaultPadding / 2,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.analytics,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                  ),
                                  Text(
                                    'Store Analytics',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                      child: IconButton(
                        onPressed: null,
                        icon: Container(
                          padding: EdgeInsets.all(
                            AppSizes.kDefaultPadding / 2.2,
                          ),
                          margin: EdgeInsets.only(
                            right: AppSizes.kDefaultPadding / 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppSizes.cardCornerRadius,
                            ),
                          ),
                          child: Icon(
                            EvaIcons.moreVertical,
                            color: Theme.of(context).primaryColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.kDefaultPadding,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  spacing: AppSizes.kDefaultPadding,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSizes.kDefaultPadding / 2,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              AppUtils.firstNonEmptyTitle([
                                profileResponse.result?.fullName,
                              ]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Row(
                            spacing: AppSizes.kDefaultPadding / 2,
                            children: [
                              Icon(
                                EvaIcons.email,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer,
                                size: 16,
                              ),
                              Text(
                                '${profileResponse.result?.email}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            spacing: AppSizes.kDefaultPadding / 2,
                            children: [
                              Icon(
                                EvaIcons.phone,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer,
                                size: 16,
                              ),
                              Text(
                                '${profileResponse.result?.phoneNumber}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Build Connections Count Card
                    BuildConnectionsWidget(
                      isPublicProfile: isPublicProfile,
                      profileResponse: profileResponse,
                    ),
                  ],
                ),

                /// Build User Bio
                Visibility(
                  visible: bio != null && bio.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSizes.kDefaultPadding,
                    ),
                    child: Text(
                      bio ?? '',
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          HorizontalDivider(),

          /// Build User Verified Badges
          Padding(
            padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.kDefaultPadding,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Verified Badges',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    /// Verify button
                    Visibility(
                      visible: !isPublicProfile,
                      child: VerifyNowButton(
                        isVerified:
                            isIdentityVerified &&
                            isEmailVerified &&
                            isPhoneVerified,
                        onPressed: () => appRouter.push(Screens.verification),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: AppSizes.kDefaultPadding,
                  children: [
                    Flexible(
                      child: VerifiedBadge(
                        iconData: Icons.call,
                        isVerified:
                            profileResponse.result?.phoneVerify ?? false,
                      ),
                    ),
                    Flexible(
                      child: VerifiedBadge(
                        iconData: Icons.email,
                        isVerified:
                            profileResponse.result?.emailVerify ?? false,
                      ),
                    ),
                    Flexible(
                      child: VerifiedBadge(
                        iconData: Icons.person,
                        isVerified:
                            profileResponse.result?.documentVerify ?? false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: profileResponse.result!.socialmedia!.isNotEmpty,
            child: HorizontalDivider(),
          ),

          /// Build Social Presence List
          Visibility(
            visible: profileResponse.result!.socialmedia!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.kDefaultPadding,
                    vertical: AppSizes.kDefaultPadding,
                  ),
                  child: Text(
                    'Social Presence',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSizes.kDefaultPadding,
                  ),
                  child: BuildSocialPresenceList(
                    socialMedia: profileResponse.result?.socialmedia ?? [],
                    isPublicProfile: isPublicProfile,
                    onAdd: (platform, link) {
                      // context.read<UserBloc>().add(AddSocialLinkEvent(platform: platform, link: link));
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.kDefaultPadding),
          // HorizontalDivider(),
        ],
      ),
    );
  }
}
