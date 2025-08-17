import 'package:biztoso/data/models/chat_list_response.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../widgets/appbar_icon.dart';

class ChatInboxScreen extends StatefulWidget {
  final Chats? chats;

  const ChatInboxScreen({super.key,  this.chats});

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
              imageUrl: '${widget.chats?.user?.profileImage}',
              radius: 38,
              onPressed: () {},
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppUtils.firstNonEmptyTitle([
                    widget.chats?.user?.userFullName,
                  ]),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.chats?.isOnline == true ? 'Online' : 'Offline',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: widget.chats?.isOnline == true
                        ? Colors.green
                        : Theme.of(context).hintColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              size: 24,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
          ),
        ],
      ),
      body: ListView(children: []),
    );
  }
}
