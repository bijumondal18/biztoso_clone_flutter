import 'dart:io';
import 'dart:typed_data';

import 'package:biztoso/core/themes/app_colors.dart';
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

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // Hold selections
  List<AssetEntity> _images = [];
  List<AssetEntity> _videos = [];

  Future<void> _pickImages() async {
    final ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) { SnackBarHelper.show('Gallery access denied. Please allow permissions.'); return; }

    final assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 5, // total cap; we'll trim below relative to videos
        requestType: RequestType.image,
        selectedAssets: [..._images, ..._videos], // keep preselection
      ),
    );

    if (assets == null) return;

    // Replace images with what picker returns (no merge)
    final newImages = assets.where((a) => a.type == AssetType.image).toList();
    setState(() {
      final allow = (5 - _videos.length).clamp(0, 5);
      _images = newImages.take(allow).toList();
    });
  }


  Future<void> _pickVideos() async {
    final ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) { SnackBarHelper.show('Gallery access denied. Please allow permissions.'); return; }

    final assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 5,
        requestType: RequestType.video,
        selectedAssets: [..._images, ..._videos],
      ),
    );

    if (assets == null) return;

    // Replace videos with what picker returns (no merge)
    final newVideos = assets.where((a) => a.type == AssetType.video).toList();
    setState(() {
      final allow = (5 - _images.length).clamp(0, 5);
      _videos = newVideos.take(allow).toList();
    });
  }

  void _removeAsset(AssetEntity asset) {
    setState(() {
      // Remove from both (safe; only one will match)
      _images.removeWhere((a) => a.id == asset.id);
      _videos.removeWhere((a) => a.id == asset.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final allMedia = [..._images, ..._videos];

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
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.kDefaultPadding,
          vertical: AppSizes.kDefaultPadding,
        ),
        children: [
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
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardCornerRadius,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer.withAlpha(20),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                          ),
                          Text(
                            'Camera',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async => await _pickImages(),
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardCornerRadius,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer.withAlpha(20),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                          ),
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async => await _pickVideos(),
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardCornerRadius,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer.withAlpha(20),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                          ),
                          Text(
                            'Videos',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                                ),
                          ),
                        ],
                      ),
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

          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.kDefaultPadding,
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allMedia.map((asset) {
                return FutureBuilder<Uint8List?>(
                  future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: width * 0.29,
                        height: width * 0.38,
                        color: Theme.of(context).dividerColor,
                        child: Center(
                          child: CupertinoActivityIndicator(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
                        child: Stack(
                          children: [
                            Image.memory(
                              snapshot.data!,
                              key: ValueKey(asset.id),
                              width: width * 0.29,
                              height: width * 0.38,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: IconButton(
                                onPressed: () => _removeAsset(asset),
                                icon: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.errorDark.withAlpha(150),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),

                            if (asset.type == AssetType.video)
                              const Positioned(
                                left: 6,
                                bottom: 6,
                                child: Icon(
                                  Icons.play_circle_fill,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(-10, -10),
              color: Theme.of(context).shadowColor.withAlpha(200),
              blurRadius: AppSizes.blurRadius,
            ),
          ],
        ),
        child: SafeArea(
          child: CustomPrimaryButton(label: 'Next', onPressed: () {}),
        ),
      ),
    );
  }
}
