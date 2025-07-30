import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final double? height;
  const HorizontalDivider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.0,
      height: height??0,
      color: Theme.of(context).dividerColor,
    );
  }
}
