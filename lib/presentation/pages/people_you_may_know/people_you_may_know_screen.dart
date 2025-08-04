import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/connection/components/build_connections_list.dart';
import 'package:biztoso/presentation/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';

import '../../../core/navigation/app_router.dart';
import '../../widgets/appbar_icon.dart';

class PeopleYouMayKnowScreen extends StatefulWidget {
  const PeopleYouMayKnowScreen({super.key});

  @override
  State<PeopleYouMayKnowScreen> createState() => _PeopleYouMayKnowScreenState();
}

class _PeopleYouMayKnowScreenState extends State<PeopleYouMayKnowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Text(
          'People You May Know',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.kDefaultPadding,
          vertical: AppSizes.kDefaultPadding / 2,
        ),
        children: [
          CustomSearchbar(searchHintText: 'Search Peoples ...'),
          // Padding(
          //   padding: const EdgeInsets.only(top: AppSizes.kDefaultPadding / 2),
          //   child: Text(
          //     'People You May Know',
          //     style: Theme.of(
          //       context,
          //     ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.kDefaultPadding),
            child: BuildConnectionsList(),
          ),
        ],
      ),
    );
  }
}
