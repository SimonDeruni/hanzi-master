import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/character_chat_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The Bureau du savant can now answer "explain the stroke order" with a real
/// widget — the animated stroke skeleton the app already owns — instead of
/// prose alone. These pin both halves: the lesson attaches when a question
/// asks for stroke order *and* the card carries skeletons, and is withheld
/// (rather than rendered as an empty grid) when the skeletons are missing.
class _NoOpTranslationService extends LocalTranslationService {
  _NoOpTranslationService() : super(targetLanguage: 'English');

  @override
  Future<String> translateEnglishDefinition(String definition,
          {String? hanzi}) async =>
      definition;
}

const _strokes = <String>['M 0 0 L 10 10', 'M 2 2 L 8 8'];

Future<void> _pumpSheet(
  WidgetTester tester, {
  required List<String> strokePaths,
}) async {
  SharedPreferences.setMockInitialValues(
      {'app_locale': 'en', AiConsentSheet.prefKey: true});
  final preferences = await SharedPreferences.getInstance();
  await tester.binding.setSurfaceSize(const Size(800, 1000));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        localTranslationServiceProvider
            .overrideWithValue(_NoOpTranslationService()),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CharacterChatSheet(
            hanzi: '好',
            pinyin: 'hǎo',
            definition: 'good',
            strokePaths: strokePaths,
            messageSender: (String message) async =>
                'Strokes are written top to bottom, left to right.',
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Types [text] and presses send, then drains the reply animation.
Future<void> _ask(WidgetTester tester, String text) async {
  await tester.enterText(find.byType(TextField).first, text);
  await tester.pump();
  await tester.tap(find.byIcon(Icons.arrow_upward));
  for (var frame = 0; frame < 12; frame++) {
    await tester.pump(const Duration(milliseconds: 120));
  }
}

void main() {
  testWidgets('a stroke-order question attaches the animated lesson',
      (tester) async {
    await _pumpSheet(tester, strokePaths: _strokes);
    await _ask(tester, 'Can you explain the stroke order?');

    expect(
      find.byKey(const ValueKey('scholar-stroke-lesson')),
      findsOneWidget,
      reason: 'The reply must show the strokes, not only describe them',
    );
    expect(find.byKey(const ValueKey('scholar-stroke-replay')), findsOneWidget);

    // The canvas keeps a looping "restart" timer alive while it is mounted, so
    // tear the tree down first and then let that last timer fire — otherwise
    // widget tests flag it as pending after the tree is disposed.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('a lesson is withheld when the card has no skeletons',
      (tester) async {
    await _pumpSheet(tester, strokePaths: const <String>[]);
    await _ask(tester, 'What is the stroke order?');

    expect(find.byKey(const ValueKey('scholar-stroke-lesson')), findsNothing,
        reason: 'An empty grid teaches nothing');
  });

  testWidgets('an unrelated question stays prose', (tester) async {
    await _pumpSheet(tester, strokePaths: _strokes);
    await _ask(tester, 'Give me 3 common words that contain this character.');

    expect(find.byKey(const ValueKey('scholar-stroke-lesson')), findsNothing);
  });
}
