import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import '../../data/models/language.dart';

class LanguageDropdown extends StatelessWidget {
  final List<Language> languages;
  final Language? selectedLanguage;
  final Function(Language?) onChanged;

  const LanguageDropdown({
    super.key,
    required this.languages,
    required this.selectedLanguage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Language>(
      value: selectedLanguage,
      dropdownColor: Theme.of(context).cardColor,
      elevation: 3,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Theme.of(context).hintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.kDefaultPadding,
          vertical: AppSizes.kDefaultPadding / 2,
        ),
      ),
      isExpanded: true,
      hint: const Text("Select Language"),
      items: languages.map((lang) {
        return DropdownMenuItem<Language>(
          value: lang,
          child: Row(
            children: [
              Text(
                lang.languageNameEnglish ?? '',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
