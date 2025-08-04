import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class InvitationsButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const InvitationsButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      dense: true,
      title: Text(
        'Invitations',
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
