import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor.withAlpha(50),
      appBar: AppBar(
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
            iconPath: EvaIcons.search,
          ),
          AppbarIcon(onPressed: () {}, iconPath: EvaIcons.bellOutline),
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
      ),
      body: ListView(children: []),
    );
  }
}
