import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/chat/components/build_chat_list.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user/user_bloc.dart';
import '../../widgets/custom_searchbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetChatListEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Inbox',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSizes.kDefaultPadding,
                right: AppSizes.kDefaultPadding / 3,
                bottom: AppSizes.kDefaultPadding / 2,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomSearchbar(
                      searchHintText: 'Search here ...',
                      controller: _searchCtrl,
                      onChanged: (q) =>
                          context.read<UserBloc>().add(SearchChatsChanged(q)),
                      onClear: () {
                        _searchCtrl.clear();
                        context.read<UserBloc>().add(SearchChatsChanged(''));
                      },
                    ),
                  ),
                  AppbarIcon(
                    onPressed: () => appRouter.push(
                      Screens.chatConnection,
                      extra: [
                        false, // isPublicProfile - required here
                        '', //userID - not needed here
                        '', // profileName - not needed here
                        true, // isComingFromChat - required here
                      ],
                    ),
                    hasGradient: false,
                    iconPath: EvaIcons.plus,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(child: BuildChatList()),
      ),
    );
  }
}
