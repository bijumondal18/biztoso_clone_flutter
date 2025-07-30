import 'package:biztoso/core/extensions/status_bar_configs.dart';
import 'package:flutter/material.dart';

import '../core/navigation/app_router.dart';
import '../core/themes/theme.dart';

class BiztosoApp extends StatelessWidget {
  const BiztosoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
