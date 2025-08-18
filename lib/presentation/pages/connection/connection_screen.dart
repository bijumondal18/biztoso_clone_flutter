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

  @override
  void initState() {
    super.initState();
    // Kick off the first load and restore any previous query text
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<UserBloc>();
      // if your bloc stores the last query, you can restore it:
      // _searchCtrl.text = bloc.connectionsQuery;  // optional
      bloc.add(GetConnectionsEvent());
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _refreshConnections() async {
    final bloc = context.read<UserBloc>();
    bloc.add(GetConnectionsEvent());
    // wait until done so the spinner stops at the right time
    await bloc.stream.firstWhere(
      (s) => s is GetConnectionsStateLoaded || s is GetConnectionsStateFailed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connections',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: _refreshConnections,
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: ListView(
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
