import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import 'sparkle_overlay.dart';
import 'splash_light_effects.dart';

class SplashArtwork extends StatelessWidget {
  const SplashArtwork({
    required this.size,
    required this.statusBarMaskHeight,
    required this.entranceAnimation,
    required this.glowAnimation,
    required this.shimmerAnimation,
    required this.logoShimmerAnimation,
    required this.sparkleAnimation,
    super.key,
  });

  final Size size;
  final double statusBarMaskHeight;
  final Animation<double> entranceAnimation;
  final Animation<double> glowAnimation;
  final Animation<double> shimmerAnimation;
  final Animation<double> logoShimmerAnimation;
  final Animation<double> sparkleAnimation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: entranceAnimation,
          child: Image.asset(
            AppAssets.splashArtwork,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
            alignment: Alignment.center,
            semanticLabel: 'Zebvix — recharge, bills and payments',
          ),
          builder: (context, artwork) {
            final progress = entranceAnimation.value;
            return Opacity(
              opacity: 0.9 + (0.1 * progress),
              child: Transform.scale(
                scale: 1.035 - (0.035 * progress),
                child: artwork,
              ),
            );
          },
        ),
        _StatusBarBackdrop(height: statusBarMaskHeight),
        SparkleOverlay(animation: sparkleAnimation),
        SplashLightEffects(
          size: size,
          glowAnimation: glowAnimation,
          shimmerAnimation: shimmerAnimation,
          logoShimmerAnimation: logoShimmerAnimation,
        ),
      ],
    );
  }
}

class _StatusBarBackdrop extends StatelessWidget {
  const _StatusBarBackdrop({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: IgnorePointer(
        child: DecoratedBox(
          key: const ValueKey('zebvix-status-bar-backdrop'),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFE9FFF2),
                AppColors.canvasGreen,
                Color(0xFFE8FFF1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
