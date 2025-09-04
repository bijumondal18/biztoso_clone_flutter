import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/home/widgets/post_media_grid.dart';
import 'package:biztoso/presentation/widgets/custom_card.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:biztoso/utils/date_time_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final isReshare = post.originalPost != null;

    return CustomCard(
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding / 2),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding,
        vertical: 6.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSizes.kDefaultPadding / 2,
            children: [
              ProfileAvatar(
                imageUrl: '${post.originalPost?.ownerDetails?.ownerProfile}',
                onPressed: () {},
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppUtils.firstNonEmptyTitle([post.userName]),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      post.timeAgo ?? '',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                itemBuilder: (context) {
                  return [PopupMenuItem(child: Text('Save'))];
                },
              ),
            ],
          ),

          // description
          Visibility(
            visible: post.description != null && post.description!.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.kDefaultPadding / 2,
              ),
              child: Text(
                post.description ?? '',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          PostMediaGrid(media: post.images, height: height * 0.3),

          HorizontalDivider(height: AppSizes.kDefaultPadding),

          Row(
            spacing: AppSizes.kDefaultPadding,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppSizes.kDefaultPadding / 2,
                  children: [
                    Icon(
                      Iconsax.heart,
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    Text(
                      "2",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppSizes.kDefaultPadding / 2,
                  children: [
                    Icon(
                      Iconsax.message,
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    Text(
                      "2",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppSizes.kDefaultPadding / 2,
                  children: [
                    Icon(
                      Icons.share_outlined,
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    Text(
                      "2",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppSizes.kDefaultPadding / 2,
                  children: [
                    Icon(
                      EvaIcons.shareOutline,
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    Text(
                      "2",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // reshare block
          // if (isReshare) ...[
          //   const SizedBox(height: 10),
          //   // _ReshareBlock(post: post),
          // ],
        ],
      ),
    );
  }
}
