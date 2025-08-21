import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Language>(
        value: selectedLanguage,
        style: Theme.of(context).textTheme.titleSmall,
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1.0,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
            color: Theme.of(context).cardColor,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(right: AppSizes.kDefaultPadding/2),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
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
      ),
    );
  }
}
