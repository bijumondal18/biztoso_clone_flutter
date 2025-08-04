import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/data/models/language.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/app_images.dart';
import '../../../../core/themes/app_sizes.dart';

class LanguageTile extends StatelessWidget {
  final Language language;
  final VoidCallback onTap;
  final Color? bgColor;
  final bool isSelected;

  const LanguageTile({
    super.key,
    required this.language,
    required this.onTap,
    this.bgColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.only(top: AppSizes.kDefaultPadding),
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: Row(
          spacing: AppSizes.kDefaultPadding * 1.5,
          children: [
            CachedNetworkImage(
              imageUrl: language.image ?? '',
              width: width * 0.15,
              height: width * 0.15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: language.languageName != 'English',
                    child: Text(
                      language.languageName ?? '',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: AppColors.black),
                    ),
                  ),
                  Text(
                    language.languageNameEnglish ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).hintColor,
            ),
          ],
        ),
      ),
    );
  }
}
