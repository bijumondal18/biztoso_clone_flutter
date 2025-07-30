import 'dart:developer';

import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/data/models/language.dart';
import 'package:biztoso/presentation/pages/language_selection/widgets/language_tile.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/themed_statusbar_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/app_images.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return ThemedStatusBarWrapper(
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(AppImages.splashBg, fit: BoxFit.cover),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSizes.kDefaultPadding / 2,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppSizes.kDefaultPadding,
                      ),
                      child: Text(
                        'Select Language',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    Text(
                      'Choose your preferred language for a \npersonalized experience.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Expanded(
                      child: Column(
                        children: languageList
                            .map(
                              (lang) => LanguageTile(
                                language: lang,
                                onTap: () {
                                  setState(() {
                                    for (var l in languageList) {
                                      l.isSelected = false;
                                    }
                                    lang.isSelected = true;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    CustomPrimaryButton(
                      label: 'Continue',
                      onPressed: () {
                        final selected = languageList.firstWhere(
                          (lang) => lang.isSelected,
                        );
                        if (selected != null) {
                          log('Selected language: ${selected.subTitle}');
                          appRouter.push(Screens.login);
                        } else {
                          log('No language selected');
                        }
                      },
                    ),
                    const SizedBox(height: AppSizes.kDefaultPadding),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
