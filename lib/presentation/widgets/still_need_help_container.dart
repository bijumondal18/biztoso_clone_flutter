import 'package:flutter/material.dart';

import '../../core/themes/app_sizes.dart';
import 'custom_primary_button.dart';

class StillNeedHelpContainer extends StatelessWidget {
  const StillNeedHelpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding / 2),
      margin: const EdgeInsets.all(AppSizes.kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(width: 0.65, color: Theme.of(context).primaryColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Still Need Help?',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CustomPrimaryButton(
            label: 'Submit A Ticket',
            height: AppSizes.smallButtonHeight,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
