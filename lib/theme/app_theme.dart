import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryNavy = Color(0xFF0F172A); // Slate 900
  static const Color secondaryNavy = Color(0xFF1E293B); // Slate 800
  static const Color accentBlue = Color(0xFF2563EB); // Royal Blue
  static const Color accentBlueLight = Color(0xFF3B82F6); // Blue 500
  static const Color accentBlueSoft = Color(0xFFEFF6FF); // Blue 50
  static const Color lightBg = Color(0xFFF8FAFC); // Slate 50
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color borderSubtle = Color(0xFFE2E8F0); // Slate 200
  static const Color borderMedium = Color(0xFFCBD5E1); // Slate 300
  static const Color textMuted = Color(0xFF64748B); // Slate 500
  static const Color textDark = Color(0xFF0F172A); // Navy dark

  // Status Colors
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color infoBlue = Color(0xFF0284C7);

  // Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: primaryNavy,
      colorScheme: const ColorScheme.light(
        primary: accentBlue,
        onPrimary: Colors.white,
        secondary: primaryNavy,
        onSecondary: Colors.white,
        surface: lightSurface,
        onSurface: textDark,
        surfaceContainerHighest: Color(0xFFF1F5F9),
        outline: borderSubtle,
        outlineVariant: borderMedium,
        error: errorRed,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: primaryNavy,
          letterSpacing: -0.8,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: primaryNavy,
          letterSpacing: -0.6,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: primaryNavy,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: primaryNavy,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryNavy,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: secondaryNavy,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF334155),
          height: 1.5,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textMuted,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryNavy),
        titleTextStyle: TextStyle(
          color: primaryNavy,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: borderSubtle, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryNavy,
          side: const BorderSide(color: borderMedium),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentBlue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorRed),
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          color: textMuted,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 13,
          color: const Color(0xFF94A3B8),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: borderSubtle,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // Dark Theme
  static ThemeData darkTheme() {
    const darkBg = Color(0xFF0B0F19);
    const darkSurface = Color(0xFF131B2E);
    const darkBorder = Color(0xFF26334D);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: accentBlueLight,
      colorScheme: const ColorScheme.dark(
        primary: accentBlueLight,
        onPrimary: Colors.white,
        secondary: Color(0xFF93C5FD),
        onSecondary: Colors.black,
        surface: darkSurface,
        onSurface: Color(0xFFF1F5F9),
        surfaceContainerHighest: Color(0xFF1E293B),
        outline: darkBorder,
        outlineVariant: Color(0xFF334155),
        error: errorRed,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -0.8,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -0.6,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFCBD5E1),
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF94A3B8),
          height: 1.5,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: darkBorder, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBlueLight,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: darkBorder),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0F172A),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentBlueLight, width: 1.5),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: darkBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
