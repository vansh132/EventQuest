import 'package:eventquest/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData get light => _base(LightColor());

  ThemeData _base(AppColors color) {
    return ThemeData(
      primaryTextTheme: TextTheme(
        labelLarge: GoogleFonts.raleway(
          fontSize: 24,
          color: color.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.alegreyaSans(
          fontSize: 36,
          color: color.primary,
          shadows: [
            const Shadow(
              color: Colors.grey,
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
          ],
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.robotoSlab(
          fontSize: 24,
          color: color.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.1,
        ),
        bodyLarge: GoogleFonts.publicSans(
          fontSize: 18,
          color: color.richBlack,
        ),
      ),
      useMaterial3: true,
      extensions: [color],
      scaffoldBackgroundColor: color.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(color.primary),
          foregroundColor: WidgetStatePropertyAll(color.white),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
