import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/presentation/pages/connection/widgets/connection_card.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/themes/app_sizes.dart';
import '../../../blocs/user/user_bloc.dart';
import '../widgets/connection_card_shimmer.dart';

class BuildConnectionsList extends StatefulWidget {
  final String screenFlag;
  final bool isPublicProfile;

  const BuildConnectionsList({
    super.key,
    this.screenFlag = 'connectionScreen',
    this.isPublicProfile = false,
  });

  @override
  State<BuildConnectionsList> createState() => _BuildConnectionsListState();
}

class _BuildConnectionsListState extends State<BuildConnectionsList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetConnectionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetConnectionsStateLoading) {
          return ListView.separated(
            padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
            itemCount: 6,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSizes.kDefaultPadding / 1.5),
            itemBuilder: (_, __) => const ConnectionCardShimmer(
              screenFlag: 'connectionScreen', // or the flag for that screen
            ),
          );
        }
        if (state is GetConnectionsStateLoaded) {
          final items = state.connectionResponse.users?.docs ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible:
                    (widget.screenFlag == 'peopleYouMayKnow' ||
                        widget.screenFlag == 'connectionScreen') &&
                    widget.isPublicProfile == false,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSizes.kDefaultPadding / 2,
                  ),
                  child: Text(
                    widget.screenFlag == 'peopleYouMayKnow'
                        ? 'People You May Know'
                        : '${items.length} Connections',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              ListView.separated(
                itemCount: items.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConnectionCard(
                    screenFlag: widget.screenFlag,
                    docs: items[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: AppSizes.kDefaultPadding / 2),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
