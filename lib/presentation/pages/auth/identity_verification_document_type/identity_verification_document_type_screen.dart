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
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: AppSizes.elevationSmall,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Text(
          'Document Verification',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSizes.kDefaultPadding / 2),
            child: SizedBox(
              width: width * 0.2,
              child: CustomPrimaryButton(
                label: 'Save',
                height: AppSizes.smallButtonHeight,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: AppSizes.kDefaultPadding / 2,
              left: AppSizes.kDefaultPadding,
            ),
            child: Text(
              'Choose Your Document Type',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.kDefaultPadding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Radio<int>(
                        activeColor: Theme.of(context).primaryColor,
                        value: 1,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      Text(
                        'Business',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Radio<int>(
                        activeColor: Theme.of(context).primaryColor,
                        value: 2,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      Text(
                        'Individual',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(flex: 1, child: const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
