import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PeopleYouMayKnowButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PeopleYouMayKnowButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      dense: true,
      title: Text(
        'People You May Know',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        EvaIcons.arrowIosForward,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
