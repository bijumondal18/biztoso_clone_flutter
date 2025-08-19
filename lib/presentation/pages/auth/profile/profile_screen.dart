import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/auth/profile/components/build_profile_app_bar.dart';
import 'package:biztoso/presentation/pages/auth/profile/components/build_profile_body.dart';
import 'package:biztoso/presentation/pages/auth/profile/components/build_social_presence_list.dart';
import 'package:biztoso/presentation/pages/auth/profile/widgets/verified_badge.dart';
import 'package:biztoso/presentation/pages/auth/profile/widgets/verify_now_button.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/custom_outline_button.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/app_images.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/tab_header_delegate.dart';
import 'components/profile_screen_shimmer.dart';

class ProfileScreen extends StatefulWidget {
  final bool isPublicProfile;
  final String? userId;

  const ProfileScreen({super.key, this.isPublicProfile = false, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            UserBloc()..add(FetchProfileDetailsEvent(userId: widget.userId)),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is FetchUserProfileStateLoading) {
              return const ProfileScreenShimmer();
            }
            if (state is FetchUserProfileStateLoaded) {
              return DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxScrolled) => [
                    /// Profile Appbar Content with animation
                    BuildProfileAppBar(
                      isPublicProfile: widget.isPublicProfile,
                      profileResponse: state.profileResponse,
                    ),

                    /// rest of your content
                    BuildProfileBody(
                      isPublicProfile: widget.isPublicProfile,
                      profileResponse: state.profileResponse,
                    ),

                    /// Sticky TabBar right after the last divider
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: TabHeaderDelegate(
                        TabBar(
                          labelColor: Theme.of(context).primaryColor,
                          unselectedLabelColor: Theme.of(context).hintColor,
                          indicatorColor: Theme.of(context).primaryColor,
                          dividerColor: Theme.of(context).dividerColor,
                          dividerHeight: 0.8,
                          tabs: const [
                            Tab(text: 'Posts',),
                            Tab(text: 'Store'),
                          ],
                        ),
                      ),
                    ),
                  ],
                  body: TabBarView(children: [Container(), Container()]),
                ),
              );
            }
            return const ProfileScreenShimmer();
          },
        ),
      ),
    );
  }
}
