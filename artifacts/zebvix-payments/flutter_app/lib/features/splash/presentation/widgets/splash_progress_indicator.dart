import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SplashProgressIndicator extends StatelessWidget {
  const SplashProgressIndicator({
    required this.size,
    required this.progress,
    super.key,
  });

  final Size size;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    final height = math.max(5.0, size.height * 0.008);

    return Positioned(
      left: size.width * 0.345,
      top: size.height * 0.922,
      width: size.width * 0.309,
      height: height,
      child: AnimatedBuilder(
        animation: progress,
        builder: (context, child) {
          final value = progress.value;
          return Semantics(
            label: 'Zebvix loading progress',
            value: '${(value * 100).round()}%',
            child: ClipRRect(
              key: const ValueKey('zebvix-progress-track'),
              borderRadius: BorderRadius.circular(height / 2),
              child: ColoredBox(
                color: AppColors.progressTrack,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    key: const ValueKey('zebvix-progress-fill'),
                    widthFactor: value,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.progressStart,
                            AppColors.progressEnd,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.brandGreen.withValues(alpha: 0.3),
                            blurRadius: 6,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
