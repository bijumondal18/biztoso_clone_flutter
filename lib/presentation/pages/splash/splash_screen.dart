import 'package:biztoso/core/resources/app_images.dart';
import 'package:biztoso/presentation/widgets/themed_statusbar_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/navigation/screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Navigating Login Screen after 1 seconds
    Future.delayed(const Duration(milliseconds: 1000), () {
      appRouter.go(Screens.languageSelection);
    });
  }


  @override
  Widget build(BuildContext context) {
    return ThemedStatusBarWrapper(
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(AppImages.splashBg, fit: BoxFit.cover),
            Center(
              child: Text(
                'Biztoso',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 56.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
