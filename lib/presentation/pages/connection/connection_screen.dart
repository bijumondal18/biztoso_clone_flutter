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
        title: Text(
          'Connections',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        children: [
          InvitationsButton(onPressed: () {}),
          HorizontalDivider(),
          PeopleYouMayKnowButton(onPressed: (){},),
          HorizontalDivider(),
          CustomSearchbar(searchHintText: 'Search Connections ...',),
          BuildConnectionsList()
        ],
      ),
    );
  }
}
