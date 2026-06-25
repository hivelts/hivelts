import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00E5FF); // Cyan/Neon Blue
  static const Color secondaryColor = Color(0xFF7C4DFF); // Deep Purple Accent
  static const Color backgroundColor = Color(0xFF000000); // Obsidian Dark
  static const Color surfaceColor = Color(0xFF131B2F); // Slightly lighter for cards
  static const Color textPrimary = Color(0xFFF8F9FA); // Off-White
  static const Color textSecondary = Color(0xFFA0AABF); // Grayish Blue

  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF131315),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFADC6FF),
        onPrimary: Color(0xFF002E68),
        primaryContainer: Color(0xFF004493),
        onPrimaryContainer: Color(0xFFD8E2FF),
        secondary: Color(0xFFADC6FF),
        onSecondary: Color(0xFF152A78),
        secondaryContainer: Color(0xFF6664E4),
        onSecondaryContainer: Color(0xFFE2DFFF),
        tertiary: Color(0xFFFFB595),
        onTertiary: Color(0xFF1B1B1D),
        tertiaryContainer: Color(0xFFC64F00),
        surface: Color(0xFF131315),
        surfaceContainerLowest: Color(0xFF0E0E10),
        surfaceContainerLow: Color(0xFF1B1B1D),
        surfaceContainer: Color(0xFF212123),
        surfaceContainerHigh: Color(0xFF2B2B2D),
        surfaceContainerHighest: Color(0xFF333335),
        onSurface: Color(0xFFE4E2E4),
        onSurfaceVariant: Color(0xFFC1C6D7),
        outline: Color(0xFF8B91A0),
        outlineVariant: Color(0xFF414755),
        error: Color(0xFFFFB4AB),
      ),
      textTheme: TextTheme(
        labelMedium: GoogleFonts.inter(color: white, fontSize: 13, fontWeight: FontWeight.w500),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(color: white, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFCF8FB),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0058BC),
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF0070EB),
        onPrimaryContainer: Color(0xFFFEFCFF),
        secondary: Color(0xFF4C4ACA),
        tertiary: Color(0xFF9E3D00),
        surface: Color(0xFFFCF8FB),
        surfaceContainerLowest: Color(0xFFFFFFFF),
        surfaceContainerLow: Color(0xFFF6F3F5),
        surfaceContainer: Color(0xFFF0EDEF),
        surfaceContainerHigh: Color(0xFFEAE7EA),
        surfaceContainerHighest: Color(0xFFE4E2E4),
        onSurface: Color(0xFF1B1B1D),
        onSurfaceVariant: Color(0xFF414755),
        outline: Color(0xFF717786),
        outlineVariant: Color(0xFFC1C6D7),
        error: Color(0xFFBA1A1A),
      ),
      textTheme: TextTheme(
        labelMedium: GoogleFonts.inter(color: black, fontSize: 13, fontWeight: FontWeight.w600),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(color: black, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}
