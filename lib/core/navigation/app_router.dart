import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/presentation/pages/global_search/global_search_screen.dart';
import 'package:biztoso/presentation/pages/language_selection/language_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/auth/login/login_screen.dart';
import '../../presentation/pages/auth/profile/profile_screen.dart';
import '../../presentation/pages/main_bottom_nav/main_bottom_nav_screen.dart';
import '../../presentation/pages/splash/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Screens.splash,
  routes: [
    GoRoute(
      path: Screens.splash,
      name: 'splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: Screens.languageSelection,
      name: 'languageSelection',
      builder: (context, state) => LanguageSelectionScreen(),
    ),
    GoRoute(
      path: Screens.login,
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: Screens.main,
      name: 'main',
      builder: (context, state) => MainBottomNavScreen(),
    ),
    GoRoute(
      path: Screens.globalSearch,
      name: 'globalSearch',
      builder: (context, state) => GlobalSearchScreen(),
    ),
    // GoRoute(
    //   path: Screens.analytics,
    //   name: 'analytics',
    //   pageBuilder: (context, state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     child: const AnalyticsScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final tween = Tween<Offset>(
    //         begin: const Offset(0, -1), // Bottom of the screen
    //         end: Offset.zero,
    //       ).chain(CurveTween(curve: Curves.easeInOut));
    //
    //       return SlideTransition(
    //         position: animation.drive(tween),
    //         child: child,
    //       );
    //     },
    //   ),
    // ),
    GoRoute(
      path: Screens.profile,
      name: 'profile',
      builder: (context, state) {
        final isPublicProfile = state.extra as bool;
        return ProfileScreen(isPublicProfile: isPublicProfile);
      },
    ),
    // GoRoute(
    //   path: Screens.editProfile,
    //   name: 'editProfile',
    //   builder: (context, state) => EditProfileScreen(),
    // ),
    // GoRoute(
    //   path: Screens.editProfileField,
    //   name: 'edit_profile_field',
    //   pageBuilder: (context, state) {
    //     final flag = state.extra as String;
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: EditFieldScreen(flag: flag),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         final tween = Tween<Offset>(
    //           begin: const Offset(0, 1), // Bottom of the screen
    //           end: Offset.zero,
    //         ).chain(CurveTween(curve: Curves.easeInOut));
    //
    //         return SlideTransition(
    //           position: animation.drive(tween),
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: Screens.settings,
    //   name: 'settings',
    //   builder: (context, state) => SettingsScreen(),
    // ),
    // GoRoute(
    //   path: Screens.followingAndFollowers,
    //   name: 'following_and_followers',
    //   pageBuilder: (context, state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     child: const FollowingAndFollowerScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final tween = Tween<Offset>(
    //         begin: const Offset(0, 1), // Bottom of the screen
    //         end: Offset.zero,
    //       ).chain(CurveTween(curve: Curves.easeInOut));
    //
    //       return SlideTransition(
    //         position: animation.drive(tween),
    //         child: child,
    //       );
    //     },
    //   ),
    // ),
    // GoRoute(
    //   path: Screens.notification,
    //   name: 'notification',
    //   builder: (context, state) => NotificationScreen(),
    // ),
    // GoRoute(
    //   path: Screens.profilePictureView,
    //   name: 'profile_picture_view',
    //   pageBuilder: (context, state) => CustomTransitionPage(
    //     barrierColor: Colors.transparent,
    //     opaque: false, // <-- this is the key
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: animation, child: child);
    //     },
    //     child: ProfilePictureViewScreen(),
    //   ),
    // ),
    // GoRoute(
    //   path: Screens.fullScreenMediaView,
    //   name: 'full_screen_media_view',
    //   pageBuilder: (context, state) {
    //     final media = state.extra as Media;
    //     return CustomTransitionPage(
    //       barrierColor: Colors.transparent,
    //       opaque: false, // <-- this is the key
    //       child: FullScreenMediaViewScreen(media: media),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(opacity: animation, child: child);
    //       },
    //     );
    //   },
    // ),
  ],
);
