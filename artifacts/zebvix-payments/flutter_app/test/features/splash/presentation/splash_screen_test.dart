import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebvix_payments/app/zebvix_app.dart';
import 'package:zebvix_payments/features/splash/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('shows the full-screen Zebvix splash artwork', (tester) async {
    await tester.pumpWidget(const ZebvixApp());
    await tester.pump(const Duration(milliseconds: 1400));

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(CustomPaint), findsOneWidget);
    expect(
      find.byKey(const ValueKey('zebvix-system-status-bar')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('zebvix-status-bar-backdrop')),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel('Zebvix — recharge, bills and payments'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('zebvix-logo-shimmer')), findsOneWidget);
    expect(find.byKey(const ValueKey('zebvix-progress-track')), findsOneWidget);

    final splashImage = tester.widget<Image>(find.byType(Image));
    expect(splashImage.fit, BoxFit.fill);

    final progressFill = tester.widget<FractionallySizedBox>(
      find.byKey(const ValueKey('zebvix-progress-fill')),
    );
    expect(progressFill.widthFactor, greaterThan(0));
    expect(progressFill.widthFactor, lessThan(1));

    await tester.pump(const Duration(seconds: 5));
    final completedProgress = tester.widget<FractionallySizedBox>(
      find.byKey(const ValueKey('zebvix-progress-fill')),
    );
    expect(completedProgress.widthFactor, 1);
  });
}
