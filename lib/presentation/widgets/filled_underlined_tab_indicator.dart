import 'package:flutter/material.dart';

class FilledUnderlineIndicator extends Decoration {
  final Color fillColor;
  final Color underlineColor;
  final double underlineHeight;
  final BorderRadius borderRadius;

  const FilledUnderlineIndicator({
    required this.fillColor,
    required this.underlineColor,
    this.underlineHeight = 3,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FilledUnderlinePainter(
      fillColor: fillColor,
      underlineColor: underlineColor,
      underlineHeight: underlineHeight,
      borderRadius: borderRadius,
    );
  }
}

class _FilledUnderlinePainter extends BoxPainter {
  final Color fillColor;
  final Color underlineColor;
  final double underlineHeight;
  final BorderRadius borderRadius;

  _FilledUnderlinePainter({
    required this.fillColor,
    required this.underlineColor,
    required this.underlineHeight,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration config) {
    final Rect rect = offset & config.size!;

    // Draw filled background
    final RRect roundedRect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );
    final Paint fillPaint = Paint()..color = fillColor;
    canvas.drawRRect(roundedRect, fillPaint);

    // Draw underline
    final Paint underlinePaint = Paint()..color = underlineColor;
    final Rect underlineRect = Rect.fromLTWH(
      rect.left,
      rect.bottom - underlineHeight,
      rect.width,
      underlineHeight,
    );
    canvas.drawRect(underlineRect, underlinePaint);
  }
}