import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/auth/profile/widgets/verified_badge.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/custom_outline_button.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../blocs/user/user_bloc.dart';
import 'components/profile_screen_shimmer.dart';

class ProfileScreen extends StatefulWidget {
  final bool isPublicProfile;

  const ProfileScreen({super.key, this.isPublicProfile = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserBloc()..add(FetchProfileDetailsEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is FetchUserProfileStateLoading) {
              return const ProfileScreenShimmer();
            }
            if (state is FetchUserProfileStateLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: AppbarIcon(onPressed: () => appRouter.pop()),
                    actions: [
                      Visibility(
                        visible: widget.isPublicProfile == false,
                        child: AppbarIcon(
                          onPressed: () {},
                          iconPath: EvaIcons.edit,
                        ),
                      ),
                    ],
                    expandedHeight: 200.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        '${state.profileResponse.result?.coverPhoto}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.kDefaultPadding,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: widget.isPublicProfile == false,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AppbarIcon(
                                    onPressed: () {},
                                    iconPath: Iconsax.share5,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.isPublicProfile == true,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomOutlineButton(
                                    label: 'Send Message',
                                    onPressed: () {},
                                    hasIcon: true,
                                    height: AppSizes.smallButtonHeight,
                                    iconPath: Iconsax.message5,
                                    labelColor: Theme.of(context).primaryColor,
                                    iconColor: Theme.of(context).primaryColor,
                                    borderColor: Theme.of(context).primaryColor,
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
                                            value: 'Edit',
                                            height: 30,
                                            child: Row(
                                              spacing:
                                                  AppSizes.kDefaultPadding / 2,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  EvaIcons.edit,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceContainer,
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
                                              spacing:
                                                  AppSizes.kDefaultPadding / 2,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  EvaIcons.save,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceContainer,
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
                                              spacing:
                                                  AppSizes.kDefaultPadding / 2,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  EvaIcons.archive,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceContainer,
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
                                            value: 'Archived',
                                            height: 30,
                                            child: Row(
                                              spacing:
                                                  AppSizes.kDefaultPadding / 2,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.analytics,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceContainer,
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
                                            value: 'Archived',
                                            height: 30,
                                            child: Row(
                                              spacing:
                                                  AppSizes.kDefaultPadding / 2,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.analytics,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceContainer,
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
                                            value: 'Archived',
                                            height: 30,
                                            child: Row(
                                              spacing:
                                                  AppSizes.kDefaultPadding / 2,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.analytics,
                                                  size: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceContainer,
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
                                          AppSizes.kDefaultPadding / 3,
                                        ),
                                        margin: EdgeInsets.only(
                                          right: AppSizes.kDefaultPadding / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
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
                            children: [
                              Row(
                                spacing: AppSizes.kDefaultPadding,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: AppSizes.kDefaultPadding / 2,
                                      children: [
                                        Text(
                                          '${state.profileResponse.result?.fullName}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineMedium,
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
                                              '${state.profileResponse.result?.email}',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelLarge,
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
                                              '${state.profileResponse.result?.phoneNumber}',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelLarge,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () => appRouter.push(
                                        Screens.peopleYoyMayKnow,
                                        extra: widget.isPublicProfile == true
                                            ? true
                                            : false,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.cardCornerRadius,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          AppSizes.kDefaultPadding,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.cardCornerRadius,
                                          ),
                                        ),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text:
                                                '${state.profileResponse.result?.connectionCount}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                            children: [
                                              TextSpan(
                                                text:
                                                    state
                                                                .profileResponse
                                                                .result
                                                                ?.connectionCount ==
                                                            0 ||
                                                        state
                                                                .profileResponse
                                                                .result
                                                                ?.connectionCount ==
                                                            1
                                                    ? '\nConnection'
                                                    : '\nConnections',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSizes.kDefaultPadding,
                                ),
                                child: Text(
                                  '${state.profileResponse.result?.userinfo?.first.userBio}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        HorizontalDivider(),
                        Padding(
                          padding: const EdgeInsets.all(
                            AppSizes.kDefaultPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: AppSizes.kDefaultPadding,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Verified Badges',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Visibility(
                                      visible: widget.isPublicProfile == false,
                                      child: CustomPrimaryButton(
                                        label: 'Verify Now',
                                        height: AppSizes.smallButtonHeight,
                                        hasIcon: true,
                                        iconPath: Iconsax.verify5,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: AppSizes.kDefaultPadding,
                                children: [
                                  Flexible(
                                    child: VerifiedBadge(
                                      iconData: Iconsax.call5,
                                      isVerified:
                                          state
                                              .profileResponse
                                              .result
                                              ?.phoneVerify ??
                                          false,
                                    ),
                                  ),
                                  Flexible(
                                    child: VerifiedBadge(
                                      iconData: Icons.email,
                                      isVerified:
                                          state
                                              .profileResponse
                                              .result
                                              ?.emailVerify ??
                                          false,
                                    ),
                                  ),
                                  Flexible(
                                    child: VerifiedBadge(
                                      iconData: Icons.person,
                                      isVerified:
                                          state
                                              .profileResponse
                                              .result
                                              ?.documentVerify ??
                                          false,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        HorizontalDivider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.kDefaultPadding,
                                vertical: AppSizes.kDefaultPadding / 2,
                              ),
                              child: Text(
                                'Social Presence',
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const ProfileScreenShimmer();
          },
        ),
      ),
    );
  }
}
