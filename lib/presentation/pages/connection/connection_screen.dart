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

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Connections',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        children: [
          InvitationsButton(onPressed: () {}),
          HorizontalDivider(),
          PeopleYouMayKnowButton(
            onPressed: () => appRouter.push(Screens.peopleYoyMayKnow),
          ),
          HorizontalDivider(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.kDefaultPadding,
              vertical: AppSizes.kDefaultPadding,
            ),
            child: CustomSearchbar(searchHintText: 'Search Connections ...'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
            child: BuildConnectionsList(),
          ),
        ],
      ),
    );
  }
}
