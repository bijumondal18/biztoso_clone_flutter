import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../widgets/appbar_icon.dart';
import '../../widgets/profile_avatar.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: AppSizes.elevationSmall,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Text(
          'Create Post',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.kDefaultPadding,
            vertical: AppSizes.kDefaultPadding,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.kDefaultPadding*2),
              child: Row(
                spacing: AppSizes.kDefaultPadding,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: ProfileAvatar(
                      radius: 38,
                      imageUrl:
                          'https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg=',
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        hintStyle: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(color: Theme.of(context).hintColor),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'Select Media',
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.kDefaultPadding,
              ),
              child: Row(
                spacing: AppSizes.kDefaultPadding,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
                      ),
                      child: Column(
                        spacing: 4.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.camera,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            'Camera',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
                      ),
                      child: Column(
                        spacing: 4.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.gallery,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
                      ),
                      child: Column(
                        spacing: 4.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.video,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            'Videos',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'Both',
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
