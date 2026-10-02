import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  testWidgets('Shadowing Studio hub fits standard mobile viewports with no scroll required',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
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
          home: ShadowingStudioScreen(showBackButton: false),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final startButton = find.byKey(const Key('shadowing_start_session'));
    expect(startButton, findsOneWidget);

    final scrollFinder = find.byType(SingleChildScrollView);
    expect(scrollFinder, findsOneWidget);
    final scrollableState = tester.state<ScrollableState>(
      find.descendant(of: scrollFinder, matching: find.byType(Scrollable)).first,
    );
    expect(scrollableState.position.maxScrollExtent, equals(0.0));

    // Verify info icon opens the pedagogical guide sheet
    final infoIcon = find.byIcon(Icons.info_outline_rounded);
    expect(infoIcon, findsOneWidget);
    await tester.tap(infoIcon);
    await tester.pumpAndSettle();

    expect(find.text('Studio de répétition et analyse visuelle des tons'),
        findsOneWidget);
  });

  testWidgets(
      'Shadowing Studio session on iPad does not need or allow scrolling',
      (tester) async {
    // 10.2" iPad landscape viewport
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(1024, 768);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(
            initialHanzi: '你好',
            initialPinyin: 'nǐ hǎo',
            initialTranslation: 'Bonjour',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // On iPad, session UI is fixed: no SingleChildScrollView is rendered so the user
    // cannot scroll down and all controls are comfortably visible.
    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(find.text('你好'), findsOneWidget);
    expect(find.byIcon(Icons.mic), findsOneWidget);
  });

  testWidgets(
      'Shadowing Studio session on iPad portrait does not need or allow scrolling',
      (tester) async {
    // 10.2" iPad portrait viewport
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(768, 1024);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(
            initialHanzi: '你好',
            initialPinyin: 'nǐ hǎo',
            initialTranslation: 'Bonjour',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(find.text('你好'), findsOneWidget);
    expect(find.byIcon(Icons.mic), findsOneWidget);
  });

  testWidgets(
      'Shadowing Studio session on mobile phone retains scroll view for compact screens',
      (tester) async {
    // Standard phone viewport
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(
            initialHanzi: '你好',
            initialPinyin: 'nǐ hǎo',
            initialTranslation: 'Bonjour',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // On phones, session UI preserves SingleChildScrollView so small viewports don't clip.
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.text('你好'), findsOneWidget);
    expect(find.byIcon(Icons.mic), findsOneWidget);
  });
}
