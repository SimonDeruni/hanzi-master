// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'zen_ink_splash.dart';
import 'zen_motion.dart';

/// Centralized Design System for SinoSpark
/// Implements the "Zen & Ink" Aesthetic
class AppTheme {
  // --- Core Colors ---
  static const Color xuanPaperLight = Color(0xFFFDFCF0); // Warm paper
  static const Color carbonInkLight = Color(0xFF1A1A1B); // Deep ink
  
  static const Color xuanPaperDark = Color(0xFF141416); // Canonical dark surface
  static const Color carbonInkDark = Color(0xFFFDFCF0); // White ink text

  // --- Canonical Surface Tokens (single source of truth) ---
  // Every screen — header, body and navigation — must use these so there is
  // never a visible seam between the app bar and the content beneath it.
  static const Color surfaceLight = xuanPaperLight; // #FDFCF0
  static const Color surfaceDark = xuanPaperDark; // #141416
  static const Color cardBgLight = Colors.white;
  static const Color cardBgDark = Color(0xFF1E1E22);
  static const Color accentLight = Color(0xFF8B0000); // Cinnabar
  static const Color accentDark = Color(0xFFFFCA28); // amber.shade400
  static const Color accentFire = Color(0xFFFF7A00); // Nav highlight / flame

  /// Background for the current brightness. Use for Scaffold, AppBar and nav bar.
  static Color surfaceOf(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? surfaceDark
          : surfaceLight;

  /// Card background for the current brightness.
  static Color cardBgOf(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? cardBgDark
          : cardBgLight;

  /// Accent colour for the current brightness.
  static Color accentOf(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? accentDark
          : accentLight;

  static const Color primaryIndigo = Colors.indigo;
  static const Color primaryTeal = Colors.teal;
  static const Color accentRed = Colors.redAccent;
  static const Color accentAmber = Colors.amber;

  // --- Typography ---
  //
  // Policy (2026-09-26, at the owner's request): the app ships **no** custom
  // font. Every role below - display, headline, title, body, label - is left
  // unspecified, so all text renders in the platform's own face: San Francisco
  // on iOS, Roboto on Android.
  //
  // History worth keeping: a calligraphic family used to be named here
  // (`'NotoSansSC'`) and in 91 further call sites (`'NotoSerifSC'`) while
  // `pubspec.yaml` declared no font at all, so every one of those sites silently
  // fell back to the platform font for the life of the project. Dropping the
  // declarations therefore changes *nothing* visually in those places - it only
  // stops the app from asking for a face it does not carry. The only place the
  // serif was ever actually visible was the brief window in which the OFL
  // subset in `assets/fonts/` shipped; those files are gone again, which also
  // takes ~15 MB off the bundle.
  //
  // Leaving the roles unspecified is what keeps the locale-overflow budgets in
  // `test/core/locale_layout_guard_test.dart` valid: platform metrics are
  // unchanged by this cleanup.
  /// The face used by the **component themes** (app bars, buttons, dialogs).
  ///
  /// Deliberately `null`, which means "platform-native" - San Francisco on iOS,
  /// Roboto on Android. `test/core/typography_guard_test.dart` fails the build
  /// if anything in `lib/` requests a family the app does not ship, which is
  /// what keeps this a deliberate `null` rather than an accidental one.
  static const String? _fontFamily = null;

  static TextTheme _buildTextTheme(Color textColor, Color mutedColor) {
    return TextTheme(
      // Display: Massive characters (Flashcards, Canvas)
      displayLarge: TextStyle(fontSize: 120, fontWeight: FontWeight.bold, color: textColor),
      displayMedium: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: textColor),
      displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: textColor),
// Headlines: Screen Titles, Major Sections
      headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: textColor, letterSpacing: -0.5),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
// Titles: Cards, List Items
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
// Body: Definitions, Standard Text
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: textColor),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: textColor),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: mutedColor),
// Labels: Buttons, Pinyin, Tags
      // Tracking kept deliberately low (0.2): the former 1.0 inflated every
      // Latin/Cyrillic button label by ~10-15% and caused locale overflow.
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor, letterSpacing: 0.2),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: mutedColor, letterSpacing: 0.5),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: mutedColor, letterSpacing: 0.5),
    );
  }

  /// App-wide button geometry that survives every supported language.
  ///
  /// Locale audit (2026-09-22): German, French, Spanish, Italian, Portuguese,
  /// Russian, Vietnamese and Thai expand a label by up to ~2x the English
  /// width, so no button may ever be clamped to a fixed size. Only a minimum
  /// touch target is declared here; the label itself decides the real width.
  static ButtonStyle _localizedButtonGeometry({
    double minHeight = 48,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  }) {
    return ButtonStyle(
      // Minimum size only - `fixedSize`/`maximumSize` would clip long labels.
      minimumSize: WidgetStatePropertyAll<Size>(Size(0, minHeight)),
      // Content-sized padding keeps short and long labels equally comfortable.
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(padding),
      // Tracking is deliberately absent: `letterSpacing` inflated every Latin
      // and Cyrillic label by roughly 10-15%, which caused the overflow.
      textStyle: const WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
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
          // App bar titles are the longest localized strings on a screen.
          letterSpacing: 0.5,
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
      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: carbonInkLight.withValues(alpha: 0.1), width: 1),
        ),
      ),
      // --- Localized Button Geometry (app-wide) ---
      // Every button inherits a flexible minimum size, so a longer translated
      // label can widen the button instead of overflowing its row.
      filledButtonTheme: FilledButtonThemeData(
        style: _localizedButtonGeometry(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _localizedButtonGeometry(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _localizedButtonGeometry(),
      ),
      // Text buttons are frequently inline links, so they keep a lighter frame.
      textButtonTheme: TextButtonThemeData(
        style: _localizedButtonGeometry(
          minHeight: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      // Every push shares one Zen transition. iOS/macOS keep Cupertino because
      // that builder provides the interactive edge-swipe back gesture.
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZenPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: ZenPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: ZenPageTransitionsBuilder(),
          TargetPlatform.fuchsia: ZenPageTransitionsBuilder(),
        },
      ),
      // A tap bleeds cinnabar ink into the paper instead of flashing Flutter's
      // grey disc. `splashColor` is the tint the factory draws with; the factory
      // thins it, so this stays a full-strength accent.
      splashFactory: const ZenInkSplashFactory(),
      splashColor: accentLight,
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
          // App bar titles are the longest localized strings on a screen.
          letterSpacing: 0.5,
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
      cardTheme: CardThemeData(
        color: const Color(0xFF2A2A2B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: carbonInkDark.withValues(alpha: 0.1), width: 1),
        ),
      ),
      // --- Localized Button Geometry (app-wide) ---
      // Mirrors the light theme so both modes stay locale-safe.
      filledButtonTheme: FilledButtonThemeData(
        style: _localizedButtonGeometry(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _localizedButtonGeometry(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _localizedButtonGeometry(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: _localizedButtonGeometry(
          minHeight: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      // Mirrors the light theme so both modes share one page transition.
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZenPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: ZenPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: ZenPageTransitionsBuilder(),
          TargetPlatform.fuchsia: ZenPageTransitionsBuilder(),
        },
      ),
      // Same ink bleed as the light theme, but amber: cinnabar would be invisible
      // on the dark surface.
      splashFactory: const ZenInkSplashFactory(),
      splashColor: accentDark,
    );
  }
}

