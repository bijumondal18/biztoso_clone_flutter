import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:biztoso/utils/date_time_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final isReshare = post.originalPost != null;

    return Container(
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding / 2),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(
          width: 1.0,
          color: Theme.of(context).dividerColor.withAlpha(100),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(200),
            blurRadius: AppSizes.blurRadius,
          ),
        ],
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
                      AppUtils.firstNonEmptyTitle([
                        post.originalPost?.ownerDetails?.ownerName,
                      ]),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      post.timeAgo??'',
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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),

          // images (first only for demo)
          if (post.images.isNotEmpty) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
              child: CachedNetworkImage(
                imageUrl: post.images.first,
                fit: BoxFit.fitWidth,
                height: height * 0.4,
                width: width,
              ),
            ),
          ],

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
