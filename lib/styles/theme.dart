import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

ThemeData kCustomTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: CustomColor.scaffoldBg,
  colorScheme: const ColorScheme.dark(
    primary: CustomColor.yellowPrimary,
    secondary: CustomColor.yellowSecondary,
    surface: CustomColor.bgLight1,
  ),
  textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
  iconTheme: const IconThemeData(
    color: CustomColor.whitePrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: CustomColor.yellowPrimary,
      foregroundColor: Colors.white,
      shadowColor: CustomColor.yellowPrimary.withValues(alpha: 0.4),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      fixedSize: const Size.fromHeight(45),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        letterSpacing: 1.0,
      ),
    ),
  ),
);
