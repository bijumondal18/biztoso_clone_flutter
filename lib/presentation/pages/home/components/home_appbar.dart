import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/navigation/screens.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/appbar_icon.dart';
import '../../../widgets/profile_avatar.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Biztoso',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w900,
        ),
      ),
      actions: [
        AppbarIcon(
          onPressed: () => appRouter.push(Screens.globalSearch),
          hasGradient: false,
          iconPath: EvaIcons.search,
        ),
        AppbarIcon(
          onPressed: () {},
          hasGradient: false,
          iconPath: EvaIcons.bellOutline,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: AppSizes.kDefaultPadding,
            left: AppSizes.kDefaultPadding / 2,
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is FetchUserProfileStateLoaded) {
                String profileImage =
                    state.profileResponse.result?.profilePic ?? '';
                return ProfileAvatar(
                  onPressed: () =>
                      appRouter.push(Screens.profile, extra: false),
                  imageUrl: profileImage,
                );
              }
              return ProfileAvatar(
                onPressed: () =>
                    appRouter.push(Screens.profile, extra: false),
                imageUrl: '',
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
