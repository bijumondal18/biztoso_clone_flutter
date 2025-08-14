import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../widgets/horizontal_divider.dart';
import '../../../widgets/profile_avatar.dart';

class BuildChatList extends StatefulWidget {
  const BuildChatList({super.key});

  @override
  State<BuildChatList> createState() => _BuildChatListState();
}

class _BuildChatListState extends State<BuildChatList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      padding: EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.kDefaultPadding,
              vertical: 4.0,
            ),
            child: Row(
              spacing: AppSizes.kDefaultPadding,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ProfileAvatar(
                  imageUrl:
                      'https://static-cse.canva.com/blob/2121234/1600w-B-cRyoh7b98.jpg',
                  radius: 44,
                  onPressed: () {},
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2.0,
                    children: [
                      Text(
                        'Kushal Kumar',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Hi, This is the last message sent by this user.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainer.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Aug 14',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer.withAlpha(180),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding / 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        '3',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 76),
          child: HorizontalDivider(),
        );
      },
    );
  }
}
