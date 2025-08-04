import 'package:flutter/material.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
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
            'Connection Invitations',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: TabBar(
              tabs: [
                Tab(text: 'Recieved'),
                Tab(text: 'Sent'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.kDefaultPadding),
                  child: SafeArea(
                    child: BuildConnectionsList(
                      screenFlag: 'receivedInvitation',
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.kDefaultPadding),
                  child: SafeArea(
                    child: BuildConnectionsList(screenFlag: 'sentInvitation'),
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
