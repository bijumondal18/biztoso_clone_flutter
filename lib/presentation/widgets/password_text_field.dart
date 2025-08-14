import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final String? Function(String?)? validator;
  final dynamic Function(String?)? onChanged;
  String? labelText;
  bool isMandatory;

  PasswordTextField(
      {super.key,
        required this.controller,
        this.hintText = 'Enter your password',
        this.validator,
        this.onChanged,
        this.labelText = '',
        this.isMandatory = false,
        required this.errorText});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: widget.labelText != '',
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              widget.isMandatory
                  ? '${widget.labelText} *'
                  : '${widget.labelText}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          keyboardType: TextInputType.visiblePassword,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            prefixIcon: Icon(
              Icons.password_rounded,
              size: AppSizes.appBarIconSize,
              color: AppColors.darkGrey.withAlpha(200),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: AppSizes.appBarIconSize,
                color: AppColors.darkGrey.withAlpha(200),
              ),
            ),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).hintColor,
              height: 3,
            ),
            errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.errorLight,
            ),
            errorText: widget.controller == '' ? widget.errorText : null,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding),
            border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.cardCornerRadius),
                borderSide: BorderSide(
                    color: AppColors.hintLight.withAlpha(100), width: 1.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.cardCornerRadius ),
                borderSide: BorderSide(
                    color: AppColors.hintLight.withAlpha(100), width: 1.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.cardCornerRadius ),
                borderSide: BorderSide(
                    color: AppColors.hintLight.withAlpha(100), width: 1.0)),
            errorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(AppSizes.cardCornerRadius ),
              borderSide:
              const BorderSide(color: AppColors.errorLight, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}
