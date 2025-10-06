import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/appbar_icon.dart';
import '../connection/components/build_connections_list.dart';

class ConnectionInvitationsScreen extends StatefulWidget {
  const ConnectionInvitationsScreen({super.key});

  @override
  State<ConnectionInvitationsScreen> createState() =>
      _ConnectionInvitationsScreenState();
}

class _ConnectionInvitationsScreenState
    extends State<ConnectionInvitationsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        /// Appbar
        appBar: AppBar(
          centerTitle: true,
          leading: AppbarIcon(onPressed: () => appRouter.pop()),
          title: Text(
            'Connection Invitations'
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: TabBar(
              tabs: [
                Tab(text: 'Received'),
                Tab(text: 'Sent'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // RECEIVED tab
            BlocProvider(
              create: (_) =>
                  UserBloc()..add(ReceivedRequestConnectionsListEvent()),
              child: Builder(
                builder: (context) => RefreshIndicator.adaptive(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  onRefresh: () async {
                    final bloc = context.read<UserBloc>();
                    bloc.add(ReceivedRequestConnectionsListEvent());
                    await bloc.stream.firstWhere(
                      (s) =>
                          s is ReceivedConnectionRequestStateLoaded ||
                          s is ReceivedConnectionRequestStateFailed,
                    );
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    // important
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.kDefaultPadding,
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: AppSizes.kDefaultPadding),
                        child: SafeArea(
                          child: BuildConnectionsList(
                            type: ConnectionListType.received,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // SENT tab
            BlocProvider(
              create: (_) => UserBloc()..add(SentRequestConnectionsListEvent()),
              child: Builder(
                builder: (context) => RefreshIndicator.adaptive(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  onRefresh: () async {
                    final bloc = context.read<UserBloc>();
                    bloc.add(SentRequestConnectionsListEvent());
                    await bloc.stream.firstWhere(
                      (s) =>
                          s is SentConnectionRequestStateLoaded ||
                          s is SentConnectionRequestStateFailed,
                    );
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.kDefaultPadding,
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: AppSizes.kDefaultPadding),
                        child: SafeArea(
                          child: BuildConnectionsList(
                            type: ConnectionListType.sent,
                            isPublicProfile: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
