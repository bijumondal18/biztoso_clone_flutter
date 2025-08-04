import 'package:biztoso/data/models/more_options.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MoreTile extends StatelessWidget {
  final MoreOptions moreOptions;
  final VoidCallback onPressed;

  const MoreTile({
    super.key,
    required this.onPressed,
    required this.moreOptions,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      dense: true,
      leading: Icon(
        moreOptions.iconPath,
        size: 22,
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      title: Text(
        moreOptions.label,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        EvaIcons.arrowIosForward,
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
    );
  }
}
