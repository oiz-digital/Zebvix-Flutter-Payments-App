import 'package:flutter/material.dart';

import '../painters/sparkle_painter.dart';

class SparkleOverlay extends StatelessWidget {
  const SparkleOverlay({required this.animation, super.key});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                painter: SparklePainter(progress: animation.value),
              );
            },
          ),
        ),
      ),
    );
  }
}
