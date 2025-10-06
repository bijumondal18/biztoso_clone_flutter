import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/chat/components/build_chat_list.dart';
import 'package:biztoso/presentation/pages/connection/components/build_connections_list.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/app_router.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/appbar_icon.dart';
import '../../widgets/custom_searchbar.dart';

class ChatConnectionScreen extends StatefulWidget {
  final bool isPublicProfile;
  final bool isComingFromChat;
  final String? userId;
  final String? profileName;

  const ChatConnectionScreen({
    super.key,
    required this.isPublicProfile,
    this.userId,
    this.profileName,
    this.isComingFromChat = false,
  });

  @override
  State<ChatConnectionScreen> createState() => _ChatConnectionScreenState();
}

class _ChatConnectionScreenState extends State<ChatConnectionScreen> {
  final _searchCtrl = TextEditingController();
  late final UserBloc _bloc; // <-- stable instance

  @override
  void initState() {
    super.initState();
    _bloc = UserBloc()
      ..add(GetConnectionsEvent(page: 1, userId: widget.userId)); // create once

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _searchCtrl.text = context.read<UserBloc>().connectionsQuery;
    // });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _bloc.close(); // dispose once
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: AppbarIcon(onPressed: () => appRouter.pop()),
          title: Text(
            widget.isPublicProfile
                ? '${widget.profileName}\'s Connection'
                : widget.isComingFromChat
                ? 'Start New Conversation'
                : ''
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSizes.kDefaultPadding,
                right: AppSizes.kDefaultPadding,
                bottom: AppSizes.kDefaultPadding / 2,
              ),
              child: CustomSearchbar(
                searchHintText: 'Search here ...',
                controller: _searchCtrl,
                onChanged: (q) => _bloc.add(SearchConnectionsChanged(query: q)),
                onClear: () {
                  _searchCtrl.clear();
                  _bloc.add(SearchConnectionsChanged(query: ''));
                },
              ),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.kDefaultPadding,
            vertical: AppSizes.kDefaultPadding,
          ),
          children: [SafeArea(child: BuildConnectionsList())],
        ),
      ),
    );
  }
}
