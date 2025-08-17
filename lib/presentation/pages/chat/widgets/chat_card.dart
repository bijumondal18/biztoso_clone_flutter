import 'package:biztoso/data/models/chat_list_response.dart';
import 'package:biztoso/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/navigation/screens.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../../utils/app_utils.dart';
import '../../../widgets/profile_avatar.dart';

class ChatCard extends StatelessWidget {
  final Chats chat;

  const ChatCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final displayName = AppUtils.firstNonEmptyTitle([chat.user?.userFullName]);

    return InkWell(
      onTap: () => appRouter.push(Screens.chatInbox, extra: chat),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.kDefaultPadding,
          vertical: AppSizes.kDefaultPadding / 2,
        ),
        child: Row(
          spacing: AppSizes.kDefaultPadding,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Stack(
                children: [
                  ProfileAvatar(
                    imageUrl: '${chat.user?.profileImage}',
                    radius: 44,
                    onPressed: () => appRouter.push(
                      Screens.editProfilePic,
                      extra: [true, chat.user?.profileImage ?? '',],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: chat.isOnline == true
                            ? Colors.green
                            : Theme.of(context).hintColor.withAlpha(150),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.0,
                children: [
                  Text(
                    displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${chat.lastMessage}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainer.withAlpha(140),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 4.0,
              children: [
                Text(
                  DateTimeUtils.formatChatTimestamp(
                    chat.lastMessageAt.toString(),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: chat.unreadMessagesCount != 0
                        ? Theme.of(context).primaryColor
                        : Theme.of(
                            context,
                          ).colorScheme.surfaceContainer.withAlpha(180),
                  ),
                ),
                Visibility(
                  visible: chat.unreadMessagesCount != 0,
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      '${chat.unreadMessagesCount}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
