import 'package:biztoso/core/resources/app_images.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/themes/app_sizes.dart';

class CustomSearchbar extends StatelessWidget {
  final String? searchHintText;

  const CustomSearchbar({super.key, this.searchHintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding/2),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
      ),
      child: Row(
        spacing: AppSizes.kDefaultPadding/4,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(EvaIcons.search, color: Theme.of(context).hintColor),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: searchHintText,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding / 2,
                  vertical: 10.0,
                ),
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).hintColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(AppImages.imgVoice, width: 20, height: 20),
          ),
        ],
      ),
    );
  }
}
