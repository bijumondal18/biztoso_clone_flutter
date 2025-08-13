import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/navigation/screens.dart';
import '../../../../core/themes/app_sizes.dart';
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
        AppbarIcon(onPressed: () {},
            hasGradient: false,
            iconPath: EvaIcons.bellOutline),
        Padding(
          padding: const EdgeInsets.only(
            right: AppSizes.kDefaultPadding,
            left: AppSizes.kDefaultPadding / 2,
          ),
          child: ProfileAvatar(
            onPressed: () => appRouter.push(Screens.profile, extra: false),
            imageUrl:
            'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
