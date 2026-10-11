import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SplashLightEffects extends StatelessWidget {
  const SplashLightEffects({
    required this.size,
    required this.glowAnimation,
    required this.shimmerAnimation,
    required this.logoShimmerAnimation,
    super.key,
  });

  final Size size;
  final Animation<double> glowAnimation;
  final Animation<double> shimmerAnimation;
  final Animation<double> logoShimmerAnimation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _LogoGlow(size: size, animation: glowAnimation),
        _FullScreenShimmer(size: size, animation: shimmerAnimation),
        _LogoShimmer(size: size, animation: logoShimmerAnimation),
      ],
    );
  }
}

class _LogoGlow extends StatelessWidget {
  const _LogoGlow({required this.size, required this.animation});

  final Size size;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = animation.value;
        final diameter = size.width * (0.43 + (0.035 * progress));
        return Positioned(
          top: size.height * 0.155,
          left: (size.width - diameter) / 2,
          width: diameter,
          height: diameter,
          child: Opacity(
            opacity: 0.12 + (0.12 * progress),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.brandGreen.withValues(alpha: 0.34),
                    AppColors.brandGreen.withValues(alpha: 0.13),
                    AppColors.brandGreen.withValues(alpha: 0),
                  ],
                  stops: const [0, 0.54, 1],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.brandGreen.withValues(alpha: 0.16),
                    blurRadius: 38,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FullScreenShimmer extends StatelessWidget {
  const _FullScreenShimmer({required this.size, required this.animation});

  final Size size;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final travel = size.width * 2.15 * animation.value;
        return Positioned(
          left: -size.width * 0.82 + travel,
          top: -size.height * 0.19,
          child: IgnorePointer(
            child: Transform.rotate(
              angle: -0.38,
              child: SizedBox(
                width: size.width * 0.48,
                height: size.height * 1.42,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: const [0, 0.37, 0.49, 0.61, 1],
                      colors: [
                        Colors.white.withValues(alpha: 0),
                        Colors.white.withValues(alpha: 0),
                        Colors.white.withValues(alpha: 0.43),
                        const Color(0xFFC9FFE1).withValues(alpha: 0.18),
                        Colors.white.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LogoShimmer extends StatelessWidget {
  const _LogoShimmer({required this.size, required this.animation});

  final Size size;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final regionWidth = size.width * 0.91;
    final regionHeight = size.height * 0.255;
    final bandWidth = regionWidth * 0.26;

    return Positioned(
      left: size.width * 0.045,
      top: size.height * 0.14,
      width: regionWidth,
      height: regionHeight,
      child: IgnorePointer(
        child: ClipRect(
          key: const ValueKey('zebvix-logo-shimmer'),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final left = -bandWidth +
                  ((regionWidth + bandWidth) * animation.value);
              return Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned(
                    left: left,
                    top: -regionHeight * 0.2,
                    child: Transform.rotate(
                      angle: -0.38,
                      child: SizedBox(
                        width: bandWidth,
                        height: regionHeight * 1.4,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0),
                                Colors.white.withValues(alpha: 0.04),
                                Colors.white.withValues(alpha: 0.4),
                                const Color(0xFFD9FFE8).withValues(alpha: 0.16),
                                Colors.white.withValues(alpha: 0),
                              ],
                              stops: const [0, 0.28, 0.48, 0.68, 1],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.16),
                                blurRadius: 18,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
