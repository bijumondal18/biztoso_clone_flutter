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

class ProfilePictureViewScreen extends StatefulWidget {
  final String profilePic;

  const ProfilePictureViewScreen({super.key, required this.profilePic});

  @override
  State<ProfilePictureViewScreen> createState() =>
      _ProfilePictureViewScreenState();
}

class _ProfilePictureViewScreenState extends State<ProfilePictureViewScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () => appRouter.pop(),
      child: Scaffold(
        appBar: AppBar(
          leading: AppbarIcon(onPressed: () => context.pop(Screens.profile)),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              // Profile Avatar Image
              Center(
                child: ProfileAvatar(
                  imageUrl: widget.profilePic,
                  radius: width * 0.8,
                  onPressed: () {},
                ),
              ),
              Spacer(),
              Spacer(),

              // Bottom Buttons for Update profile image, edit profile image and remove profile image
              Padding(
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
                        borderColor: Theme.of(context).primaryColor,
                        labelColor: Theme.of(context).primaryColor,
                        iconColor: Theme.of(context).primaryColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
