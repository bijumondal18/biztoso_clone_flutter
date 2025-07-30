import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/resources/app_images.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double? radius;
  final VoidCallback onPressed;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 34,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: radius,
          height: radius,
          fit: BoxFit.cover,
          placeholder: (context, value) => _defaultAvatar(),
          errorWidget: (context, value, error) => _defaultAvatar(),
        ),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Image.asset(
      AppImages.avatarPlaceholder,
      width: radius,
      height: radius,
      fit: BoxFit.cover,
    );
  }
}
