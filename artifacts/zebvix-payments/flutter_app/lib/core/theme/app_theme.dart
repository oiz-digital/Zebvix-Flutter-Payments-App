import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brandGreen,
      brightness: Brightness.light,
      surface: AppColors.canvasGreen,
      primary: AppColors.brandGreen,
      onPrimary: Colors.white,
      onSurface: AppColors.deepGreen,
    ),
    scaffoldBackgroundColor: AppColors.canvasGreen,
  );
}
