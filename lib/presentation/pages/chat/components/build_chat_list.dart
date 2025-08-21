import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/presentation/pages/chat/components/chat_list_shimmer.dart';
import 'package:biztoso/presentation/pages/chat/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/horizontal_divider.dart';
import '../../../widgets/profile_avatar.dart';

class BuildChatList extends StatefulWidget {
  const BuildChatList({super.key});

  @override
  State<BuildChatList> createState() => _BuildChatListState();
}

class _BuildChatListState extends State<BuildChatList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is ChatListStateLoading) {
          return const ChatListShimmer();
        }
        if (state is ChatListStateLoaded) {
          var items = state.chatListResponse.chats ?? [];
          if (items.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text(
                  'No chats found',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainer.withAlpha(150),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: items.length,
            padding: EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding),
            itemBuilder: (context, index) {
              return ChatCard(chat: items[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 76),
                child: HorizontalDivider(),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
