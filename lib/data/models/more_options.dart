import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MoreOptions {
  final String label;
  final IconData iconPath;

  MoreOptions(this.label, this.iconPath);
}

final List<MoreOptions> moreOptionsList = [
  MoreOptions('Wishlist', Iconsax.heart),
  MoreOptions('Settings', EvaIcons.settingsOutline),
  MoreOptions('My Store', Iconsax.shop),
  MoreOptions('My Leads', EvaIcons.personDoneOutline),
  MoreOptions('Feedback', Icons.reviews_outlined),
];

final List<MoreOptions> supportOptionsList = [
  MoreOptions('Blog', Icons.post_add_outlined),
  MoreOptions('FAQs', EvaIcons.questionMarkCircleOutline),
  MoreOptions('Knowledge Base', EvaIcons.bulbOutline),
  MoreOptions('User Support', Iconsax.support),
  MoreOptions('Logout', EvaIcons.logOutOutline),
];
