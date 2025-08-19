import 'dart:io';
import 'dart:typed_data';

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

    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
      SnackBarHelper.show('Gallery access denied. Please allow permissions.');
      return;
    }

    final remaining = 5 - (_images.length + _videos.length);
    if (remaining <= 0) {
      SnackBarHelper.show('You can only pick up to 5 items (images + videos).');
      return;
    }

    final List<AssetEntity>? assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: remaining,              // ✅ only allow remaining slots
        requestType: RequestType.image,
        selectedAssets: [..._images, ..._videos],
      ),
    );

    if (assets != null) {
      final combined = [..._images, ...assets];
      setState(() => _images = combined.take(5).toList());
    }
  }

  Future<void> _pickVideos() async {

    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
      SnackBarHelper.show('Gallery access denied. Please allow permissions.');
      return;
    }

    final remaining = 5 - (_images.length + _videos.length);
    if (remaining <= 0) {
      SnackBarHelper.show('You can only pick up to 5 items (images + videos).');
      return;
    }

    final List<AssetEntity>? assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: remaining,              // ✅ only allow remaining slots
        requestType: RequestType.video,
        selectedAssets: [..._images, ..._videos],
      ),
    );

    if (assets != null) {
      final combined = [..._videos, ...assets];
      setState(() => _videos = combined.take(5).toList());
    }

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
                  future: asset.thumbnailDataWithSize(
                     ThumbnailSize(200, 200),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
                        child: Image.memory(
                          snapshot.data!,
                          width: width*0.29,
                          height: width*0.38,
                          fit: BoxFit.cover,
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
