import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/auth/profile/widgets/verified_badge.dart';
import 'package:biztoso/presentation/pages/auth/profile/widgets/verify_now_button.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/custom_outline_button.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/app_images.dart';
import '../../../blocs/user/user_bloc.dart';
import 'components/profile_screen_shimmer.dart';
import 'dart:ui' show lerpDouble;

class ProfileScreen extends StatefulWidget {
  final bool isPublicProfile;
  final String? userId;

  const ProfileScreen({super.key, this.isPublicProfile = false, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const double kExpandedHeight = 200; // cover height
  static const double kAvatarMax = 112; // expanded diameter
  static const double kAvatarMin =
      44; // collapsed diameter (smaller than before)
  static const double kLeadingWidth = 36; // default AppBar leading space

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            UserBloc()..add(FetchProfileDetailsEvent(userId: widget.userId)),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is FetchUserProfileStateLoading) {
              return const ProfileScreenShimmer();
            }
            if (state is FetchUserProfileStateLoaded) {
              bool isVerifiedAll = false;
              if (state.profileResponse.result?.emailVerify == true &&
                  state.profileResponse.result?.phoneVerify == true &&
                  state.profileResponse.result?.documentVerify == true) {
                isVerifiedAll = true;
              } else {
                isVerifiedAll = true;
              }
              String? bio = '';
              if (state.profileResponse.result != null &&
                  state.profileResponse.result?.userinfo != null &&
                  state.profileResponse.result!.userinfo!.isNotEmpty &&
                  state.profileResponse.result!.userinfo!.first != null &&
                  state.profileResponse.result!.userinfo!.first.userBio !=
                      null &&
                  state
                      .profileResponse
                      .result!
                      .userinfo!
                      .first
                      .userBio!
                      .isNotEmpty) {
                bio = state.profileResponse.result!.userinfo!.first.userBio;
              }
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: kExpandedHeight,
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
                    // ⚠️ No `bottom:` here — allows full collapse
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final top = constraints.biggest.height;
                        final statusBar = MediaQuery.paddingOf(context).top;
                        final collapsedHeight = kToolbarHeight + statusBar;

                        // 0 = fully expanded, 1 = fully collapsed
                        final t =
                            ((kExpandedHeight - top) /
                                    (kExpandedHeight - collapsedHeight))
                                .clamp(0.0, 1.0);

                        final avatarSize = lerpDouble(
                          kAvatarMax,
                          kAvatarMin,
                          t,
                        )!;

                        // When expanded: hang half below the appbar
                        // When collapsed: vertically centered in toolbar (ignores status bar)
                        final bottomOffset = lerpDouble(
                          -kAvatarMax / 2, // expanded
                          (kToolbarHeight - kAvatarMin) / 2, // collapsed
                          t,
                        )!;

                        // When expanded: normal page padding
                        // When collapsed: sit just to the right of the back button area
                        final leftOffset = lerpDouble(
                          AppSizes.kDefaultPadding, // expanded
                          kLeadingWidth + AppSizes.kDefaultPadding,
                          // collapsed (next to back)
                          t,
                        )!;

                        return Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            // 1) Cover image (fades OUT as we collapse)
                            Opacity(
                              opacity: 1 - t,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${state.profileResponse.result?.coverPhoto}',
                                fit: BoxFit.cover,
                                placeholder: (_, __) => _defaultAvatar(),
                                errorWidget: (_, __, ___) => _defaultAvatar(),
                              ),
                            ),

                            // Shrinking/moving avatar
                            Positioned(
                              left: leftOffset,
                              bottom: bottomOffset,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(
                                        context,
                                      ).shadowColor.withOpacity(0.08),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: avatarSize / 2,
                                  backgroundImage:
                                      (state
                                              .profileResponse
                                              .result
                                              ?.profilePic
                                              ?.isNotEmpty ??
                                          false)
                                      ? NetworkImage(
                                          state
                                              .profileResponse
                                              .result!
                                              .profilePic!,
                                        )
                                      : const AssetImage(
                                              'assets/images/avatar_placeholder.png',
                                            )
                                            as ImageProvider,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).dividerColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  /// rest of your content
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: AppSizes.kDefaultPadding / 2,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 4.0,
                                          ),
                                          child: Text(
                                            AppUtils.firstNonEmptyTitle([
                                              state
                                                  .profileResponse
                                                  .result
                                                  ?.fullName,
                                            ]),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineMedium,
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
                                              '${state.profileResponse.result?.email}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
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
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// Build Connections Count Card
                                  _buildConnectionWidget(state),
                                ],
                              ),

                              /// Build User Bio
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSizes.kDefaultPadding,
                                ),
                                child: Text(
                                  bio ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        HorizontalDivider(),

                        /// Build User Verified Badges
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
                                  Text(
                                    'Verified Badges',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),

                                  /// Verify button
                                  Visibility(
                                    visible: widget.isPublicProfile == false,
                                    child: VerifyNowButton(
                                      isVerifiedAll: isVerifiedAll,
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

  Widget _buildConnectionWidget(FetchUserProfileStateLoaded state) {
    return InkWell(
      onTap: () => appRouter.push(
        Screens.chatConnection,
        extra: [
          widget.isPublicProfile,
          state.profileResponse.result?.sId,
          state.profileResponse.result?.fullName,
          false, // isComingFromChat
        ],
      ),
      borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
      child: Container(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '${state.profileResponse.result?.connectionCount}',
            style: Theme.of(context).textTheme.titleLarge,
            children: [
              TextSpan(
                text:
                    state.profileResponse.result?.connectionCount == 0 ||
                        state.profileResponse.result?.connectionCount == 1
                    ? '\nConnection'
                    : '\nConnections',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _overlappedAvatar({
    required String? imageUrl,
    required bool showTick,
  }) {
    const double size = 112; // avatar diameter
    return SliverToBoxAdapter(
      child: SizedBox(
        // gives room for the avatar to overlap upwards
        height: size / 2 + AppSizes.kDefaultPadding,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: AppSizes.kDefaultPadding,
              top: -(size / 2), // pull up half the avatar to overlap the banner
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // white ring + avatar
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).shadowColor.withOpacity(0.08),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: size / 2,
                      backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
                          ? NetworkImage(imageUrl)
                          : const AssetImage(
                                  'assets/images/avatar_placeholder.png',
                                )
                                as ImageProvider,
                      backgroundColor: Theme.of(context).dividerColor,
                    ),
                  ),

                  // verification badge (bottom-right of avatar)
                  if (showTick)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppImages.icGreenCheck,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Image.asset(
      AppImages.avatarPlaceholder,
      width: MediaQuery.sizeOf(context).width,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
