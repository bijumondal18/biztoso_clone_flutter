import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../widgets/appbar_icon.dart';

class IdentityVerificationDocumentTypeScreen extends StatefulWidget {
  const IdentityVerificationDocumentTypeScreen({super.key});

  @override
  State<IdentityVerificationDocumentTypeScreen> createState() =>
      _IdentityVerificationDocumentTypeScreenState();
}

class _IdentityVerificationDocumentTypeScreenState
    extends State<IdentityVerificationDocumentTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: AppSizes.elevationSmall,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Text(
          'Identity Verification',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
        actions: [CustomPrimaryButton(label: 'Save', onPressed: () {})],
      ),
    );
  }
}
