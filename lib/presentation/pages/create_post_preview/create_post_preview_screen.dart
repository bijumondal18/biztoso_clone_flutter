import 'package:biztoso/core/extensions/string_extensions.dart';
import 'package:biztoso/presentation/pages/home/widgets/post_media_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/navigation/screens.dart';
import '../../../core/themes/app_sizes.dart';
import '../../../utils/app_utils.dart';
import '../../blocs/post/selected_media_for_post_cubit.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/appbar_icon.dart';
import '../../widgets/custom_primary_button.dart';
import '../../widgets/profile_avatar.dart';
import 'components/post_media_grid_preview.dart';

class CreatePostPreviewScreen extends StatefulWidget {
  const CreatePostPreviewScreen({super.key});

  @override
  State<CreatePostPreviewScreen> createState() =>
      _CreatePostPreviewScreenState();
}

class _CreatePostPreviewScreenState extends State<CreatePostPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: AppSizes.elevationSmall,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Text(
          'Preview Post',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        children: [
          Container(
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
              children: [
                BlocProvider(
                  create: (context) =>
                      UserBloc()..add(FetchProfileDetailsEvent()),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is FetchUserProfileStateLoaded) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: AppSizes.kDefaultPadding / 2,
                          children: [
                            ProfileAvatar(
                              imageUrl:
                                  '${state.profileResponse.result?.profilePic}',
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Just now',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: Theme.of(context).hintColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.kDefaultPadding),
                BlocBuilder<
                  SelectedMediaForPostCubit,
                  SelectedMediaForPostState
                >(
                  builder: (context, state) {
                    return PickedMediaGridPreview(
                      assets: state.images,
                      height: height * 0.3,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(-10, -10),
              color: Theme.of(context).shadowColor.withAlpha(200),
              blurRadius: AppSizes.blurRadius,
            ),
          ],
        ),
        child: SafeArea(
          child: CustomPrimaryButton(label: 'Share Post', onPressed: () {}),
        ),
      ),
    );
  }
}
