import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/presentation/pages/connection/widgets/connection_card.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/themes/app_sizes.dart';

class BuildConnectionsList extends StatefulWidget {
  final String screenFlag;

  const BuildConnectionsList({super.key, this.screenFlag = 'connectionScreen'});

  @override
  State<BuildConnectionsList> createState() => _BuildConnectionsListState();
}

class _BuildConnectionsListState extends State<BuildConnectionsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible:
              widget.screenFlag == 'peopleYouMayKnow' ||
              widget.screenFlag == 'connectionScreen',
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: AppSizes.kDefaultPadding / 2,
            ),
            child: Text(
              widget.screenFlag == 'peopleYouMayKnow'
                  ? 'People You May Know'
                  : '36 Connections',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        ListView.separated(
          itemCount: 36,
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ConnectionCard(screenFlag: widget.screenFlag);
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: AppSizes.kDefaultPadding / 2),
        ),
      ],
    );
  }
}
