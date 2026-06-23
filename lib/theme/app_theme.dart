import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00E5FF); // Cyan/Neon Blue
  static const Color secondaryColor = Color(0xFF7C4DFF); // Deep Purple Accent
  static const Color backgroundColor = Color(0xFF0A0E17); // Obsidian Dark
  static const Color surfaceColor = Color(
    0xFF131B2F,
  ); // Slightly lighter for cards
  static const Color textPrimary = Color(0xFFF8F9FA); // Off-White
  static const Color textSecondary = Color(0xFFA0AABF); // Grayish Blue

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: surfaceColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          color: textPrimary,
          fontSize: 64,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.5,
        ),
        displayMedium: GoogleFonts.outfit(
          color: textPrimary,
          fontSize: 48,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.outfit(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 18,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 16,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.inter(
          color: primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
