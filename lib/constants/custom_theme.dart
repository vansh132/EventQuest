import 'package:eventquest/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData returnTheme(TextTheme textTheme) => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: CustomColors.bgLight,
      colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primaryColor),
      useMaterial3: true,
      textTheme: GoogleFonts.openSansCondensedTextTheme(textTheme).copyWith(
        //heading - nunitoSans
        headlineLarge: GoogleFonts.nunitoSans(
            textStyle: const TextStyle().copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: CustomColors.textBlackColor,
        )),
        headlineMedium: GoogleFonts.nunitoSans(
            textStyle: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: CustomColors.textBlackColor,
        )),
        headlineSmall: GoogleFonts.nunitoSans(
            textStyle: const TextStyle().copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: CustomColors.textBlackColor,
        )),
        //title - roboto Serif
        titleLarge: GoogleFonts.robotoSerif(
            textStyle: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: CustomColors.textBlackColor,
        )),
        titleMedium: GoogleFonts.robotoSerif(
            textStyle: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: CustomColors.textBlackColor,
        )),
        titleSmall: GoogleFonts.robotoSerif(
            textStyle: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: CustomColors.textBlackColor,
        )),
        //body - Poppings
        bodyLarge: GoogleFonts.poppins(
            textStyle: const TextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: CustomColors.textBlackColor,
        )),
        bodyMedium: GoogleFonts.poppins(
            textStyle: const TextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: CustomColors.textBlackColor,
        )),
        bodySmall: GoogleFonts.poppins(
            textStyle: const TextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: CustomColors.textBlackColor.withOpacity(0.5),
        )),
        //lable
        labelLarge: GoogleFonts.openSans(
            textStyle: const TextStyle().copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: CustomColors.textBlackColor,
        )),
        labelMedium: GoogleFonts.openSans(
            textStyle: const TextStyle().copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: CustomColors.textBlackColor.withOpacity(0.5),
        )),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.buttonColor,
            foregroundColor: Colors.white),
      ),
    );
