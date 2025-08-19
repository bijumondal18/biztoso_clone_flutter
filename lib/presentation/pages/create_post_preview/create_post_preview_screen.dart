import 'package:flutter/material.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../widgets/appbar_icon.dart';

class CreatePostPreviewScreen extends StatefulWidget {
  const CreatePostPreviewScreen({super.key});

  @override
  State<CreatePostPreviewScreen> createState() => _CreatePostPreviewScreenState();
}

class _CreatePostPreviewScreenState extends State<CreatePostPreviewScreen> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
