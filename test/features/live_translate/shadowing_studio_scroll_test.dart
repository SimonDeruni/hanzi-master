import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('Shadowing Studio hub is scrollable so the custom-word search field stays reachable',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(375, 667));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mode de pratique'), findsOneWidget);
    expect(find.text('Configuration'), findsOneWidget);
    expect(find.byKey(const Key('shadowing_start_session')), findsOneWidget);

    final scrollViewFinder = find.byType(SingleChildScrollView);
    expect(scrollViewFinder, findsOneWidget);
    final scrollView = tester.widget<SingleChildScrollView>(scrollViewFinder);
    expect(scrollView.physics, isNot(isA<NeverScrollableScrollPhysics>()));
    expect(scrollView.physics, isA<BouncingScrollPhysics>());

    // On a tall viewport the redesigned hub fits without scrolling, which is the
    // main win of removing the old header/hero/subtitle stack.
    expect(tester.getTopLeft(find.text('Mode de pratique')).dy, lessThan(60));
  });

  testWidgets(
      'Custom word search field can be scrolled into view when the keyboard shrinks the viewport',
      (tester) async {
    // Simulates the soft keyboard reducing the usable height on a standard phone.
    await tester.binding.setSurfaceSize(const Size(375, 320));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final scrollViewFinder = find.byType(SingleChildScrollView);
    final scrollView = tester.widget<SingleChildScrollView>(scrollViewFinder);
    expect(scrollView.physics, isNot(isA<NeverScrollableScrollPhysics>()));

    // Selecting "Mot personnalisé" reveals the dictionary search field.
    await tester.tap(find.text('Mot personnalisé'));
    await tester.pumpAndSettle();

    final customWordField =
        find.widgetWithText(TextFormField, 'Chercher dans le dictionnaire ou saisir un mot personnalisé');
    expect(customWordField, findsOneWidget);

    // The field starts out of view, then a drag must bring it fully on screen.
    final initialOffset = tester.getTopLeft(find.text('Mode de pratique')).dy;
    await tester.drag(scrollViewFinder, const Offset(0, -260));
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(find.text('Mode de pratique')).dy,
        lessThan(initialOffset));
    final fieldRect = tester.getRect(customWordField);
    expect(fieldRect.top, greaterThanOrEqualTo(0));
    expect(fieldRect.bottom,
        lessThanOrEqualTo(tester.view.physicalSize.height / tester.view.devicePixelRatio));
  });

  testWidgets('Shadowing Studio hub has no redundant header above Practice Mode',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The title bar, hero icon and subtitle were removed in the redesign.
    expect(find.text('Studio de répétition'), findsNothing);
    expect(
      find.text(
          'Maîtrisez votre prononciation du mandarin\nen imitant des locuteurs natifs.'),
      findsNothing,
    );
    expect(find.byIcon(Icons.graphic_eq_rounded), findsNothing);

    // Practice Mode is now the first element inside the scroll view.
    final practiceMode = find.text('Mode de pratique');
    expect(practiceMode, findsOneWidget);
    final scrollTop = tester.getTopLeft(find.byType(SingleChildScrollView)).dy;
    expect(tester.getTopLeft(practiceMode).dy, lessThan(scrollTop + 48));
  });
}
