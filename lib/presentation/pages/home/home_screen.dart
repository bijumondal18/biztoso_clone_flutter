import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/home/components/create_new_post_card.dart';
import 'package:biztoso/presentation/pages/home/components/home_appbar.dart';
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
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor.withAlpha(50),
      appBar: HomeAppbar(),
      body: ListView(
        children: [
          CreateNewPostCard(),
        ],
      ),
    );
  }
}
