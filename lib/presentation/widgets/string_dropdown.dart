import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../core/themes/app_sizes.dart';

class StringDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String hint;

  const StringDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    required this.onChanged,
    this.hint = "Select option",
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline( // 👈 removes underline
      child: DropdownButton2<String>(
        isExpanded: true,
        value: selectedValue,
        hint: Text(hint),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: Theme.of(context).textTheme.titleSmall,),
          );
        }).toList(),
        onChanged: onChanged,
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
      ),
    );
  }
}