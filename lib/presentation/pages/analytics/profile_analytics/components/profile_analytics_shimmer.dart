import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileAnalyticsShimmerList extends StatelessWidget {
  const ProfileAnalyticsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _shimmerBox(context: context,height: 46, width: 140),
        const SizedBox(height: 16),
        /// Profile Overview Card
        _shimmerCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(context: context,height: 18, width: 140),
              const SizedBox(height: 16),
              Row(
                children: [
                  _shimmerCircle(size: 56),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(context: context,height: 14, width: 100),
                      const SizedBox(height: 8),
                      _shimmerBox(context: context,height: 12, width: 80),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _shimmerBox(context: context,height: 14, width: 100),
                  _shimmerBox(context: context,height: 14, width: 40),
                ],
              ),
              const SizedBox(height: 12),
              _shimmerBox(context: context,height: 8, width: double.infinity),
            ],
          ),
        ),

        /// Profile Completion Score Card
        _shimmerCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(context: context,height: 18, width: 200),
              const SizedBox(height: 16),
              _shimmerBox(context: context,height: 150, width: double.infinity, radius: 16),
              const SizedBox(height: 16),
              Row(
                children: [
                  _shimmerCircle(size: 40),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(context: context,height: 14, width: 160),
                      const SizedBox(height: 6),
                      _shimmerBox(context: context,height: 14, width: 140),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        /// Profile Views Card
        _shimmerCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(context: context,height: 18, width: 140),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _shimmerBox(
                      context: context,
                      height: 120,
                      width: double.infinity,
                      radius: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _shimmerBox(
                      context: context,
                      height: 120,
                      width: double.infinity,
                      radius: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _shimmerCircle(size: 40),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(context: context,height: 14, width: 60),
                      const SizedBox(height: 6),
                      _shimmerBox(context: context,height: 14, width: 160),
                    ],
                  ),
                ],
              ),
            ],
          ),
          context: context,
        ),

        /// Search to profile view rate card
        _shimmerCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(context: context, height: 18, width: 200),
              const SizedBox(height: 16),
              _shimmerBox(context: context,height: 150, width: double.infinity, radius: 16),
            ],
          ),
          context: context,
        ),
      ],
    );
  }

  /// ---- Helpers ----

  static Widget _shimmerCard({
    required BuildContext context,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).dividerColor.withAlpha(130),
        highlightColor: Theme.of(context).dividerColor.withAlpha(60),
        child: child,
      ),
    );
  }

  static Widget _shimmerBox({
    required BuildContext context,
    double? height,
    double? width,
    double radius = 8,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  static Widget _shimmerCircle({double size = 40}) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
