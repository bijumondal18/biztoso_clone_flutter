import 'package:biztoso/core/api_service/app_preference.dart';
import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/more/widgets/more_tile.dart';
import 'package:biztoso/presentation/widgets/custom_outline_button.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:flutter/material.dart';

import '../../../data/models/more_options.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'More',
          style: Theme
              .of(
            context,
          )
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: moreOptionsList
                  .map(
                    (moreOptions) =>
                    MoreTile(onPressed: () {
                      if (moreOptions.label == 'Settings') {
                        appRouter.push(Screens.settings);
                      }
                    }, moreOptions: moreOptions),
              )
                  .toList(),
            ),
            HorizontalDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding,
                vertical: AppSizes.kDefaultPadding,
              ),
              child: Text(
                'Support',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
            ),
            Column(
              children: supportOptionsList
                  .map(
                    (moreOptions) =>
                    MoreTile(
                      onPressed: () {
                        if (moreOptions.label == "Logout") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Theme
                                    .of(context)
                                    .cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.cardCornerRadius,
                                  ),
                                ),
                                content: Column(
                                  spacing: AppSizes.kDefaultPadding,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.error_rounded,
                                      color: AppColors.errorDark,
                                      size: 64,
                                    ),
                                    Text(
                                      'Are you sure?',
                                      style: Theme
                                          .of(
                                        context,
                                      )
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      'This will log you out from this device. You will need to sign in again.',
                                      textAlign: TextAlign.center,
                                      style: Theme
                                          .of(
                                        context,
                                      )
                                          .textTheme
                                          .bodyLarge,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: AppSizes.kDefaultPadding,
                                      ),
                                      child: Row(
                                        spacing: AppSizes.kDefaultPadding,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: CustomOutlineButton(
                                              label: 'Cancel',
                                              onPressed: () => appRouter.pop(),
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomPrimaryButton(
                                              label: 'Logout',
                                              onPressed: () {
                                                AppPreference.clearPreference();
                                                appRouter.go(Screens.login);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        if (moreOptions.label == 'Knowledge Base') {
                          appRouter.push(Screens.knowledgeBase);
                        }
                        if (moreOptions.label == 'Blog') {
                          appRouter.push(Screens.blogs);
                        }
                      },
                      moreOptions: moreOptions,
                    ),
              )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding,
                vertical: AppSizes.kDefaultPadding * 3,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'App Version : v1.0.5 (234)',
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
