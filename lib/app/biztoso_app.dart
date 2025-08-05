import 'package:biztoso/app/global_bloc.dart';
import 'package:biztoso/core/extensions/status_bar_configs.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';

import '../core/api_service/connectivity_service.dart';
import '../core/navigation/app_router.dart';
import '../core/themes/theme.dart';

class BiztosoApp extends StatelessWidget {
  BiztosoApp({super.key});

  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  Widget build(BuildContext context) {
    return GlobalBloc(
      child: ValueListenableBuilder(
        valueListenable: _connectivityService.isOffline,
        builder: (context, offline, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: appRouter,
            scaffoldMessengerKey: SnackBarHelper.messengerKey,
            builder: (context, routerChild) {
              return Scaffold(
                body: Stack(
                  children: [
                    /// Main Widget
                    routerChild!,

                    /// No Internet Banner
                    if (offline)
                      SafeArea(
                        child: MaterialBanner(
                          content: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '🚫 No Internet Connection',
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                          actions: const [SizedBox.shrink()],
                          elevation: AppSizes.elevationSmall,
                          backgroundColor: AppColors.red.withAlpha(200),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
