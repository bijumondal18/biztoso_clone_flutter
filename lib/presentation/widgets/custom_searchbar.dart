import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../core/themes/app_sizes.dart';

class CustomSearchbar extends StatelessWidget {
  final String? searchHintText;

  const CustomSearchbar({super.key, this.searchHintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.kDefaultPadding / 2),
            child: Icon(EvaIcons.search, color: Theme.of(context).hintColor),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: searchHintText,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding / 2,
                ),
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).hintColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
