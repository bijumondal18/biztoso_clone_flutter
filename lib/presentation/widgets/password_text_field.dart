import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';

class PasswordTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const PasswordTextField({
    super.key,
    this.hintText = 'Enter your password',
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
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).hintColor),
            isDense: true,
            prefixIcon: Icon(
              Icons.lock_outlined,
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
