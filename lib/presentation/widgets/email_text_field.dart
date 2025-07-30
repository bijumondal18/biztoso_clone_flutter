import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';

class EmailTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const EmailTextField({
    super.key,
    this.hintText = 'Enter your email',
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
      ),
      padding: EdgeInsets.all(1.0),
      child: Container(
        alignment: Alignment.center,
        height: AppSizes.textFieldHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        ),
        child: TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: 2,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).hintColor),
            isDense: true,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Theme.of(context).hintColor,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
