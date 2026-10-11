import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SparklePainter extends CustomPainter {
  const SparklePainter({required this.progress});

  final double progress;

  static const _sparkles = [
    _Sparkle(x: 0.07, y: 0.19, phase: 0.2, speed: 1.2, radius: 1.8),
    _Sparkle(x: 0.91, y: 0.23, phase: 1.7, speed: 0.8, radius: 2.3),
    _Sparkle(x: 0.05, y: 0.39, phase: 3.1, speed: 1.4, radius: 1.6),
    _Sparkle(x: 0.94, y: 0.46, phase: 4.4, speed: 0.9, radius: 2.0),
    _Sparkle(x: 0.08, y: 0.62, phase: 2.5, speed: 1.1, radius: 2.2),
    _Sparkle(x: 0.92, y: 0.68, phase: 5.3, speed: 1.5, radius: 1.7),
    _Sparkle(x: 0.06, y: 0.82, phase: 0.9, speed: 0.7, radius: 2.1),
    _Sparkle(x: 0.95, y: 0.87, phase: 3.8, speed: 1.3, radius: 1.8),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final sparkle in _sparkles) {
      final angle = (progress * math.pi * 2 * sparkle.speed) + sparkle.phase;
      final twinkle = (math.sin(angle) + 1) / 2;
      final center = Offset(
        size.width * sparkle.x + (math.cos(angle) * size.width * 0.006),
        size.height * sparkle.y +
            (math.sin(angle * 0.72) * size.height * 0.004),
      );
      final radius = sparkle.radius * (1.8 + (twinkle * 0.8));

      canvas.drawCircle(
        center,
        radius * 1.65,
        Paint()
          ..color = AppColors.brandGreen.withValues(
            alpha: 0.04 + (twinkle * 0.09),
          )
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.8),
      );
      canvas.drawCircle(
        center,
        sparkle.radius * 0.72,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.12 + (twinkle * 0.5)),
      );

      if (twinkle > 0.9) {
        final flare = Paint()
          ..color = Colors.white.withValues(alpha: (twinkle - 0.9) * 1.7)
          ..strokeWidth = 0.8
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          center.translate(0, -radius * 2.5),
          center.translate(0, radius * 2.5),
          flare,
        );
        canvas.drawLine(
          center.translate(-radius * 1.8, 0),
          center.translate(radius * 1.8, 0),
          flare,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant SparklePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _Sparkle {
  const _Sparkle({
    required this.x,
    required this.y,
    required this.phase,
    required this.speed,
    required this.radius,
  });

  final double x;
  final double y;
  final double phase;
  final double speed;
  final double radius;
}
