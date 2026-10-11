import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zebvix_payments/main.dart';

void main() {
  testWidgets('shows the full-screen Zebvix splash artwork', (tester) async {
    await tester.pumpWidget(const ZebvixApp());
    await tester.pump(const Duration(milliseconds: 1400));

    expect(find.byType(ZebvixSplashScreen), findsOneWidget);
    expect(
      find.bySemanticsLabel('Zebvix — recharge, bills and payments'),
      findsOneWidget,
    );

    final splashImage = tester.widget<Image>(find.byType(Image));
    expect(splashImage.fit, BoxFit.fill);
  });
}
