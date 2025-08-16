import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
        border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    post.profilePic != null && post.profilePic!.isNotEmpty
                    ? NetworkImage(post.profilePic ?? '')
                    : null,
                child: (post.profilePic == null || post.profilePic!.isEmpty)
                    ? const Icon(Icons.person_outline)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  post.userName ?? 'Unknown',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              // Text(
              //   _compactTime(post.createdAt),
              //   style: Theme
              //       .of(context)
              //       .textTheme
              //       .bodySmall,
              // ),
            ],
          ),
          const SizedBox(height: 8),

          // description
          if ((post.description ?? '').isNotEmpty) Text(post.description ?? ''),

          // images (first only for demo)
          if (post.images.isNotEmpty) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(post.images.first, fit: BoxFit.cover),
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
