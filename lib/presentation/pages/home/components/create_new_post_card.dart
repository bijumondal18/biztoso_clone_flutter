import 'package:flutter/material.dart';

import '../../../../core/themes/app_sizes.dart';
import '../../../widgets/profile_avatar.dart';

class CreateNewPostCard extends StatelessWidget {
  const CreateNewPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.all(AppSizes.kDefaultPadding/2),
      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
          border: Border.all(
            width: 1.0,
            color: Theme.of(context).dividerColor.withAlpha(100),
          ),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: AppSizes.spreadRadius,
                blurRadius: AppSizes.blurRadius
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSizes.kDefaultPadding,
        children: [
          Row(
            spacing: AppSizes.kDefaultPadding/2,
            children: [
              ProfileAvatar(
                radius: 38,
                imageUrl:
                'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
                onPressed: () {},
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nitish Ranjan',
                      style: Theme.of(context).textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '@nitish123',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: width,
            padding: EdgeInsets.all(AppSizes.kDefaultPadding/2),
            decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withAlpha(100),
                borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius)
            ),
            child: Text(
              'What\'s on your mind?',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
