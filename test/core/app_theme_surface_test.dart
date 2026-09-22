import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';

void main() {
  test('Light surface is the canonical Xuan paper #FDFCF0', () {
    expect(AppTheme.surfaceLight, const Color(0xFFFDFCF0));
    expect(AppTheme.xuanPaperLight, const Color(0xFFFDFCF0));
  });

  test('Dark surface matches the book screen palette #141416', () {
    expect(AppTheme.surfaceDark, const Color(0xFF141416));
    expect(AppTheme.xuanPaperDark, const Color(0xFF141416));
  });

  test('Theme scaffold background equals the canonical surface', () {
    expect(AppTheme.lightTheme.scaffoldBackgroundColor, AppTheme.surfaceLight);
    expect(AppTheme.darkTheme.scaffoldBackgroundColor, AppTheme.surfaceDark);
    expect(
      AppTheme.lightTheme.colorScheme.surface,
      AppTheme.surfaceLight,
    );
    expect(AppTheme.darkTheme.colorScheme.surface, AppTheme.surfaceDark);
  });

  test('Navigation chrome never differs from the body surface', () {
    expect(
      AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
      AppTheme.surfaceLight,
    );
    expect(
      AppTheme.darkTheme.bottomNavigationBarTheme.backgroundColor,
      AppTheme.surfaceDark,
    );
    expect(
      AppTheme.lightTheme.navigationBarTheme.backgroundColor,
      AppTheme.surfaceLight,
    );
    expect(
      AppTheme.darkTheme.navigationBarTheme.backgroundColor,
      AppTheme.surfaceDark,
    );
  });

  testWidgets('CalligraphyBackground body colour matches the app bar colour',
      (tester) async {
    for (final brightness in Brightness.values) {
      await tester.pumpWidget(
        MaterialApp(
          theme: brightness == Brightness.dark
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          home: Builder(
            builder: (context) {
              final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;
              return Scaffold(
                // No explicit background: must fall back to the theme surface.
                appBar: AppBar(backgroundColor: scaffoldBg),
                body: CalligraphyBackground(child: Container()),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // The body container painted by CalligraphyBackground…
      final body = tester.widget<Container>(
        find.descendant(
          of: find.byType(CalligraphyBackground),
          matching: find.byType(Container),
        ).first,
      );
      final bodyColor = (body.decoration! as BoxDecoration).color;

      // …must equal the app bar colour so no seam is visible.
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(bodyColor, appBar.backgroundColor);
      expect(bodyColor, Theme.of(tester.element(find.byType(Scaffold))).scaffoldBackgroundColor);
    }
  });
}
