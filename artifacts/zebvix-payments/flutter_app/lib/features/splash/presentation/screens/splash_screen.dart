import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/platform/system_ui_config.dart';
import '../../../../core/theme/app_colors.dart';
import '../splash_animation_durations.dart';
import '../widgets/splash_artwork.dart';
import '../widgets/splash_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _shimmerController;
  late final AnimationController _glowController;
  late final AnimationController _sparkleController;
  late final AnimationController _logoShimmerController;
  late final AnimationController _progressController;
  late final Animation<double> _entrance;
  late final Animation<double> _loadingProgress;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: SplashAnimationDurations.entrance,
    );
    _entrance = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );
    _entranceController.forward();

    _shimmerController = AnimationController(
      vsync: this,
      duration: SplashAnimationDurations.globalShimmer,
    )..repeat();

    _glowController = AnimationController(
      vsync: this,
      duration: SplashAnimationDurations.logoGlow,
    )..repeat(reverse: true);

    _sparkleController = AnimationController(
      vsync: this,
      duration: SplashAnimationDurations.sparkles,
    )..repeat();

    _logoShimmerController = AnimationController(
      vsync: this,
      duration: SplashAnimationDurations.logoShimmer,
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: SplashAnimationDurations.loadingProgress,
    );
    _loadingProgress = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOutCubic,
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _shimmerController.dispose();
    _glowController.dispose();
    _sparkleController.dispose();
    _logoShimmerController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      key: const ValueKey('zebvix-system-status-bar'),
      value: SystemUiConfig.overlayStyle,
      child: Scaffold(
        backgroundColor: AppColors.canvasGreen,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final viewport = Size(constraints.maxWidth, constraints.maxHeight);
            final isLandscape = viewport.width > viewport.height;
            final size = isLandscape
                ? Size(
                    math.min(viewport.width, viewport.height * 0.46),
                    viewport.height,
                  )
                : viewport;
            final statusMaskHeight = math.max(
              56.0,
              MediaQuery.viewPaddingOf(context).top,
            );

            return ColoredBox(
              color: isLandscape ? AppColors.deepGreen : AppColors.canvasGreen,
              child: Center(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: ClipRect(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        SplashArtwork(
                          size: size,
                          statusBarMaskHeight: statusMaskHeight,
                          entranceAnimation: _entrance,
                          glowAnimation: _glowController,
                          shimmerAnimation: _shimmerController,
                          logoShimmerAnimation: _logoShimmerController,
                          sparkleAnimation: _sparkleController,
                        ),
                        SplashProgressIndicator(
                          size: size,
                          progress: _loadingProgress,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
