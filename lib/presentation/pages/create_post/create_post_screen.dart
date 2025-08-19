import 'dart:io';
import 'dart:typed_data';

import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/presentation/blocs/post/selected_media_for_post_cubit.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/utils/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/appbar_icon.dart';
import '../../widgets/profile_avatar.dart';
import 'components/removable_asset_tile.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  Future<void> _pickImages(BuildContext context) async {
    final ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
      SnackBarHelper.show('Gallery access denied. Please allow permissions.');
      return;
    }

    final cubit = context.read<SelectedMediaForPostCubit>();
    final state = cubit.state;

    final assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: SelectedMediaForPostCubit.kMax,
        requestType: RequestType.image,
        selectedAssets: state.all, // keep preselection
      ),
    );
    if (assets != null) cubit.setImagesFromPicker(assets);
  }

  Future<void> _pickVideos(BuildContext context) async {
    final ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
      SnackBarHelper.show('Gallery access denied. Please allow permissions.');
      return;
    }

    final cubit = context.read<SelectedMediaForPostCubit>();
    final state = cubit.state;

    final assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: SelectedMediaForPostCubit.kMax,
        requestType: RequestType.video,
        selectedAssets: state.all,
      ),
    );
    if (assets != null) cubit.setVideosFromPicker(assets);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectedMediaForPostCubit(),
      child: _CreatePostView(
        onPickImages: _pickImages,
        onPickVideos: _pickVideos,
      ),
    );
  }
}

class _CreatePostView extends StatelessWidget {
  final Future<void> Function(BuildContext) onPickImages;
  final Future<void> Function(BuildContext) onPickVideos;

  const _CreatePostView({
    required this.onPickImages,
    required this.onPickVideos,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // ... your AppBar and description field stay unchanged ...

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
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
        children: [
          // … header/user row …
          Padding(
            padding: const EdgeInsets.only(
              bottom: AppSizes.kDefaultPadding * 2,
            ),
            child: Row(
              spacing: AppSizes.kDefaultPadding,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider(
                  create: (context) =>
                      UserBloc()..add(FetchProfileDetailsEvent()),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is FetchUserProfileStateLoaded) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: ProfileAvatar(
                            radius: 38,
                            imageUrl:
                                '${state.profileResponse.result?.profilePic}',
                            onPressed: () {},
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: ProfileAvatar(
                          radius: 38,
                          imageUrl: '',
                          onPressed: () {},
                        ),
                      );
                    },
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
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
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

          // Pickers
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.kDefaultPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _PickerTile(
                    label: 'Camera',
                    icon: Icons.photo_camera_outlined,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: AppSizes.kDefaultPadding),
                Expanded(
                  child: _PickerTile(
                    label: 'Photos',
                    icon: Iconsax.gallery,
                    onTap: () => onPickImages(context),
                  ),
                ),
                const SizedBox(width: AppSizes.kDefaultPadding),
                Expanded(
                  child: _PickerTile(
                    label: 'Videos',
                    icon: Iconsax.video,
                    onTap: () => onPickVideos(context),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.kDefaultPadding),

          Text(
            'Both',
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: AppSizes.kDefaultPadding),

          // Thumbnails
          BlocBuilder<SelectedMediaForPostCubit, SelectedMediaForPostState>(
            buildWhen: (prev, curr) => prev.ids != curr.ids,
            // only rebuild when list changes
            builder: (context, state) {
              final items = state.all;
              if (items.isEmpty) return const SizedBox.shrink();
              final width = MediaQuery.sizeOf(context).width;
              final tileW = width * 0.29;
              final tileH = width * 0.38;

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: items.map((asset) {
                  return RemovableAssetTile(
                    key: ValueKey(asset.id),
                    // stable identity
                    asset: asset,
                    width: tileW,
                    height: tileH,
                    image: AssetEntityImage(
                      // flicker-free thumbnail
                      asset,
                      isOriginal: false,
                      thumbnailSize: const ThumbnailSize(200, 200),
                      fit: BoxFit.cover,
                      width: tileW,
                      height: tileH,
                    ),
                    onRemoveConfirmed: () => context
                        .read<SelectedMediaForPostCubit>()
                        .removeById(asset.id),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar:
          BlocSelector<
            SelectedMediaForPostCubit,
            SelectedMediaForPostState,
            bool
          >(
            selector: (s) => s.all.isNotEmpty, // true if at least 1 asset
            builder: (context, hasMedia) {
              return Container(
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
                  child: CustomPrimaryButton(
                    label: 'Next',
                    isEnabled: hasMedia,
                    onPressed: () => appRouter.push(Screens.createPostPreview),
                  ),
                ),
              );
            },
          ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PickerTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(20),
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4.0,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.surfaceContainer),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
