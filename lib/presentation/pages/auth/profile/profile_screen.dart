import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  final bool isPublicProfile;

  const ProfileScreen({super.key, required this.isPublicProfile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: AppbarIcon(onPressed: () => appRouter.pop()),
            actions: [AppbarIcon(onPressed: () {}, iconPath: EvaIcons.edit)],
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://static-cse.canva.com/blob/1145215/1.magebyRodionKutsaevviaUnsplash.jpg',
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppbarIcon(
                          onPressed: () {},
                          iconPath: Iconsax.share5,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppbarIcon(
                          onPressed: () {},
                          iconPath: EvaIcons.moreVertical,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: AppSizes.kDefaultPadding / 4,
                              children: [
                                Text(
                                  'Nitish Ranjan',
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
                                      'kushal8@8844shop.com',
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
                                      '1234567889',
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
                            child: Container(
                              padding: EdgeInsets.all(
                                AppSizes.kDefaultPadding / 2,
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
                                  text: '6',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                  children: [
                                    TextSpan(
                                      text: '\nConnections',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ],
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
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vitae velit ex. Mauris dapibus risus quis suscipit vulputate. Egestas purus viverra accumsan in nisl nisi. Pharetra pharetra massa massa ultricies mi quis. At in tellus integer feugiat scelerisque varius morbi enim nunc.',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                HorizontalDivider(),
                Padding(
                  padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSizes.kDefaultPadding,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Verified Badges',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: CustomPrimaryButton(
                              label: 'Verify Now',
                              height: AppSizes.smallButtonHeight,
                              hasIcon: true,
                              iconPath: Iconsax.verify5,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: AppSizes.kDefaultPadding,
                        children: [
                          Container(
                            padding: EdgeInsets.all(
                              AppSizes.kDefaultPadding / 1.5,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(
                                AppSizes.cardCornerRadius * 2,
                              ),
                            ),
                            child: Icon(
                              Iconsax.call5,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              size: 36,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              AppSizes.kDefaultPadding / 1.5,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(
                                AppSizes.cardCornerRadius * 2,
                              ),
                            ),
                            child: Icon(
                              Icons.email,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              size: 36,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              AppSizes.kDefaultPadding / 1.5,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.secondaryGradient,
                              borderRadius: BorderRadius.circular(
                                AppSizes.cardCornerRadius * 2,
                              ),
                            ),
                            child: Icon(
                              Icons.person,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              size: 36,
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
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding, vertical: AppSizes.kDefaultPadding/2),
                      child: Text(
                        'Social Presence',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
