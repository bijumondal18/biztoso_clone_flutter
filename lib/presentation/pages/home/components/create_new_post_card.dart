import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/presentation/pages/home/components/create_new_post_card_shimmer.dart';
import 'package:biztoso/presentation/widgets/custom_card.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/app_sizes.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/profile_avatar.dart';

class CreateNewPostCard extends StatelessWidget {
  const CreateNewPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.all(AppSizes.kDefaultPadding),
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
            blurRadius: AppSizes.blurRadius,
          ),
        ],
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is FetchUserProfileStateLoading) {
            return const CreateNewPostCardShimmer();
          }
          if (state is FetchUserProfileStateLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.kDefaultPadding,
              children: [
                Row(
                  spacing: AppSizes.kDefaultPadding / 2,
                  children: [
                    ProfileAvatar(
                      radius: 38,
                      imageUrl: '${state.profileResponse.result?.profilePic}',
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppUtils.firstNonEmptyTitle([
                              state.profileResponse.result?.fullName,
                            ]),
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            AppUtils.firstNonEmptyTitle([
                              state.profileResponse.result?.userName,
                            ]),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => appRouter.push(Screens.createPost),
                  borderRadius: BorderRadius.circular(
                    AppSizes.cardCornerRadius,
                  ),
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(AppSizes.kDefaultPadding / 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(
                        AppSizes.cardCornerRadius,
                      ),
                    ),
                    child: Text(
                      'What\'s on your mind?',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const CreateNewPostCardShimmer();
        },
      ),
    );
  }
}
