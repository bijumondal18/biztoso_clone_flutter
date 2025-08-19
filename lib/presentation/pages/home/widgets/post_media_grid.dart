import 'dart:typed_data';

import 'package:biztoso/core/themes/app_colors.dart';
import 'package:biztoso/data/models/post_model.dart';
import 'package:biztoso/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PostMediaGrid extends StatelessWidget {
  final List<String> media;
  final double height;
  final double gap;
  final double radius;
  final VoidCallback Function(int index)? onTap; // optional viewer callback

  const PostMediaGrid({
    super.key,
    required this.media,
    this.height = 220,
    this.gap = 8,
    this.radius = 12,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) return const SizedBox.shrink();

    final count = media.length;
    if (count == 1) return _one(context);
    if (count == 2) return _two(context);
    if (count == 3) return _three(context);

    // 4 or more
    return _fourPlus(context, extra: count - 4);
  }

  // --- Layouts --------------------------------------------------------------

  Widget _one(BuildContext context) {
    return SizedBox(
      height: height,
      child: _tile(0, br: BorderRadius.circular(radius), fit: BoxFit.cover),
    );
  }

  Widget _two(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: _tile(
              0,
              br: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
              ),
            ),
          ),
          SizedBox(width: gap),
          Expanded(
            child: _tile(
              1,
              br: BorderRadius.only(
                topRight: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 3: big left, two stacked right
  Widget _three(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _tile(
              0,
              br: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
              ),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: gap),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _tile(
                    1,
                    br: BorderRadius.only(topRight: Radius.circular(radius)),
                  ),
                ),
                SizedBox(height: gap),
                Expanded(
                  child: _tile(
                    2,
                    br: BorderRadius.only(bottomRight: Radius.circular(radius)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 4+: big left, medium center, 2 stacked right (+N on the last if more)
  Widget _fourPlus(BuildContext context, {required int extra}) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          // big left
          Expanded(
            flex: 2,
            child: _tile(
              0,
              br: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
              ),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: gap),
          // medium center
          Expanded(child: _tile(1)),
          SizedBox(width: gap),
          // two stacked right (3rd & 4th visible)
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _tile(
                    2,
                    br: BorderRadius.only(topRight: Radius.circular(radius)),
                  ),
                ),
                SizedBox(height: gap),
                Expanded(
                  child: Stack(
                    children: [
                      _tile(
                        3,
                        br: BorderRadius.only(
                          bottomRight: Radius.circular(radius),
                        ),
                      ),
                      if (extra > 0)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.35),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(radius),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '+$extra',
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Building a single tile ----------------------------------------------

  Widget _tile(int index, {BorderRadius? br, BoxFit fit = BoxFit.cover,}) {
    final m = media[index];
    final isVideo = AppUtils.isVideoUrl(m);

    return ClipRRect(
      borderRadius: br ?? BorderRadius.zero,
      child: InkWell(
        onTap: onTap != null ? () => onTap!(index) : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            isVideo
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoThumb(m, fit: fit),
                      const _PlayOverlay(),
                    ],
                  )
                : CachedNetworkImage(imageUrl: m, fit: fit),
            if (isVideo) const _PlayOverlay(),
          ],
        ),
      ),
    );
  }
}

class VideoThumb extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const VideoThumb(this.url, {super.key, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: VideoThumbnail.thumbnailData(
        video: url,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 480, // reasonable cache size
        quality: 75,
      ),
      builder: (context, snap) {
        if (snap.hasData) {
          return Image.memory(snap.data!, fit: fit, gaplessPlayback: true);
        }
        // fallback (solid bg) while generating
        return Container(color: Colors.black12);
      },
    );
  }
}

class _PlayOverlay extends StatelessWidget {
  const _PlayOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Center(
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
