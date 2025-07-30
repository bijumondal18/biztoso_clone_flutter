import 'package:biztoso/core/navigation/app_router.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar_icon.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: AppbarIcon(onPressed: () => appRouter.pop())),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
