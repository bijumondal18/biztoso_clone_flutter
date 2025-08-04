import 'dart:developer';

import 'package:biztoso/core/resources/app_images.dart';
import 'package:biztoso/presentation/widgets/themed_statusbar_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/navigation/screens.dart';
import '../../blocs/user/user_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetLanguageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ThemedStatusBarWrapper(
      child: Scaffold(
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is GetLanguageStateLoaded) {
              appRouter.go(
                Screens.languageSelection,
                extra: state.getLanguage.result,
              );
            }
            if (state is GetLanguageStateFailed) {
              log(state.error);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SvgPicture.asset(AppImages.splashBg, fit: BoxFit.cover),
                Center(
                  child: Text(
                    'Biztoso',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 56.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
