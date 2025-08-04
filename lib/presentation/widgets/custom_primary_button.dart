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

  const CustomPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.hasIcon = false,
    this.iconPath,
    this.height,
    this.isGradient = true,
  });

  @override
  State<CustomPrimaryButton> createState() => _CustomPrimaryButtonState();
}

class _CustomPrimaryButtonState extends State<CustomPrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

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

  void _animateButton() async {
    await _controller.forward(); // scale down
    await _controller.reverse(); // bounce back with elastic curve
    widget.onPressed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _animateButton,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: widget.height ?? AppSizes.buttonHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            gradient: widget.isGradient == true
                ? AppColors.primaryGradient
                : null,
            border: Border.all(
              width: 0.5,
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainer
                  .withAlpha(80),
            ),
            borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
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
                    color: widget.isGradient == true
                        ? AppColors.white
                        : Theme.of(context).scaffoldBackgroundColor,
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
                    color: widget.isGradient == true
                        ? AppColors.white
                        : Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}