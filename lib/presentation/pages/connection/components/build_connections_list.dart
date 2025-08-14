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
import '../widgets/connections_header_shimmer.dart';

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
    context.read<UserBloc>().add(GetConnectionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (_, __) {},
      builder: (context, state) {
        if (state is GetConnectionsStateLoading) {
          final headerVisible =
              (widget.screenFlag == 'peopleYouMayKnow' ||
                  widget.screenFlag == 'connectionScreen') &&
                  widget.isPublicProfile == false;

          // Column of shimmer cards (no scrolling)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (headerVisible) ...[
                const Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.kDefaultPadding / 2),
                  child: ConnectionsHeaderShimmer(),
                ),
              ],
              // existing card shimmers
              for (int i = 0; i < 6; i++) ...const [
                ConnectionCardShimmer(screenFlag: 'connectionScreen'),
                SizedBox(height: AppSizes.kDefaultPadding / 1.5),
              ],
            ],
          );
        }

        if (state is GetConnectionsStateLoaded) {
          final items = state.connectionResponse.users?.docs ?? [];
          final headerVisible =
              (widget.screenFlag == 'peopleYouMayKnow' ||
                  widget.screenFlag == 'connectionScreen') &&
                  widget.isPublicProfile == false;

          final title = widget.screenFlag == 'peopleYouMayKnow'
              ? 'People You May Know'
              : '${items.length} Connections';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (headerVisible)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSizes.kDefaultPadding / 2,
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              // cards separated by SizedBox
              for (int i = 0; i < items.length; i++) ...[
                ConnectionCard(
                  screenFlag: widget.screenFlag,
                  docs: items[i],
                ),
                if (i != items.length - 1)
                  const SizedBox(height: AppSizes.kDefaultPadding / 2),
              ],
            ],
          );
        }

        if (state is GetConnectionsStateFailed) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(child: Text(state.error)),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
