import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/data/models/profile_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../../core/navigation/app_router.dart';
import '../../../../../core/resources/app_images.dart';
import '../../../../../core/themes/app_sizes.dart';
import '../../../../widgets/appbar_icon.dart';
import 'dart:ui' show lerpDouble;

class BuildProfileAppBar extends StatelessWidget {
  final bool isPublicProfile;
  final ProfileResponse profileResponse;

  const BuildProfileAppBar({
    super.key,
    required this.isPublicProfile,
    required this.profileResponse,
  });

  @override
  Widget build(BuildContext context) {
    const double kExpandedHeight = 210; // cover height
    const double kAvatarMax = 122; // expanded diameter
    const double kAvatarMin = 48; // collapsed diameter (smaller than before)
    const double kLeadingWidth = 42; // default AppBar leading space

    return SliverAppBar(
      pinned: true,
      expandedHeight: kExpandedHeight,
      leading: AppbarIcon(onPressed: () => appRouter.pop()),
      actions: [
        Visibility(
          visible: isPublicProfile == false,
          child: AppbarIcon(
            onPressed: () => appRouter.push(
              Screens.editProfilePic,
              extra: [
                isPublicProfile,
                profileResponse.result?.coverPhoto,
                true, // isCoverPhoto = true
              ],
            ),
            iconPath: Icons.edit,
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
              ((kExpandedHeight - top) / (kExpandedHeight - collapsedHeight))
                  .clamp(0.0, 1.0);

          final avatarSize = lerpDouble(kAvatarMax, kAvatarMin, t)!;

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
                  imageUrl: '${profileResponse.result?.coverPhoto}',
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _defaultAvatar(context),
                  errorWidget: (_, __, ___) => _defaultAvatar(context),
                ),
              ),

              // Shrinking/moving avatar
              Positioned(
                left: leftOffset,
                bottom: bottomOffset,
                child: InkResponse(
                  onTap: () => appRouter.push(
                    Screens.editProfilePic,
                    extra: [
                      isPublicProfile,
                      profileResponse.result?.profilePic,
                      false, // isCoverPhoto == false
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                    child: Hero(
                      tag:
                          'profile_image/${profileResponse.result?.profilePic}',
                      child: CircleAvatar(
                        radius: avatarSize / 2,
                        backgroundImage:
                            (profileResponse.result?.profilePic?.isNotEmpty ??
                                false)
                            ? NetworkImage(
                                profileResponse.result?.profilePic ?? '',
                              )
                            : const AssetImage(AppImages.avatarPlaceholder)
                                  as ImageProvider,
                        backgroundColor: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _defaultAvatar(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Image.asset(
      AppImages.avatarPlaceholder,
      width: width,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
