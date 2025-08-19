import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PickedMediaGridPreview extends StatelessWidget {
  final List<AssetEntity> assets;
  final double height;
  final double gap;
  final double radius;
  final ValueChanged<int>? onTap;

  const PickedMediaGridPreview({
    super.key,
    required this.assets,
    this.height = 220,
    this.gap = 8,
    this.radius = 12,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (assets.isEmpty) return const SizedBox.shrink();
    final n = assets.length;
    if (n == 1) return _one();
    if (n == 2) return _two();
    if (n == 3) return _three();
    return _fourPlus(extra: n - 4);
  }

  // ---- layouts ----
  Widget _one() => SizedBox(
    height: height,
    child: _tile(0, br: BorderRadius.circular(radius), fit: BoxFit.cover),
  );

  Widget _two() => SizedBox(
    height: height,
    child: Row(children: [
      Expanded(child: _tile(0, br: BorderRadius.only(
        topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius),
      ))),
      SizedBox(width: gap),
      Expanded(child: _tile(1, br: BorderRadius.only(
        topRight: Radius.circular(radius), bottomRight: Radius.circular(radius),
      ))),
    ]),
  );

  Widget _three() => SizedBox(
    height: height,
    child: Row(children: [
      Expanded(
        flex: 2,
        child: _tile(0, br: BorderRadius.only(
          topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius),
        ), fit: BoxFit.cover),
      ),
      SizedBox(width: gap),
      Expanded(child: Column(children: [
        Expanded(child: _tile(1, br: BorderRadius.only(topRight: Radius.circular(radius)))),
        SizedBox(height: gap),
        Expanded(child: _tile(2, br: BorderRadius.only(bottomRight: Radius.circular(radius)))),
      ])),
    ]),
  );

  Widget _fourPlus({required int extra}) => SizedBox(
    height: height,
    child: Row(children: [
      Expanded(
        flex: 2,
        child: _tile(0, br: BorderRadius.only(
          topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius),
        ), fit: BoxFit.cover),
      ),
      SizedBox(width: gap),
      Expanded(child: _tile(1)),
      SizedBox(width: gap),
      Expanded(child: Column(children: [
        Expanded(child: _tile(2, br: BorderRadius.only(topRight: Radius.circular(radius)))),
        SizedBox(height: gap),
        Expanded(
          child: Stack(children: [
            _tile(3, br: BorderRadius.only(bottomRight: Radius.circular(radius))),
            if (extra > 0)
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius)),
                  ),
                  child: Text('+$extra',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                ),
              ),
          ]),
        ),
      ])),
    ]),
  );

  // ---- item ----
  Widget _tile(int index, {BorderRadius? br, BoxFit fit = BoxFit.cover}) {
    final a = assets[index];
    final isVideo = a.type == AssetType.video;

    return ClipRRect(
      borderRadius: br ?? BorderRadius.zero,
      child: InkWell(
        onTap: onTap == null ? null : () => onTap!(index),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Fast, flicker-free thumbnail for local assets
            AssetEntityImage(
              a,
              isOriginal: false,
              thumbnailSize: const ThumbnailSize(480, 480),
              fit: fit,
            ),
            if (isVideo)
              const Center(
                child: _PlayOverlay(),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlayOverlay extends StatelessWidget {
  const _PlayOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
      ),
    );
  }
}
