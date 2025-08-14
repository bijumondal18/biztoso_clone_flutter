import 'dart:developer';

import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/data/models/language.dart';
import 'package:biztoso/presentation/pages/language_selection/widgets/language_tile.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/themed_statusbar_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/app_images.dart';
import '../../blocs/user/user_bloc.dart';

class LanguageSelectionScreen extends StatefulWidget {

  const LanguageSelectionScreen({super.key,});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  List<Color> getCardColors(BuildContext context) {
    if (Theme.of(context).brightness != Brightness.dark) {
      return [AppColors.darkColor1, AppColors.darkColor2, AppColors.darkColor3];
    } else {
      return [
        AppColors.lightColor1,
        AppColors.lightColor2,
        AppColors.lightColor3,
      ];
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = getCardColors(context);
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
                      child: BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          if(state is GetLanguageStateLoaded){

                          }
                        },
                        builder: (context, state) {
                          if(state is GetLanguageStateLoading){

                          }
                          if(state is GetLanguageStateLoaded){
                            return ListView.builder(
                              itemCount:  state.getLanguage.result?.length,
                              itemBuilder: (context, index) {
                                return LanguageTile(
                                  language: state.getLanguage.result![index],
                                  bgColor: colors[index % colors.length],
                                  isSelected: selectedIndex == index,
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    CustomPrimaryButton(
                      label: 'Continue',
                      onPressed: () {
                        if (selectedIndex != null) {
                          // final selectedLang =
                          //     widget.languageList[selectedIndex];
                          // log(
                          //   'Selected language: ${selectedLang.languageNameEnglish}',
                          // );
                          appRouter.push(Screens.login);
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
