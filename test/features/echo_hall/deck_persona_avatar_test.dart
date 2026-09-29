import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A deck scenario asks the AI to invent a character. Lending that invented
/// persona one of the seven portraits that ship in the bundle put the same
/// stock waiter/doctor face on unrelated characters, so a deck persona now
/// carries no portrait at all and falls back to the gold initial seal.
///
/// These tests pin that rule down on both halves of the flow: the scenario the
/// deck writes from now on, and the `deck_scenarios` cache written before the
/// rule existed (which would otherwise replay its stock photo forever).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Every portrait that ships in the bundle. A deck persona must never borrow
  /// one of them.
  const bundledPortraits = <String>[
    'assets/mascot/doctor_avatar.png',
    'assets/mascot/friend_avatar.png',
    'assets/mascot/guide_avatar.png',
    'assets/mascot/interviewer_avatar.png',
    'assets/mascot/market_vendor_avatar.png',
    'assets/mascot/taxi_driver_avatar.png',
    'assets/mascot/waiter_avatar.png',
  ];

  /// A `deck_scenarios` / `saved_custom_scenarios` entry as it is stored on
  /// disk. `deckId` is what marks it as deck-written.
  Map<String, dynamic> scenarioJson({
    String id = 'deck-hsk2',
    String personaName = 'Grandma Liu',
    String avatar = 'assets/mascot/market_vendor_avatar.png',
    String? deckId = 'hsk2',
  }) {
    return <String, dynamic>{
      'id': id,
      'title': 'Handmade Dumpling Feast',
      'description': 'A warm kitchen scene with the family.',
      'initialAiMessage': '你吃饺子了吗？',
      'initialEnglish': 'Have you eaten the dumplings?',
      'initialPinyin': 'Ni3 chi1 jiao3zi le ma?',
      'systemPrompt': 'You are $personaName. Your ONLY role is $personaName.',
      'targetHskLevel': 2,
      'avatarAssetPath': avatar,
      'quests': <String>['Say hello to the family'],
      'personaName': personaName,
      'isCustom': true,
      'voiceName': 'Kore',
      'deckId': deckId,
    };
  }

  group('isBundledMascotAvatar', () {
    test('recognises every portrait that ships in the bundle', () {
      for (final path in bundledPortraits) {
        expect(ConversationScenario.isBundledMascotAvatar(path), isTrue,
            reason: '$path ships in assets/mascot and must be recognised');
      }
    });

    test('rejects the sentinel, a null, a picked file and any other asset', () {
      expect(ConversationScenario.isBundledMascotAvatar(null), isFalse);
      expect(ConversationScenario.isBundledMascotAvatar(''), isFalse);
      expect(
        ConversationScenario.isBundledMascotAvatar(
            ConversationScenario.noAvatar),
        isFalse,
      );
      // A portrait the user chose arrives as an absolute file path.
      expect(
        ConversationScenario.isBundledMascotAvatar(
            '/var/mobile/app/avatar.png'),
        isFalse,
      );
      expect(
        ConversationScenario.isBundledMascotAvatar(r'C:\Users\simon\avatar.png'),
        isFalse,
      );
      // Other bundled imagery is not a mascot portrait.
      expect(
        ConversationScenario.isBundledMascotAvatar(
            'assets/images/paywall/en/hero.png'),
        isFalse,
      );
    });
  });

  group('a deck-written persona never wears a bundled portrait', () {
    test('rehydration strips the stock portrait from a cached deck scenario',
        () {
      final scenario = ConversationScenario.fromJson(scenarioJson());

      expect(scenario.avatarAssetPath, ConversationScenario.noAvatar);
      expect(scenario.hasAvatar, isFalse);
      expect(scenario.resolvedAvatarAssetPath, ConversationScenario.noAvatar);
    });

    test('the rest of the invented persona survives the strip', () {
      final scenario = ConversationScenario.fromJson(scenarioJson());

      expect(scenario.personaName, 'Grandma Liu');
      expect(scenario.deckId, 'hsk2');
      expect(scenario.voiceName, 'Kore');
      expect(scenario.isCustom, isTrue);
    });

    test('a non-deck scenario keeps whatever portrait it carries', () {
      // `fromJson` rewrites deck-written personas only. A curated built-in that
      // the user bookmarked keeps its portrait — Auntie Chen really is the
      // market vendor — so the deck rule must not reach it.
      final scenario = ConversationScenario.fromJson(
        scenarioJson(deckId: null, avatar: 'assets/mascot/friend_avatar.png'),
      );

      expect(scenario.avatarAssetPath, 'assets/mascot/friend_avatar.png');
      expect(scenario.hasAvatar, isTrue);
    });

    test('the rule survives a save/load round trip', () {
      final saved = ConversationScenario.fromJson(scenarioJson());
      final reloaded = ConversationScenario.fromJson(saved.toJson());

      expect(reloaded.hasAvatar, isFalse);
      expect(reloaded.deckId, 'hsk2');
    });
  });

  test('the deck generator never hands a portrait to the invented persona', () {
    // `_generateFromDeck` asks Gemini for the persona, so its avatar decision
    // cannot be driven from a test without mocking the model. Pin the line
    // instead — the same source-guard idiom the creator's parity test uses.
    final source = File(
      'lib/features/echo_hall/presentation/screens/scenario_selection_screen.dart',
    ).readAsStringSync();

    expect(source, contains('avatarAssetPath: ConversationScenario.noAvatar'),
        reason: 'A deck persona is invented by the AI: it must not wear an '
            'image that already exists');
  });

  testWidgets('a cached deck persona renders as a seal, not a stock photo',
      (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'saved_custom_scenarios': jsonEncode(<Map<String, dynamic>>[
        scenarioJson(personaName: 'Grandma Liu'),
      ]),
    });

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

    // The saved deck scenario is prepended to the list, so its card is the
    // nearest InkWell ancestor of the persona name.
    final card = find
        .ancestor(
          of: find.text('Grandma Liu'),
          matching: find.byType(InkWell),
        )
        .first;

    // The seal, not a portrait: no background image, the gold initial instead.
    final avatarFinder =
        find.descendant(of: card, matching: find.byType(CircleAvatar));
    expect(avatarFinder, findsOneWidget);
    expect(tester.widget<CircleAvatar>(avatarFinder).backgroundImage, isNull);
    expect(find.descendant(of: card, matching: find.text('G')), findsOneWidget);

    // And no bundled portrait is painted anywhere inside that card.
    final paintedMascots = tester
        .widgetList<Image>(
            find.descendant(of: card, matching: find.byType(Image)))
        .map((image) => image.image)
        .whereType<AssetImage>()
        .map((provider) => provider.assetName)
        .where((name) => name.startsWith('assets/mascot/'));
    expect(paintedMascots, isEmpty,
        reason: 'a deck persona must not use an image that already exists');
  });
}
