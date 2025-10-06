import 'package:flutter/material.dart';

import '../../core/themes/app_sizes.dart';

class PickerBottomSheet {
  static void show({
    required BuildContext context,
    required String title,
    required List<BottomSheetAction> actions,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            left: AppSizes.kDefaultPadding,
            right: AppSizes.kDefaultPadding,
            bottom:
                MediaQuery.of(ctx).viewInsets.bottom + AppSizes.kDefaultPadding,
            top: AppSizes.kDefaultPadding,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.bottomSheetCornerRadius),
              topRight: Radius.circular(AppSizes.bottomSheetCornerRadius),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(ctx).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.kDefaultPadding),

                // Action buttons
                ...actions.map(
                  (action) => ListTile(
                    dense: true,
                    leading: action.icon != null
                        ? Icon(
                            action.icon,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                    title: Text(
                      action.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    onTap: () {
                      Navigator.pop(ctx); // close bottom sheet
                      action.onTap(); // trigger action
                    },
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Action model for the sheet
class BottomSheetAction {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  BottomSheetAction({required this.label, this.icon, required this.onTap});
}
