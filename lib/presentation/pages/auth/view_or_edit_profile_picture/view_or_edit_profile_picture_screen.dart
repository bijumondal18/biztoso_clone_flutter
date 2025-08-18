import 'dart:ui';

import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/custom_secondary_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/screens.dart';
import '../../../widgets/profile_avatar.dart';

class ViewOrEditProfilePictureScreen extends StatefulWidget {
  final String imageUrl;
  final bool isPublicProfile;
  final bool isCoverPicture;

  const ViewOrEditProfilePictureScreen({
    super.key,
    required this.imageUrl,
    required this.isPublicProfile,
    this.isCoverPicture = false,
  });

  @override
  State<ViewOrEditProfilePictureScreen> createState() =>
      _ViewOrEditProfilePictureScreenState();
}

class _ViewOrEditProfilePictureScreenState
    extends State<ViewOrEditProfilePictureScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () => appRouter.pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Blur + translucent background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  color: Colors.black.withOpacity(0.7), // semi-transparent tint
                ),
              ),
            ),

            // Close Button
            Positioned(
              left: 0,
              top: 0,
              child: SafeArea(
                child: AppbarIcon(
                  onPressed: () => context.pop(Screens.profile),
                ),
              ),
            ),

            Positioned(
              top: AppSizes.kDefaultPadding,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Center(
                  child: Text(
                    widget.isCoverPicture ? 'Cover Photo' : 'Profile Photo',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),

            // Profile Avatar Image
            Center(
              child: Hero(
                tag: 'profile_image/${widget.imageUrl}',
                child: ProfileAvatar(
                  imageUrl: widget.imageUrl,
                  radius: width * 0.85,
                  onPressed: () {},
                ),
              ),
            ),

            // Bottom Buttons for Update profile image, edit profile image and remove profile image
            Positioned(
              bottom: AppSizes.kDefaultPadding,
              left: 0,
              right: 0,
              child: Visibility(
                visible: !widget.isPublicProfile,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.kDefaultPadding,
                    ),
                    child: Row(
                      spacing: AppSizes.kDefaultPadding / 2,
                      children: [
                        Expanded(
                          child: CustomPrimaryButton(
                            label: 'Update',
                            hasIcon: true,
                            iconPath: Icons.camera_alt_rounded,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: CustomSecondaryButton(
                            label: 'Edit',
                            hasIcon: true,
                            iconPath: Icons.edit,
                            borderColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                            labelColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                            iconColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                            bgColor: Theme.of(context).scaffoldBackgroundColor,
                            hasBorder: true,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: CustomSecondaryButton(
                            label: 'Remove',
                            hasIcon: true,
                            labelColor: AppColors.errorDark,
                            iconColor: AppColors.errorDark,
                            bgColor: Theme.of(context).scaffoldBackgroundColor,
                            borderColor: AppColors.errorDark,
                            hasBorder: true,
                            iconPath: Icons.delete_rounded,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
