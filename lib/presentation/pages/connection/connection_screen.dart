import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/connection/components/build_connections_list.dart';
import 'package:biztoso/presentation/pages/connection/components/invitations_button.dart';
import 'package:biztoso/presentation/pages/connection/components/people_you_may_know_button.dart';
import 'package:biztoso/presentation/widgets/custom_searchbar.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user/user_bloc.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final _searchCtrl = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(const GetConnectionsEvent(page: 1));
    });

    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }


  void _onScroll() {
    final bloc = context.read<UserBloc>();
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      // near the bottom → fetch more
      bloc.add(GetConnectionsEvent(page: bloc.currentPage + 1));
    }
  }

  Future<void> _refreshConnections() async {
    final bloc = context.read<UserBloc>();
    bloc.add(GetConnectionsEvent(page: 1));
    // wait until done so the spinner stops at the right time
    await bloc.stream.firstWhere(
      (s) => s is GetConnectionsStateLoaded || s is GetConnectionsStateFailed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connections')),
      body: RefreshIndicator.adaptive(
        onRefresh: _refreshConnections,
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: ListView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(), // important
          children: [
            InvitationsButton(
              onPressed: () => appRouter.push(Screens.connectionInvitations),
            ),
            const HorizontalDivider(),
            BlocProvider(
              create: (context) => UserBloc()..add(AllConnectionsListEvent()),
              child: PeopleYouMayKnowButton(
                onPressed: () =>
                    appRouter.push(Screens.peopleYoyMayKnow, extra: false),
              ),
            ),
            const HorizontalDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding,
                vertical: AppSizes.kDefaultPadding,
              ),
              child: CustomSearchbar(
                searchHintText: 'Search Connections ...',
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding,
              ),
              child: const BuildConnectionsList(), // no internal scroll
            ),
            const SizedBox(height: AppSizes.kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
