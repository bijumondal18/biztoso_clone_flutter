import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';

class MoreOptions {
  final String label;
  final IconData iconPath;

  MoreOptions(this.label, this.iconPath);
}

final List<MoreOptions> moreOptionsList = [
  MoreOptions('Wishlist', EvaIcons.heart),
  MoreOptions('Settings', EvaIcons.settings),
  MoreOptions('My Store', Iconsax.shop5),
  MoreOptions('My Leads', EvaIcons.personDone),
  MoreOptions('Feedback', EvaIcons.messageSquare),
];

final List<MoreOptions> supportOptionsList = [
  MoreOptions('Blog', Iconsax.card5),
  MoreOptions('FAQs', EvaIcons.questionMarkCircle),
  MoreOptions('Knowledge Base', EvaIcons.bulb),
  MoreOptions('User Support', Iconsax.support5),
  MoreOptions('Logout', EvaIcons.logOut),
];
