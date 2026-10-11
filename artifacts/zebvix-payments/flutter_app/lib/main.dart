import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color _brandGreen = Color(0xFF079758);
const Color _deepGreen = Color(0xFF073D2D);
const Color _canvasGreen = Color(0xFFF2FFF8);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  runApp(const ZebvixApp());
}

class ZebvixApp extends StatelessWidget {
  const ZebvixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zebvix Payments',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _brandGreen,
          brightness: Brightness.light,
          surface: _canvasGreen,
          primary: _brandGreen,
          onPrimary: Colors.white,
          onSurface: _deepGreen,
        ),
        scaffoldBackgroundColor: _canvasGreen,
      ),
      home: const ZebvixSplashScreen(),
    );
  }
}

class ZebvixSplashScreen extends StatefulWidget {
  const ZebvixSplashScreen({super.key});

  @override
  State<ZebvixSplashScreen> createState() => _ZebvixSplashScreenState();
}

class _ZebvixSplashScreenState extends State<ZebvixSplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _shimmerController;
  late final AnimationController _glowController;
  late final AnimationController _sparkleController;
  late final Animation<double> _entrance;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );
    _entrance = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );
    _entranceController.forward();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4400),
    )..repeat();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat(reverse: true);

    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6200),
    )..repeat();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _shimmerController.dispose();
    _glowController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _canvasGreen,
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

          return ColoredBox(
            color: isLandscape ? _deepGreen : _canvasGreen,
            child: Center(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: ClipRect(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedBuilder(
                        animation: _entrance,
                        child: Image.asset(
                          'assets/images/zebvix-splash.png',
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                          alignment: Alignment.center,
                          semanticLabel:
                              'Zebvix — recharge, bills and payments',
                        ),
                        builder: (context, artwork) {
                          final progress = _entrance.value;
                          return Opacity(
                            opacity: progress,
                            child: Transform.scale(
                              scale: 1.035 - (0.035 * progress),
                              child: artwork,
                            ),
                          );
                        },
                      ),
                      _buildSparkles(),
                      _buildLogoGlow(size),
                      _buildShimmer(size),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSparkles() {
    return Positioned.fill(
      child: IgnorePointer(
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _sparkleController,
            builder: (context, child) {
              return CustomPaint(
                painter: _SparklePainter(progress: _sparkleController.value),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogoGlow(Size size) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        final progress = _glowController.value;
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
                    _brandGreen.withValues(alpha: 0.34),
                    _brandGreen.withValues(alpha: 0.13),
                    _brandGreen.withValues(alpha: 0),
                  ],
                  stops: const [0, 0.54, 1],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _brandGreen.withValues(alpha: 0.16),
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

  Widget _buildShimmer(Size size) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        final travel = size.width * 2.15 * _shimmerController.value;
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

class _SparklePainter extends CustomPainter {
  const _SparklePainter({required this.progress});

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
          ..color = _brandGreen.withValues(alpha: 0.04 + (twinkle * 0.09))
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.8),
      );
      canvas.drawCircle(
        center,
        sparkle.radius * 0.72,
        Paint()..color = Colors.white.withValues(alpha: 0.12 + (twinkle * 0.5)),
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
  bool shouldRepaint(covariant _SparklePainter oldDelegate) {
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
