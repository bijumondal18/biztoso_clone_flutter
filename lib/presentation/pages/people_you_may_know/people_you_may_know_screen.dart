import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/connection/components/build_connections_list.dart';
import 'package:biztoso/presentation/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';

import '../../../core/navigation/app_router.dart';
import '../../widgets/appbar_icon.dart';

class PeopleYouMayKnowScreen extends StatefulWidget {
  final bool isPublicProfile;

  const PeopleYouMayKnowScreen({super.key, this.isPublicProfile = false});

  @override
  State<PeopleYouMayKnowScreen> createState() => _PeopleYouMayKnowScreenState();
}

class _PeopleYouMayKnowScreenState extends State<PeopleYouMayKnowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: AppBar(
        centerTitle: true,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Visibility(
          visible: widget.isPublicProfile == true,
          child: Text(
            'Ranjan\'s Connections',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.kDefaultPadding,
          vertical: AppSizes.kDefaultPadding / 2,
        ),
        children: [
          /// Searchbar
          CustomSearchbar(searchHintText: 'Search Peoples ...'),

          /// Build Connections List
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.kDefaultPadding),
            child: SafeArea(
              child: BuildConnectionsList(
                screenFlag: 'peopleYouMayKnow',
                isPublicProfile: widget.isPublicProfile,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
