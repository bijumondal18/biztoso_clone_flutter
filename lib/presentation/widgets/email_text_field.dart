import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';


class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final String? Function(String?)? validator;
  final dynamic Function(String?)? onChanged;
  String? labelText;
  bool hasPrefixIcon;
  bool hasSuffixIcon;
  VoidCallback? suffixIconPressed;
  bool isMandatory;
  bool readOnly;

  EmailTextField(
      {super.key,
        required this.controller,
        this.hintText = 'Enter your email',
        required this.errorText,
        this.validator,
        this.labelText = '',
        this.hasPrefixIcon = true,
        this.hasSuffixIcon = false,
        this.suffixIconPressed,
        this.isMandatory = false,
        this.readOnly = false,
        this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: labelText != '',
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              isMandatory ? '$labelText *' : '$labelText',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          validator: validator,
          onChanged: onChanged,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            prefixIcon: hasPrefixIcon
                ? Icon(
              Icons.email_rounded,
              size: AppSizes.appBarIconSize,
              color: readOnly
                  ? AppColors.darkGrey.withAlpha(100)
                  : AppColors.darkGrey.withAlpha(200),
            )
                : null,
            suffixIcon: InkWell(
              onTap: suffixIconPressed,
              child: Visibility(
                  visible: hasSuffixIcon,
                  child: const Icon(
                    Icons.edit,
                    size: AppSizes.appBarIconSize,
                    color:
                    // readOnly
                    //     ? AppColors.darkGrey.withAlpha(100)
                    //     :
                    AppColors.primaryLight,
                  )),
            ),
            labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: readOnly == true
                    ? Theme.of(context).colorScheme.surfaceContainer.withAlpha(200)
                    : Theme.of(context).colorScheme.surfaceContainer),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).hintColor, height: 3),
            errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.errorLight,
            ),
            errorText: controller == '' ? errorText : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.kDefaultPadding,
            ),
            border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(AppSizes.cardCornerRadius ),
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
