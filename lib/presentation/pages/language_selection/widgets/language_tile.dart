import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/data/models/language.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/app_images.dart';
import '../../../../core/themes/app_sizes.dart';

class LanguageTile extends StatelessWidget {
  final Language language;
  final VoidCallback onTap;

  const LanguageTile({super.key, required this.language, required this.onTap});

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
          color: language.bgColor,
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: Row(
          spacing: AppSizes.kDefaultPadding * 1.5,
          children: [
            Image.asset(
              language.imagePath,
              width: width * 0.15,
              height: width * 0.15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: language.title != '',
                    child: Text(
                      language.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: AppColors.black),
                    ),
                  ),
                  Text(
                    language.subTitle,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
            Icon(
              language.isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: language.isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).hintColor,
            ),
          ],
        ),
      ),
    );
  }
}
