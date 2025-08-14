import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../widgets/appbar_icon.dart';

class ChatInboxScreen extends StatefulWidget {
  const ChatInboxScreen({super.key});

  @override
  State<ChatInboxScreen> createState() => _ChatInboxScreenState();
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: AppSizes.elevationSmall,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        titleSpacing: 10,
        title: Row(
          spacing: AppSizes.kDefaultPadding / 2,
          children: [
            ProfileAvatar(
              imageUrl:
                  'https://static-cse.canva.com/blob/2121234/1600w-B-cRyoh7b98.jpg',
              radius: 38,
              onPressed: () {},
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kushal Kumar',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Online',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [],
      ),
      body: ListView(children: []),
    );
  }
}
