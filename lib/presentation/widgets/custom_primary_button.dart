import 'package:flutter/material.dart';

import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';

class CustomPrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? hasIcon;
  final IconData? iconPath;
  final double? height;
  final bool? isGradient;

  /// New: control enabled/disabled state
  final bool isEnabled;

  const CustomPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.hasIcon = false,
    this.iconPath,
    this.height,
    this.isGradient = true,
    this.isEnabled = true,
  });

  @override
  State<CustomPrimaryButton> createState() => _CustomPrimaryButtonState();
}

class _CustomPrimaryButtonState extends State<CustomPrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_controller);
  }

  Future<void> _animateButton() async {
    if (!widget.isEnabled) return; // safety
    await _controller.forward();
    await _controller.reverse();
    if (mounted) widget.onPressed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.isEnabled;

    // Colors when enabled vs disabled
    final disabledBase = Theme.of(context).disabledColor.withOpacity(0.25);
    final baseFill = enabled
        ? Theme.of(context).colorScheme.surfaceContainer
        : disabledBase;

    final gradient = (enabled && widget.isGradient == true)
        ? AppColors.primaryGradient
        : null;

    final borderColor = enabled
        ? Theme.of(context).colorScheme.surfaceContainer.withAlpha(80)
        : Theme.of(context).disabledColor.withOpacity(0.25);

    final fgColor = (enabled && widget.isGradient == true)
        ? AppColors.white
        : (enabled
        ? Theme.of(context).scaffoldBackgroundColor
        : Theme.of(context).disabledColor);

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: IgnorePointer(
        ignoring: !enabled,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: enabled ? 1.0 : 0.6,
          child: GestureDetector(
            onTap: enabled ? _animateButton : null,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: widget.height ?? AppSizes.buttonHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: gradient == null ? baseFill : null,
                  gradient: gradient,
                  border: Border.all(width: 0.5, color: borderColor),
                  borderRadius:
                  BorderRadius.circular(AppSizes.cardCornerRadius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.hasIcon == true)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppSizes.kDefaultPadding / 2,
                          top: 2.0,
                        ),
                        child: Icon(
                          widget.iconPath,
                          color: fgColor,
                          size: 18,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.kDefaultPadding / 2,
                      ),
                      child: Text(
                        widget.label,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: fgColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
