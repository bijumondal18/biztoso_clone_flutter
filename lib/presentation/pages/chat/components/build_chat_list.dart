import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
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
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ChatListStateLoading) {}
        if (state is ChatListStateLoaded) {
          var items = state.chatListResponse.chats ?? [];
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
