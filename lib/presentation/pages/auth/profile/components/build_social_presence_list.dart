import 'package:biztoso/core/resources/app_images.dart';
import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/data/models/profile_response.dart';
import 'package:biztoso/utils/snackbar_helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildSocialPresenceList extends StatelessWidget {
  final List<SocialMedia> socialMedia;
  final double iconSize;
  final double padding;
  final bool isPublicProfile;

  /// Optional: called when user taps Save in the bottom sheet
  /// (platform code, normalized link)
  final void Function(int platform, String link)? onAdd;

  const BuildSocialPresenceList({
    super.key,
    required this.socialMedia,
    this.iconSize = 20,
    this.padding = AppSizes.kDefaultPadding / 1.2,
    this.onAdd,
    required this.isPublicProfile,
  });

  @override
  Widget build(BuildContext context) {
    final items = socialMedia
        .where((e) => (e.link?.trim().isNotEmpty ?? false))
        .toList();

    if (items.isEmpty && onAdd == null) return const SizedBox.shrink();

    final double circleSize = iconSize + padding * 2;

    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.kDefaultPadding),
      child: Wrap(
        spacing: AppSizes.kDefaultPadding / 2,
        runSpacing: AppSizes.kDefaultPadding / 2,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // existing icons
          ...items.map(
            (e) => _SocialIcon(
              platform: e.platform,
              url: e.link!,
              iconSize: iconSize,
              circleSize: circleSize,
            ),
          ),

          // dotted "+" add button
          if (onAdd != null)
            Visibility(
              visible: !isPublicProfile,
              child: _AddSocialButton(
                onPressed: () => _showAddSocialBottomSheet(context),
                size: circleSize,
                iconSize: iconSize,
              ),
            ),
        ],
      ),
    );
  }

  void _showAddSocialBottomSheet(BuildContext context) {
    final platforms = _platformsMap(); // int -> (label, asset)
    int? selected;
    final ctrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            left: AppSizes.kDefaultPadding,
            right: AppSizes.kDefaultPadding,
            bottom:
                MediaQuery.of(ctx).viewInsets.bottom + AppSizes.kDefaultPadding,
            top: AppSizes.kDefaultPadding,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.bottomSheetCornerRadius),
              topRight: Radius.circular(AppSizes.bottomSheetCornerRadius),
            ),
          ),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add social link',
                      style: Theme.of(ctx).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSizes.kDefaultPadding),

                    // platform selector
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: platforms.entries.map((entry) {
                        final p = entry.key;
                        final label = entry.value.$1;
                        final asset = entry.value.$2;
                        final isSel = selected == p;

                        return ChoiceChip(
                          selected: isSel,
                          backgroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                          selectedColor: Theme.of(
                            context,
                          ).primaryColor.withAlpha(100),
                          checkmarkColor: AppColors.white,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(asset, width: 16, height: 16),
                              const SizedBox(width: 8),
                              Text(
                                label,
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(
                                      color: isSel
                                          ? AppColors.white
                                          : Theme.of(
                                              context,
                                            ).colorScheme.surfaceContainer,
                                    ),
                              ),
                            ],
                          ),
                          onSelected: (_) => setState(() => selected = p),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: ctrl,
                      decoration: InputDecoration(
                        labelText: 'Link (e.g. https://instagram.com/username)',
                        labelStyle: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(color: Theme.of(context).hintColor),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.kDefaultPadding,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius,
                          ),
                          borderSide: BorderSide(
                            color: AppColors.hintLight.withAlpha(100),
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius,
                          ),
                          borderSide: BorderSide(
                            color: AppColors.hintLight.withAlpha(100),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius,
                          ),
                          borderSide: BorderSide(
                            color: AppColors.hintLight.withAlpha(100),
                            width: 1.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _save(ctx, selected, ctrl.text),
                    ),

                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                        onPressed: () => _save(ctx, selected, ctrl.text),
                        child: Text(
                          'Save',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _save(BuildContext ctx, int? selected, String link) {
    if (selected == null || link.trim().isEmpty) {
      // basic validation
      SnackBarHelper.show('Select a platform and enter a link');
      return;
    }
    final normalized = _normalize(link);
    onAdd?.call(selected, normalized);
    Navigator.of(ctx).pop();
  }

  Map<int, (String, String)> _platformsMap() => {
    1: ('YouTube', AppImages.icYoutube),
    2: ('Twitter / X', AppImages.icTwitter),
    3: ('Instagram', AppImages.icInstagram),
    4: ('Facebook', AppImages.icWeb),
    // 5: ('Website', AppImages.icWeb),
  };

  String _normalize(String link) {
    final l = link.trim();
    if (l.startsWith('http://') || l.startsWith('https://')) return l;
    return 'https://$l';
  }
}

class _SocialIcon extends StatelessWidget {
  final int? platform;
  final String url;
  final double iconSize;
  final double circleSize;

  const _SocialIcon({
    required this.platform,
    required this.url,
    required this.iconSize,
    required this.circleSize,
  });

  @override
  Widget build(BuildContext context) {
    final (asset, label) = _iconFor(platform);

    return Tooltip(
      message: label,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: SizedBox(
          width: circleSize,
          height: circleSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius*5),
              border: Border.all(
                width: 1,
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainer.withAlpha(150),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                asset,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  (String, String) _iconFor(int? p) {
    switch (p) {
      case 1:
        return (AppImages.icYoutube, 'YouTube');
      case 2:
        return (AppImages.icTwitter, 'Twitter / X');
      case 3:
        return (AppImages.icInstagram, 'Instagram');
      case 4:
        return (AppImages.icWeb, 'Facebook');
      // case 5:
      //   return (AppImages.icWeb, 'Website');
      default:
        return (AppImages.icWeb, 'Link');
    }
  }
}

class _AddSocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final double iconSize;

  const _AddSocialButton({
    required this.onPressed,
    required this.size,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      customBorder: const RoundedRectangleBorder(),
      child: DottedBorder(
        // If your package version supports this API:
        options: RoundedRectDottedBorderOptions(
          dashPattern: const [5, 6],
          radius: Radius.circular(AppSizes.cardCornerRadius * 5),
          strokeCap: StrokeCap.round,
          color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(150),
          strokeWidth: 1,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: SizedBox(
            width: size * 1.7,
            height: size - 8,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
