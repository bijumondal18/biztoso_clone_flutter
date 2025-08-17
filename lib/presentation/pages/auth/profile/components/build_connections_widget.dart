import 'package:biztoso/data/models/profile_response.dart';
import 'package:flutter/material.dart';

import '../../../../../core/navigation/app_router.dart';
import '../../../../../core/navigation/screens.dart';
import '../../../../../core/themes/app_sizes.dart';

class BuildConnectionsWidget extends StatelessWidget {
  final bool isPublicProfile;
  final ProfileResponse profileResponse;

  const BuildConnectionsWidget({
    super.key,
    required this.isPublicProfile,
    required this.profileResponse,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => appRouter.push(
        Screens.chatConnection,
        extra: [
          isPublicProfile,
          profileResponse.result?.sId,
          profileResponse.result?.fullName,
          false, // isComingFromChat
        ],
      ),
      borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
      child: Container(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '${profileResponse.result?.connectionCount}',
            style: Theme.of(context).textTheme.titleLarge,
            children: [
              TextSpan(
                text:
                    profileResponse.result?.connectionCount == 0 ||
                        profileResponse.result?.connectionCount == 1
                    ? '\nConnection'
                    : '\nConnections',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
