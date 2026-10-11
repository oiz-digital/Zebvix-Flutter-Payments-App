import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color _brandGreen = Color(0xFF079758);
const Color _deepGreen = Color(0xFF073D2D);
const Color _canvasGreen = Color(0xFFF2FFF8);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitUp,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _shimmerController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _canvasGreen,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);

          return ClipRect(
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
                    semanticLabel: 'Zebvix — recharge, bills and payments',
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
                _buildLogoGlow(size),
                _buildShimmer(size),
              ],
            ),
          );
        },
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
