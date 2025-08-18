import 'dart:io';

import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/utils/snackbar_helper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

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
  List<PlatformFile> _images = [];
  List<PlatformFile> _videos = [];

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withReadStream: false, // we only need paths
    );
    if (result == null) return;

    // Cap at 5
    final picked = result.files.take(5).toList();
    setState(() => _images = picked);

    if (result.files.length > 5) {
      SnackBarHelper.show(
        'Media selection limit reached. Max 5 images can be picked.',
      );
    }
  }

  Future<void> _pickVideos() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
      withReadStream: false,
    );
    if (result == null) return;

    final picked = result.files.take(5).toList();
    setState(() => _videos = picked);

    if (result.files.length > 5) {
      SnackBarHelper.show(
        'Media selection limit reached. Max 5 videos can be picked.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
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
                        color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(20),
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
                            color: Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          Text(
                            'Camera',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.surfaceContainer,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _pickImages(),
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardCornerRadius,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(20),
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
                            color: Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.surfaceContainer,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _pickVideos(),
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardCornerRadius,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(20),
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
                            color: Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          Text(
                            'Videos',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.surfaceContainer,
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
              spacing: width * 0.02,
              runSpacing: width * 0.02,
              children: _images
                  .map(
                    (f) => ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSizes.cardCornerRadius,
                      ),
                      child: Image.file(
                        File(f.path!),
                        width: width * 0.29,
                        height: height * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .toList(),
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
