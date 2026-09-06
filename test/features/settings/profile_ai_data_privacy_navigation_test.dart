import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/profile_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('uses the standardized emoji-free account header',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [currentUserProvider.overrideWithValue(null)],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ProfileScreen(),
        ),
      ),
    );

    expect(find.widgetWithText(AppBar, 'Account'), findsOneWidget);
    expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);
    expect(find.text('Guest Scholar'), findsOneWidget);
    expect(find.text('Local Account'), findsOneWidget);
    expect(find.text('Create Account to Sync Progress'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });

  testWidgets('shows AI Data & Privacy directly below Q&A / FAQ',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [currentUserProvider.overrideWithValue(null)],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ProfileScreen(),
        ),
      ),
    );

    final faq = find.text('Q&A / FAQ');
    final aiPrivacy = find.text('AI Data & Privacy');

    expect(faq, findsOneWidget);
    expect(aiPrivacy, findsOneWidget);
    expect(tester.getTopLeft(aiPrivacy).dy,
        greaterThan(tester.getTopLeft(faq).dy));

    await tester.ensureVisible(find.byKey(const Key('ai-data-privacy-tile')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('ai-data-privacy-tile')));
    await tester.pumpAndSettle();

    expect(find.text('When AI is used'), findsOneWidget);
  });
}
