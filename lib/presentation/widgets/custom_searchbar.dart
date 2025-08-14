import 'package:biztoso/core/resources/app_images.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/themes/app_sizes.dart';

class CustomSearchbar extends StatelessWidget {
  final String? searchHintText;
  final TextEditingController controller;

  /// NEW: callbacks
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onVoiceTap; // optional, if you want to handle voice tap

  const CustomSearchbar({
    super.key,
    this.searchHintText,
    required this.controller,
    this.onChanged,
    this.onClear,
    this.onVoiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
        border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
      ),
      child: Row(
        // if you use a custom `spacing:` extension, keep it; otherwise remove
        children: [
          Icon(EvaIcons.search, color: Theme.of(context).hintColor),

          const SizedBox(width: AppSizes.kDefaultPadding / 4),

          // Text field
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged, // <-- NEW: forward changes
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: searchHintText,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding / 2,
                  vertical: 10.0,
                ),
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).hintColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          // Clear button appears only when there's text
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              final hasText = value.text.trim().isNotEmpty;
              if (!hasText) return const SizedBox.shrink();
              return Row(
                children: [
                  IconButton(
                    splashRadius: 18,
                    tooltip: 'Clear',
                    icon: Icon(Icons.close, size: 18, color: Theme.of(context).hintColor),
                    onPressed: () {
                      controller.clear();
                      // Notify listeners that text is now empty
                      onChanged?.call('');
                      onClear?.call();
                    },
                  ),
                ],
              );
            },
          ),

          // Voice icon (optional)
          GestureDetector(
            onTap: onVoiceTap,
            child: SvgPicture.asset(AppImages.imgVoice, width: 20, height: 20),
          ),
        ],
      ),
    );
  }
}
