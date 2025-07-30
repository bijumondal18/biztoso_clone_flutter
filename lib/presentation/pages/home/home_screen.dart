import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor.withAlpha(50),
      appBar: AppBar(
        title: Text(
          'Biztoso',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          AppbarIcon(
            onPressed: () => appRouter.push(Screens.globalSearch),
            iconPath: EvaIcons.search,
          ),
          AppbarIcon(onPressed: () {}, iconPath: EvaIcons.bellOutline),
          Padding(
            padding: const EdgeInsets.only(
              right: AppSizes.kDefaultPadding,
              left: AppSizes.kDefaultPadding / 2,
            ),
            child: ProfileAvatar(
              onPressed: () => appRouter.push(Screens.profile, extra: false),
              imageUrl:
                  'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(AppSizes.kDefaultPadding),
            padding: EdgeInsets.all(AppSizes.kDefaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).dividerColor.withAlpha(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withAlpha(100),
                  spreadRadius: AppSizes.spreadRadius,
                  blurRadius: AppSizes.blurRadius
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.kDefaultPadding,
              children: [
                Row(
                  spacing: AppSizes.kDefaultPadding/2,
                  children: [
                    ProfileAvatar(
                      radius: 38,
                      imageUrl:
                          'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nitish Ranjan',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '@nitish123',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.all(AppSizes.kDefaultPadding/2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor.withAlpha(100),
                    borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius)
                  ),
                  child: Text(
                    'What\'s on your mind?',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
