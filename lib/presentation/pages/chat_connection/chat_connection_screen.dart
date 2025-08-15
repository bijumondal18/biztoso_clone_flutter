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
  const ChatConnectionScreen({super.key});

  @override
  State<ChatConnectionScreen> createState() => _ChatConnectionScreenState();
}

class _ChatConnectionScreenState extends State<ChatConnectionScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchCtrl.text = context.read<UserBloc>().connectionsQuery;
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetConnectionsEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          scrolledUnderElevation: AppSizes.elevationSmall,
          leading: AppbarIcon(onPressed: () => appRouter.pop()),
          title: Text(
            'Start New Conversation',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
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
                onChanged: (q) => context.read<UserBloc>().add(
                  SearchConnectionsChanged(query: q),
                ),
                onClear: () {
                  _searchCtrl.clear();
                  context.read<UserBloc>().add(
                    SearchConnectionsChanged(query: ''),
                  );
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
