import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ScenarioSelectionScreen(showBackButton: false),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Finds the card [Container] decoration that wraps [labelText].
  BoxDecoration cardDecorationFor(WidgetTester tester, String labelText) {
    final container = tester.widget<Container>(
      find
          .ancestor(
            of: find.text(labelText),
            matching: find.byType(Container),
          )
          .last,
    );
    return container.decoration! as BoxDecoration;
  }

  testWidgets('Create-custom-scenario card uses the book-screen card style',
      (tester) async {
    await pumpScreen(tester);

    final decoration =
        cardDecorationFor(tester, 'Create Custom Scenario');

    // Book cards: radius 18, card background, hairline border, soft shadow.
    expect(decoration.borderRadius, BorderRadius.circular(18),
        reason: 'Book-screen cards use an 18px radius');
    expect(decoration.color, AppTheme.cardBgLight);
    expect(decoration.border, isNotNull,
        reason: 'Book cards carry a hairline border');
    expect(decoration.boxShadow, isNotNull);
    expect(decoration.boxShadow!.first.blurRadius, 10);
    expect(decoration.boxShadow!.first.offset, const Offset(0, 4));
  });

  testWidgets('Generate-from-deck card uses the book-screen card style',
      (tester) async {
    await pumpScreen(tester);

    final decoration = cardDecorationFor(tester, 'Generate from Deck');

    expect(decoration.borderRadius, BorderRadius.circular(18));
    expect(decoration.color, AppTheme.cardBgLight);
    expect(decoration.border, isNotNull);
    expect(decoration.boxShadow!.first.blurRadius, 10);
    expect(decoration.boxShadow!.first.offset, const Offset(0, 4));
  });

  testWidgets('both scenario action cards share identical card geometry',
      (tester) async {
    await pumpScreen(tester);

    final create = cardDecorationFor(tester, 'Create Custom Scenario');
    final generate = cardDecorationFor(tester, 'Generate from Deck');

    expect(create.borderRadius, generate.borderRadius);
    expect(create.color, generate.color);
    expect(create.boxShadow!.first.blurRadius,
        generate.boxShadow!.first.blurRadius);
    expect(create.boxShadow!.first.offset, generate.boxShadow!.first.offset);
  });

  testWidgets('scenario action icons use the shared accent colour',
      (tester) async {
    await pumpScreen(tester);

    // Both circular icon chips must use the canonical accent (cinnabar in
    // light mode) rather than the old hardcoded gold / purple.
    for (final icon in [Icons.auto_awesome, Icons.layers_rounded]) {
      final iconWidget = tester.widget<Icon>(find.byIcon(icon).first);
      expect(iconWidget.color, AppTheme.accentLight,
          reason: '$icon must use AppTheme.accentLight');
    }
  });
}
