import 'package:biztoso/core/resources/app_images.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/presentation/widgets/custom_card.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../widgets/appbar_icon.dart';

class ProfileAnalyticsScreen extends StatefulWidget {
  const ProfileAnalyticsScreen({super.key});

  @override
  State<ProfileAnalyticsScreen> createState() => _ProfileAnalyticsScreenState();
}

class _ProfileAnalyticsScreenState extends State<ProfileAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: AppSizes.elevationSmall,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Text(
          'Profile Analytics',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.kDefaultPadding,
          horizontal: AppSizes.kDefaultPadding,
        ),
        children: [
          /// Profile Overview Card
          CustomCard(
            padding: EdgeInsets.all(AppSizes.kDefaultPadding),
            margin: EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.kDefaultPadding,
              children: [
                Text(
                  'Profile Overview',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  spacing: AppSizes.kDefaultPadding,
                  children: [
                    ProfileAvatar(imageUrl: 'imageUrl', onPressed: () {}),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Princep',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          'business name',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: Theme.of(context).hintColor),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile Strength',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text('50%', style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                LinearProgressIndicator(
                  value: 0.5,
                  minHeight: AppSizes.kDefaultPadding / 2,
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.greenDark, // no color animation
                  ),
                  backgroundColor: Theme.of(context).dividerColor,
                ),
              ],
            ),
          ),

          /// Profile Completion Score Card
          CustomCard(
            padding: EdgeInsets.all(AppSizes.kDefaultPadding),
            margin: EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Completion Score',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: AppSizes.kDefaultPadding),
                  child: Stack(
                    children: [
                      Image.asset(
                        AppImages.imgAnalytics,
                        width: double.infinity,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                        child: Column(
                          spacing: AppSizes.kDefaultPadding / 2,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profile Strength',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: AppColors.black),
                            ),
                            Text(
                              '60%',
                              style: Theme.of(context).textTheme.headlineLarge!
                                  .copyWith(color: AppColors.greenDark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.kDefaultPadding),
                  child: Row(
                    spacing: AppSizes.kDefaultPadding,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.icSuggestedImprovement,
                        width: 40,
                        height: 40,
                      ),
                      Column(
                        spacing: 2.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Suggested Improvements',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Add Profile Picture & Add Bio',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Profile Views  Card
          CustomCard(
            padding: EdgeInsets.all(AppSizes.kDefaultPadding),
            margin: EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Views',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  spacing: AppSizes.kDefaultPadding,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: AppSizes.kDefaultPadding),
                        child: Stack(
                          children: [
                            Image.asset(
                              AppImages.imgAnalyticsSmall,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                AppSizes.kDefaultPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Views',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.black),
                                  ),
                                  Text(
                                    '25',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: AppColors.greenDark),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: AppSizes.kDefaultPadding),
                        child: Stack(
                          children: [
                            Image.asset(
                              AppImages.imgAnalyticsSmall,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                AppSizes.kDefaultPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Views this week',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.black),
                                  ),
                                  Text(
                                    '50',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: AppColors.greenDark),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.kDefaultPadding),
                  child: Row(
                    spacing: AppSizes.kDefaultPadding,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.icCompareLastMonth,
                        width: 40,
                        height: 40,
                      ),
                      Column(
                        spacing: 2.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '+368%',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Compare to the last month',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Search to profile view rate card
          CustomCard(
            padding: EdgeInsets.all(AppSizes.kDefaultPadding),
            margin: EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search To Profile View Rate',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: AppSizes.kDefaultPadding),
                  child: Stack(
                    children: [
                      Image.asset(
                        AppImages.imgAnalytics,
                        width: double.infinity,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                        child: Column(
                          spacing: AppSizes.kDefaultPadding / 2,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Search Appearances',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: AppColors.black),
                            ),
                            Text(
                              '68',
                              style: Theme.of(context).textTheme.headlineLarge!
                                  .copyWith(color: AppColors.greenDark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SafeArea(child: SizedBox()),
        ],
      ),
    );
  }
}
