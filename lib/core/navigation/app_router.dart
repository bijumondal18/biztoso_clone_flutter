import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/data/models/chat_list_response.dart';
import 'package:biztoso/data/models/language.dart';
import 'package:biztoso/presentation/pages/auth/identity_verification_document_type/identity_verification_document_type_screen.dart';
import 'package:biztoso/presentation/pages/auth/verification/verification_screen.dart';
import 'package:biztoso/presentation/pages/chat_connection/chat_connection_screen.dart';
import 'package:biztoso/presentation/pages/chat_inbox/chat_inbox_screen.dart';
import 'package:biztoso/presentation/pages/connection_invitations/connection_invitations_screen.dart';
import 'package:biztoso/presentation/pages/create_post/create_post_screen.dart';
import 'package:biztoso/presentation/pages/create_post_preview/create_post_preview_screen.dart';
import 'package:biztoso/presentation/pages/global_search/global_search_screen.dart';
import 'package:biztoso/presentation/pages/language_selection/language_selection_screen.dart';
import 'package:biztoso/presentation/pages/people_you_may_know/people_you_may_know_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../presentation/blocs/post/selected_media_for_post_cubit.dart';
import '../../presentation/pages/auth/login/login_screen.dart';
import '../../presentation/pages/auth/profile/profile_screen.dart';
import '../../presentation/pages/auth/view_or_edit_profile_picture/view_or_edit_profile_picture_screen.dart';
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
      builder: (context, state) {
        // final languageList = state.extra as List<Language>;
        return LanguageSelectionScreen();
      },
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
    GoRoute(
      path: Screens.peopleYoyMayKnow,
      name: 'peopleYoyMayKnow',
      builder: (context, state) {
        final isPublicProfile = state.extra as bool;
        return PeopleYouMayKnowScreen(isPublicProfile: isPublicProfile);
      },
    ),
    GoRoute(
      path: Screens.connectionInvitations,
      name: 'connectionInvitations',
      builder: (context, state) => ConnectionInvitationsScreen(),
    ),
    GoRoute(
      path: Screens.chatConnection,
      name: 'chatConnection',
      builder: (context, state) {
        final extra = state.extra;
        bool isPublicProfile = false;
        bool isComingFromChat = false;
        String userId = '';
        String profileName = '';

        if (extra is List && extra.length >= 4) {
          final first = extra[0];
          final second = extra[1];
          final third = extra[2];
          final fourth = extra[3];

          if (first is bool) isPublicProfile = first;
          if (second != null) userId = second.toString();
          if (third != null) profileName = third.toString();
          if (fourth is bool) isComingFromChat = fourth;
        }
        return ChatConnectionScreen(
          isPublicProfile: isPublicProfile,
          userId: userId,
          profileName: profileName,
          isComingFromChat: isComingFromChat,
        );
      },
    ),
    GoRoute(
      path: Screens.chatInbox,
      name: 'chatInbox',
      builder: (context, state) {
        final Chats? chats = state.extra as Chats;
        return ChatInboxScreen(chats: chats);
      },
    ),
    GoRoute(
      path: Screens.createPost,
      name: 'createPost',
      builder: (context, state) => CreatePostScreen(),
    ),
    GoRoute(
      path: Screens.createPostPreview,
      name: 'createPostPreview',
      builder: (context, state) {
        final mediaCubit = state.extra as SelectedMediaForPostCubit;
        return BlocProvider.value(
          value: mediaCubit,
          child: CreatePostPreviewScreen(),
        );
      },
    ),
    GoRoute(
      path: Screens.editProfilePic,
      name: 'editProfilePic',
      pageBuilder: (context, state) {
        final extra = state.extra;
        bool isPublicProfile = false;
        String imageUrl = '';
        bool isCoverPicture = false;

        if (extra is List && extra.length >= 3) {
          final first = extra[0];
          final second = extra[1];
          final third = extra[2];
          if (first is bool) isPublicProfile = first;
          if (second != null) imageUrl = second.toString();
          if (third is bool) isCoverPicture = third;
        }
        return CustomTransitionPage(
          barrierColor: Colors.transparent,
          opaque: false, // <-- this is the key
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: ViewOrEditProfilePictureScreen(
            imageUrl: imageUrl,
            isPublicProfile: isPublicProfile,
            isCoverPicture: isCoverPicture,
          ),
        );
      },
    ),
    GoRoute(
      path: Screens.verification,
      name: 'verification',
      builder: (context, state) {
        return VerificationScreen();
      },
    ),
    GoRoute(
      path: Screens.identityVerificationDocumentType,
      name: 'identityVerificationDocumentType',
      builder: (context, state) {
        return IdentityVerificationDocumentTypeScreen();
      },
    ),
    // GoRoute(
    //   path: Screens.editProfilePic,
    //   name: 'editProfilePic',
    //   builder: (context, state) {
    //     final imageUrl = state.extra as String;
    //     return ProfilePictureViewScreen(profilePic: imageUrl);
    //   },
    // ),
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
        final extra = state.extra;
        bool isPublicProfile = false;
        String userId = '';

        if (extra is List && extra.length >= 2) {
          final first = extra[0];
          final second = extra[1];

          if (first is bool) isPublicProfile = first;
          if (second != null) userId = second.toString();
        }
        return ProfileScreen(isPublicProfile: isPublicProfile, userId: userId);
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
