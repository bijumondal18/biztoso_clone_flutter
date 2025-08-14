import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/connection/components/build_connections_list.dart';
import 'package:biztoso/presentation/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/app_router.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/appbar_icon.dart';

class PeopleYouMayKnowScreen extends StatefulWidget {
  final bool isPublicProfile;
  const PeopleYouMayKnowScreen({super.key, this.isPublicProfile = false});

  @override
  State<PeopleYouMayKnowScreen> createState() => _PeopleYouMayKnowScreenState();
}

class _PeopleYouMayKnowScreenState extends State<PeopleYouMayKnowScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      // single bloc for the whole screen
      create: (_) => UserBloc()..add(AllConnectionsListEvent()),
      child: Builder(
        builder: (context) {
          // restore previous query (optional)
          _searchCtrl.text = context.read<UserBloc>().pymkQuery;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: AppbarIcon(onPressed: () => appRouter.pop()),
              title: Visibility(
                visible: widget.isPublicProfile == true,
                child: Text(
                  "Ranjan's Connections",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kTextTabBarHeight),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppSizes.kDefaultPadding,
                    right: AppSizes.kDefaultPadding,
                    bottom: AppSizes.kDefaultPadding / 2,
                  ),
                  child: CustomSearchbar(
                    searchHintText: 'Search here ...',
                    controller: _searchCtrl,
                    onChanged: (q) => context
                        .read<UserBloc>()
                        .add(SearchPymkChanged(query: q)),
                    onClear: () {
                      _searchCtrl.clear();
                      context
                          .read<UserBloc>()
                          .add(SearchPymkChanged(query: ''));
                    },
                  ),
                ),
              ),
            ),
            body: ListView(
              padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.kDefaultPadding),
                  child: SafeArea(
                    // ⬇️ same bloc instance used by the list
                    child: const BuildConnectionsList(
                      type: ConnectionListType.peopleYouMayKnow,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}