import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Centralized Design System for Hanzi Master
/// Implements the "Zen & Ink" Aesthetic
class AppTheme {
  // --- Core Colors ---
  static const Color xuanPaperLight = Color(0xFFFDFCF0); // Warm paper
  static const Color carbonInkLight = Color(0xFF1A1A1B); // Deep ink
  
  static const Color xuanPaperDark = Color(0xFF1A1A1B); // Deep ink background
  static const Color carbonInkDark = Color(0xFFFDFCF0); // White ink text

  static const Color primaryIndigo = Colors.indigo;
  static const Color primaryTeal = Colors.teal;
  static const Color accentRed = Colors.redAccent;
  static const Color accentAmber = Colors.amber;

  // --- Typography (NotoSansSC Mandate) ---
  static const String _fontFamily = 'NotoSansSC';

  static TextTheme _buildTextTheme(Color textColor, Color mutedColor) {
    return TextTheme(
      // Display: Massive characters (Flashcards, Canvas)
      displayLarge: TextStyle(fontFamily: _fontFamily, fontSize: 120, fontWeight: FontWeight.bold, color: textColor),
      displayMedium: TextStyle(fontFamily: _fontFamily, fontSize: 80, fontWeight: FontWeight.bold, color: textColor),
      displaySmall: TextStyle(fontFamily: _fontFamily, fontSize: 48, fontWeight: FontWeight.bold, color: textColor),
      
      // Headlines: Screen Titles, Major Sections
      headlineLarge: TextStyle(fontFamily: _fontFamily, fontSize: 34, fontWeight: FontWeight.bold, color: textColor, letterSpacing: -0.5),
      headlineMedium: TextStyle(fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
      headlineSmall: TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
      
      // Titles: Cards, List Items
      titleLarge: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
      titleMedium: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
      titleSmall: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
      
      // Body: Definitions, Standard Text
      bodyLarge: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.normal, color: textColor),
      bodyMedium: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.normal, color: textColor),
      bodySmall: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.normal, color: mutedColor),
      
      // Labels: Buttons, Pinyin, Tags
      labelLarge: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.bold, color: textColor, letterSpacing: 1.0),
      labelMedium: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.bold, color: mutedColor, letterSpacing: 0.5),
      labelSmall: TextStyle(fontFamily: _fontFamily, fontSize: 10, fontWeight: FontWeight.bold, color: mutedColor, letterSpacing: 0.5),
    );
  }

  // --- Light Theme ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: carbonInkLight,
        primary: primaryIndigo,
        secondary: primaryTeal,
        surface: xuanPaperLight,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: xuanPaperLight,
      textTheme: _buildTextTheme(carbonInkLight, Colors.black54),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: carbonInkLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        iconTheme: IconThemeData(color: carbonInkLight),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: xuanPaperLight,
        indicatorColor: carbonInkLight.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.bold, color: carbonInkLight);
          }
          return TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: carbonInkLight.withValues(alpha: 0.5));
        }),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: xuanPaperLight,
        selectedItemColor: carbonInkLight,
        unselectedItemColor: carbonInkLight.withValues(alpha: 0.5),
        selectedLabelStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500),
      ),
      cardTheme: CardTheme(
        color: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: carbonInkLight.withValues(alpha: 0.1), width: 1),
        ),
      ),
    );
  }

  // --- Dark Theme ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: carbonInkDark,
        primary: Colors.indigo.shade300,
        secondary: Colors.teal.shade300,
        surface: xuanPaperDark,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: xuanPaperDark,
      textTheme: _buildTextTheme(carbonInkDark, Colors.white54),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: carbonInkDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        iconTheme: IconThemeData(color: carbonInkDark),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: xuanPaperDark,
        indicatorColor: carbonInkDark.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.bold, color: carbonInkDark);
          }
          return TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: carbonInkDark.withValues(alpha: 0.5));
        }),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: xuanPaperDark,
        selectedItemColor: carbonInkDark,
        unselectedItemColor: carbonInkDark.withValues(alpha: 0.5),
        selectedLabelStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF2A2A2B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: carbonInkDark.withValues(alpha: 0.1), width: 1),
        ),
      ),
    );
  }
}