import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/data/models/connection_response.dart';
import 'package:biztoso/data/models/user.dart';
import 'package:biztoso/presentation/blocs/user/user_bloc.dart';
import 'package:biztoso/presentation/widgets/custom_outline_button.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:biztoso/utils/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/navigation/screens.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../widgets/custom_primary_button.dart';
import '../../../widgets/profile_avatar.dart';

class ConnectionCard extends StatelessWidget {
  final String screenFlag;
  final User docs;

  const ConnectionCard({
    super.key,
    required this.screenFlag,
    required this.docs,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = AppUtils.firstNonEmptyTitle([docs.name]);
    final displayBusiness = AppUtils.firstNonEmptyTitle([
      docs.businessName,
      docs.userName,
    ]);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding / 2,
        vertical: AppSizes.kDefaultPadding / 1.2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor.withAlpha(100),
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
      ),
      child: Row(
        spacing: AppSizes.kDefaultPadding / 2,
        children: [
          ProfileAvatar(
            imageUrl: '${docs.profilePic}',
            onPressed: () {
              final id = docs.userId?.toString() ?? docs.sId?.toString();
              appRouter.push(Screens.profile, extra: [true, id]);
            },
            // isPublicProfile = true
            radius: 48,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                final id = docs.userId?.toString() ?? docs.sId?.toString();
                appRouter.push(Screens.profile, extra: [true, id]);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.0,
                children: [
                  Text(
                    displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    displayBusiness,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildTrailingButton(context: context, screenFlag: screenFlag),
        ],
      ),
    );
  }

  Widget _buildTrailingButton({
    required BuildContext context,
    required String screenFlag,
  }) {
    switch (screenFlag) {
      case 'connectionScreen':
        return CustomPrimaryButton(
          label: 'Message',
          onPressed: () => appRouter.push(Screens.chatInbox),
          hasIcon: true,
          iconPath: Iconsax.message5,
          height: AppSizes.smallButtonHeight,
        );
      case 'peopleYouMayKnow':
        final id = docs.sId?.toString() ?? '';

        final tuple = context.select<UserBloc, ({bool busy, bool requested})>((
          b,
        ) {
          final s = b.state;
          if (s is AllConnectionListStateLoaded) {
            return (
              busy: id.isNotEmpty && s.inProgressIds.contains(id),
              requested: id.isNotEmpty && s.requestedIds.contains(id),
            );
          }
          return (busy: false, requested: false);
        });

        // spinner while API in-flight
        if (tuple.busy) {
          return SizedBox(
            height: AppSizes.smallButtonHeight,
            width: 150,
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CupertinoActivityIndicator(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
            ),
          );
        }

        // already requested → show "Cancel Request"
        if (tuple.requested) {
          return CustomOutlineButton(
            label: 'Cancel Request',
            onPressed: () {
              if (id == null || id.isEmpty) return;
              context.read<UserBloc>().add(
                CancelConnectionRequestEvent(userId: id),
              );
            },
            labelColor: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            height: AppSizes.smallButtonHeight,
          );
        }
        return CustomPrimaryButton(
          label: 'Connect',
          onPressed: () {
            if (id == null || id.isEmpty) {
              SnackBarHelper.show('Unable to connect: missing user id');
              return;
            }
            context.read<UserBloc>().add(
              SendConnectionRequestEvent(userId: id),
            );
          },
          hasIcon: true,
          iconPath: CupertinoIcons.person_add_solid,
          height: AppSizes.smallButtonHeight,
        );
      case 'receivedInvitation':
        final id = docs.sId?.toString() ?? '';

        final busy = context.select<UserBloc, bool>((b) {
          final s = b.state;
          if (s is ReceivedConnectionRequestStateLoaded) {
            return id.isNotEmpty && s.inProgressIds.contains(id);
          }
          return false;
        });

        if (busy) {
          return SizedBox(
            height: AppSizes.smallButtonHeight,
            width: 200, // roughly the width of the two buttons
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CupertinoActivityIndicator(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
            ),
          );
        }
        return Row(
          spacing: AppSizes.kDefaultPadding / 2,
          children: [
            CustomPrimaryButton(
              label: 'Accept',
              onPressed: () {
                if (id.isEmpty) {
                  SnackBarHelper.show('Unable to accept: missing id');
                  return;
                }
                context.read<UserBloc>().add(
                  AcceptReceivedInvitationEvent(userId: id),
                );
              },
              height: AppSizes.smallButtonHeight,
            ),
            CustomOutlineButton(
              label: 'Decline',
              onPressed: () {
                if (id.isEmpty) {
                  SnackBarHelper.show('Unable to decline: missing id');
                  return;
                }
                context.read<UserBloc>().add(
                  DeclineReceivedInvitationEvent(userId: id),
                );
              },
              labelColor: AppColors.red,
              borderColor: AppColors.red,
              height: AppSizes.smallButtonHeight,
            ),
          ],
        );
      case 'sentInvitation':
        final String id = docs.sId?.toString() ?? '';

        // read busy set from bloc state
        final bool isBusy = context.select<UserBloc, bool>((b) {
          final s = b.state;
          if (s is SentConnectionRequestStateLoaded) {
            return id.isNotEmpty && s.inProgressIds.contains(id);
          }
          return false;
        });

        // show a tiny loader in place of the button while cancel is in-flight
        if (isBusy) {
          return SizedBox(
            height: AppSizes.smallButtonHeight,
            width: 140, // match your button width; tweak as needed
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CupertinoActivityIndicator(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
            ),
          );
        }

        return CustomOutlineButton(
          label: 'Cancel Request',
          onPressed: () {
            String requestId = docs.sId.toString();
            if (requestId == null && requestId.isEmpty) {
              SnackBarHelper.show('Unable to Cancel: missing request id');
            }
            context.read<UserBloc>().add(
              CancelConnectionRequestEvent(userId: requestId),
            );
          },
          labelColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
          height: AppSizes.smallButtonHeight,
        );
    }
    return CustomPrimaryButton(
      label: 'Message',
      onPressed: () {},
      hasIcon: true,
      iconPath: Iconsax.message5,
      height: AppSizes.smallButtonHeight,
    );
  }
}
