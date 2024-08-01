import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color white;
  final Color richBlack;
  final Color success;
  final Color error;

  AppColors({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.white,
    required this.richBlack,
    required this.success,
    required this.error,
  });

  @override
  ThemeExtension<AppColors> copyWith() => this;

  @override
  ThemeExtension<AppColors> lerp(
          covariant ThemeExtension<AppColors>? other, double t) =>
      this;
}

class LightColor extends AppColors {
  LightColor()
      : super(
          primary: const Color(0xFF0B3F63),
          secondary: const Color(0xFFE5B21A),
          accent: const Color(0xFFE9F2F5),
          white: const Color(0xFFFFFFFF),
          richBlack: const Color(0xFF010B13),
          success: const Color(0xFF008F00),
          error: const Color(0xFFEC0000),
        );
}
