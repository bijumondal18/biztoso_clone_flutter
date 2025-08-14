import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/data/models/user.dart';
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

enum ConnectionListType { connections, peopleYouMayKnow, sent, received }


class BuildConnectionsList extends StatefulWidget
     {
  final ConnectionListType type;
  final bool isPublicProfile;

  const BuildConnectionsList({
    super.key,
    this.type = ConnectionListType.connections,
    this.isPublicProfile = false,
  });

  @override
  State<BuildConnectionsList> createState() => _BuildConnectionsListState();
}

class _BuildConnectionsListState extends State<BuildConnectionsList> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context); // keep-alive

    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (prev, curr) => _relevantForType(curr, widget.type),
      builder: (context, state) {
        if (_isLoading(state, widget.type)) return _loadingSkeleton();

        if (_isFailed(state, widget.type)) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(child: Text(_errorText(state, widget.type))),
          );
        }

        if (_isLoaded(state, widget.type)) {
          final items = _items(state, widget.type);
          final showHeader = (widget.type == ConnectionListType.connections ||
              widget.type == ConnectionListType.peopleYouMayKnow) &&
              !widget.isPublicProfile;

          final title = widget.type == ConnectionListType.peopleYouMayKnow
              ? 'People You May Know'
              : '${items.length} ${items.length > 1 ? "Connections" : "Connection"}';

          // 🔹 Empty-state handling
          if (items.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showHeader)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSizes.kDefaultPadding / 2),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.kDefaultPadding * 2,
                  ),
                  child: Center(
                    child: Text(
                      _emptyText(widget.type),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(150),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeader)
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: AppSizes.kDefaultPadding / 2),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              for (int i = 0; i < items.length; i++) ...[
                ConnectionCard(
                  screenFlag: _flagFor(widget.type),
                  docs: items[i],
                ),
                if (i != items.length - 1)
                  const SizedBox(height: AppSizes.kDefaultPadding / 2),
              ],
            ],
          );
        }

        // initial/unknown
        return _loadingSkeleton();
      },
    );
  }

  // ----- helpers -----
  bool _relevantForType(UserState s, ConnectionListType t) {
    return switch (t) {
      ConnectionListType.connections =>
      s is GetConnectionsStateLoading ||
          s is GetConnectionsStateLoaded ||
          s is GetConnectionsStateFailed,
      ConnectionListType.peopleYouMayKnow =>
      s is AllConnectionListStateLoading ||
          s is AllConnectionListStateLoaded ||
          s is AllConnectionListStateFailed,
      ConnectionListType.sent =>
      s is SentConnectionRequestStateLoading ||
          s is SentConnectionRequestStateLoaded ||
          s is SentConnectionRequestStateFailed,
      ConnectionListType.received =>
      s is ReceivedConnectionRequestStateLoading ||
          s is ReceivedConnectionRequestStateLoaded ||
          s is ReceivedConnectionRequestStateFailed,
    };
  }

  bool _isLoading(UserState s, ConnectionListType t) => switch (t) {
    ConnectionListType.connections => s is GetConnectionsStateLoading,
    ConnectionListType.peopleYouMayKnow => s is AllConnectionListStateLoading,
    ConnectionListType.sent => s is SentConnectionRequestStateLoading,
    ConnectionListType.received => s is ReceivedConnectionRequestStateLoading,
  };

  bool _isLoaded(UserState s, ConnectionListType t) => switch (t) {
    ConnectionListType.connections => s is GetConnectionsStateLoaded,
    ConnectionListType.peopleYouMayKnow => s is AllConnectionListStateLoaded,
    ConnectionListType.sent => s is SentConnectionRequestStateLoaded,
    ConnectionListType.received => s is ReceivedConnectionRequestStateLoaded,
  };

  bool _isFailed(UserState s, ConnectionListType t) => switch (t) {
    ConnectionListType.connections => s is GetConnectionsStateFailed,
    ConnectionListType.peopleYouMayKnow => s is AllConnectionListStateFailed,
    ConnectionListType.sent => s is SentConnectionRequestStateFailed,
    ConnectionListType.received => s is ReceivedConnectionRequestStateFailed,
  };

  List<User> _items(UserState s, ConnectionListType t) => switch (t) {
    ConnectionListType.connections =>
    (s as GetConnectionsStateLoaded).connectionResponse.users?.docs ?? [],
    ConnectionListType.peopleYouMayKnow =>
    (s as AllConnectionListStateLoaded).allConnectionResponse.users ?? [],
    ConnectionListType.sent =>
    (s as SentConnectionRequestStateLoaded).connectionSentResponse.users ?? [],
    ConnectionListType.received =>
    (s as ReceivedConnectionRequestStateLoaded).connectionReceivedResponse.users ?? [],
  };

  String _errorText(UserState s, ConnectionListType t) => switch (t) {
    ConnectionListType.connections =>
    (s as GetConnectionsStateFailed).error,
    ConnectionListType.peopleYouMayKnow =>
    (s as AllConnectionListStateFailed).error,
    ConnectionListType.sent =>
    (s as SentConnectionRequestStateFailed).error,
    ConnectionListType.received =>
    (s as ReceivedConnectionRequestStateFailed).error,
  };

  String _emptyText(ConnectionListType t) => switch (t) {
    ConnectionListType.connections => 'No Connections Found',
    ConnectionListType.peopleYouMayKnow => 'No Suggestions Found',
    ConnectionListType.sent => 'No Sent Requests',
    ConnectionListType.received => 'No Received Invitations',
  };

  String _flagFor(ConnectionListType t) => switch (t) {
    ConnectionListType.connections => 'connectionScreen',
    ConnectionListType.peopleYouMayKnow => 'peopleYouMayKnow',
    ConnectionListType.sent => 'sentInvitation',
    ConnectionListType.received => 'receivedInvitation',
  };

  Widget _loadingSkeleton() {
    final showHeader = (widget.type == ConnectionListType.connections ||
        widget.type == ConnectionListType.peopleYouMayKnow) &&
        !widget.isPublicProfile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader)
          const Padding(
            padding: EdgeInsets.only(bottom: AppSizes.kDefaultPadding / 2),
            child: ConnectionsHeaderShimmer(),
          ),
        for (int i = 0; i < 6; i++) ...[
          ConnectionCardShimmer(screenFlag: _flagFor(widget.type)),
          const SizedBox(height: AppSizes.kDefaultPadding / 1.5),
        ],
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}