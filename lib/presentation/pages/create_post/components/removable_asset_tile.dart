import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class RemovableAssetTile extends StatefulWidget {
  final AssetEntity asset;
  final double width;
  final double height;
  final Widget image;                // e.g. AssetEntityImage
  final VoidCallback onRemoveConfirmed;

  const RemovableAssetTile({
    super.key,
    required this.asset,
    required this.width,
    required this.height,
    required this.image,
    required this.onRemoveConfirmed,
  });

  @override
  State<RemovableAssetTile> createState() => _RemovableAssetTileState();
}

class _RemovableAssetTileState extends State<RemovableAssetTile> {
  bool _removing = false;

  void _startRemove() {
    if (_removing) return;
    setState(() => _removing = true);
  }

  @override
  Widget build(BuildContext context) {
    // Fade out quickly, then AnimatedSize shrinks to zero, then we notify Cubit.
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      clipBehavior: Clip.hardEdge,
      // When the size animation completes while _removing, tell parent to delete.
      onEnd: () {
        if (_removing) widget.onRemoveConfirmed();
      },
      child: _removing
          ? const SizedBox.shrink()
          : AnimatedOpacity(
        duration: const Duration(milliseconds: 160),
        opacity: _removing ? 0 : 1,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Positioned.fill(child: widget.image),
                Positioned(
                  top: -5,
                  right: -5,
                  child: IconButton(
                    onPressed: _startRemove,
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),
                if (widget.asset.type == AssetType.video)
                  const Positioned(
                    left: 6,
                    bottom: 6,
                    child: Icon(Icons.play_circle_fill,
                        size: 20, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}