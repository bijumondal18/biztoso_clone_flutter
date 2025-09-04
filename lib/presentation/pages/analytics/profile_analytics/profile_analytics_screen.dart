import 'package:biztoso/core/resources/app_images.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/presentation/pages/analytics/profile_analytics/components/profile_analytics_shimmer.dart';
import 'package:biztoso/presentation/widgets/custom_card.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:biztoso/presentation/widgets/string_dropdown.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/appbar_icon.dart';

class ProfileAnalyticsScreen extends StatefulWidget {
  const ProfileAnalyticsScreen({super.key});

  @override
  State<ProfileAnalyticsScreen> createState() => _ProfileAnalyticsScreenState();
}

class _ProfileAnalyticsScreenState extends State<ProfileAnalyticsScreen> {
  final List<String> _dropdownValues = [
    'Last 7 Days',
    'Current Month',
    'Current Year',
  ];
  String? selectedValue = 'Last 7 Days';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(FetchProfileAnalyticsEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: AppbarIcon(onPressed: () => appRouter.pop()),
          title: Text(
            'Profile Analytics',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is FetchUserProfileAnalyticsStateLoading) {
              return const ProfileAnalyticsShimmerList();
            }
            if (state is FetchUserProfileAnalyticsStateLoaded) {
              return ListView(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.kDefaultPadding,
                  horizontal: AppSizes.kDefaultPadding,
                ),
                children: [
                  /// Dropdown button for 7 days, 1 month etc...
                  StringDropdown(
                    items: _dropdownValues,
                    selectedValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  const SizedBox(height: AppSizes.kDefaultPadding),

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
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          spacing: AppSizes.kDefaultPadding,
                          children: [
                            ProfileAvatar(
                              imageUrl:
                                  '${state.profileAnalyticsResponse.result?.profilePic}',
                              onPressed: () {},
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.profileAnalyticsResponse.result?.fullName}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  AppUtils.firstNonEmptyTitle([
                                    '${state.profileAnalyticsResponse.result?.businessType}',
                                  ]),
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
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
                            Text(
                              '${state.profileAnalyticsResponse.result?.strength}%',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value:
                              state.profileAnalyticsResponse.result!.strength! *
                              0.1,
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
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: AppSizes.kDefaultPadding,
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                AppImages.imgAnalytics,
                                width: double.infinity,
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(
                                  AppSizes.kDefaultPadding,
                                ),
                                child: Column(
                                  spacing: AppSizes.kDefaultPadding / 2,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Profile Strength',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: AppColors.black),
                                    ),
                                    Text(
                                      '${state.profileAnalyticsResponse.result?.strength}%',
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
                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppSizes.kDefaultPadding,
                          ),
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    AppUtils.firstNonEmptyTitle([
                                      (state
                                          .profileAnalyticsResponse
                                          .result
                                          ?.improvement
                                          ?.join(' & ')),
                                    ]),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
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
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          spacing: AppSizes.kDefaultPadding,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                  top: AppSizes.kDefaultPadding,
                                ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        spacing: AppSizes.kDefaultPadding / 2,
                                        children: [
                                          Text(
                                            'Total Views',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: AppColors.black,
                                                ),
                                          ),
                                          Text(
                                            '${state.profileAnalyticsResponse.result?.totalViewByDateRange}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                  color: AppColors.greenDark,
                                                ),
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
                                margin: EdgeInsets.only(
                                  top: AppSizes.kDefaultPadding,
                                ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        spacing: AppSizes.kDefaultPadding / 2,
                                        children: [
                                          Text(
                                            'Views this week',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: AppColors.black,
                                                ),
                                          ),
                                          Text(
                                            '${state.profileAnalyticsResponse.result?.totalViewOfCurrentWeek}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                  color: AppColors.greenDark,
                                                ),
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
                          padding: const EdgeInsets.only(
                            top: AppSizes.kDefaultPadding,
                          ),
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
                                    '${state.profileAnalyticsResponse.result?.comparedToLastMonth}%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Compare to the last month',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge,
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
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: AppSizes.kDefaultPadding,
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                AppImages.imgAnalytics,
                                width: double.infinity,
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(
                                  AppSizes.kDefaultPadding,
                                ),
                                child: Column(
                                  spacing: AppSizes.kDefaultPadding / 2,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Search Appearances',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: AppColors.black),
                                    ),
                                    Text(
                                      '${state.profileAnalyticsResponse.result?.searchAppearanceCount}',
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
                      ],
                    ),
                  ),

                  /// Audience Geo Distribution Card
                  CustomCard(
                    padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                    margin: EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Audience Geo Distribution',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSizes.kDefaultPadding / 2),
                        Text(
                          'Audience Geo Distribution',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: Theme.of(context).hintColor),
                        ),
                        const SizedBox(height: AppSizes.kDefaultPadding),
                        Wrap(
                          spacing: AppSizes.kDefaultPadding * 2,
                          runSpacing: AppSizes.kDefaultPadding * 2,
                          children: state
                              .profileAnalyticsResponse
                              .result!
                              .geoDistribution!
                              .map((item) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: AppSizes.kDefaultPadding / 4,
                                  children: [
                                    Text(
                                      item.state ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      item.percentage ?? '',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    ),
                                  ],
                                );
                              })
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.kDefaultPadding),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSizes.kDefaultPadding,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Image.asset(
                          AppImages.icBulb,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Why These Matters: These 7 Matrics Can Directly Guide User Decisions - What To Sell, How To Price, What To Remove, And How To Improve',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                  const SafeArea(
                    child: SizedBox(height: AppSizes.kDefaultPadding),
                  ),
                ],
              );
            }
            return const ProfileAnalyticsShimmerList();
          },
        ),
      ),
    );
  }
}
