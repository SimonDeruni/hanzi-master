/// A line with no Hanzi is text, not ruby.
///
/// The reader prints Chinese as **ruby**: one syllable above each character, paired from
/// a Mandarin dictionary. Run over the one account's book — an English letter — that
/// pairing is meaningless, because the dictionary has fewer syllables than the sentence
/// has characters, so a letter ends up carrying a stray syllable while the rest carry
/// nothing. And the meaning line under it would have been a machine translation of the
/// very words on screen, in a reader whose app language is French.
///
/// `sentenceHasHanzi` is the single rule both places ask, and this file pins it.
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/logic/sentence_script.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/sentence_meaning_line.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The translator, stubbed: the tests are about *whether* it is asked, not what a real
/// service would answer. Its reply is a marker so a leaked call is visible.
class _StubTranslator extends Fake implements LocalTranslationService {
  @override
  Future<String> translate(String text) async => 'TRANSLATED';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUp(() async {
    // The app's own values are capitalised, and the letter's reader is a French one —
    // not the language the letter is in, so the translation path is the one that would
    // have run over it.
    SharedPreferences.setMockInitialValues(<String, Object>{
      'translation_target_language': 'French',
    });
    prefs = await SharedPreferences.getInstance();
  });

  Future<void> pumpMeaningLine(
    WidgetTester tester,
    BookSentence sentence,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          sharedPreferencesProvider.overrideWithValue(prefs),
          localTranslationServiceProvider
              .overrideWithValue(_StubTranslator()),
        ],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SentenceMeaningLine(sentence: sentence),
        ),
      ),
    );
    await tester.pump();
    // The translation is a future: one pump starts it, the next shows its result.
    await tester.pump();
  }

  group('sentenceHasHanzi', () {
    test('is true when there is something to read as Chinese', () {
      for (final String chinese in <String>[
        '你好',
        '我爱你，汉堡包。',
        'a 你好 b',
      ]) {
        expect(sentenceHasHanzi(chinese), isTrue, reason: chinese);
      }
    });

    test('is false for a line that is not Chinese at all', () {
      for (final String text in <String>[
        'Dear BaoBao,',
        'I really enjoyed it.',
        'Simon',
        'With all my love,',
        '',
        '   ',
        '!!!',
        'Café 123',
      ]) {
        expect(sentenceHasHanzi(text), isFalse, reason: '"$text"');
      }
    });
  });

  group('the meaning line', () {
    testWidgets('translates a Chinese sentence', (WidgetTester tester) async {
      await pumpMeaningLine(
        tester,
        const BookSentence(chinese: '你好', pinyin: 'nǐ hǎo', english: 'hello'),
      );

      expect(find.byType(SentenceMeaningLine), findsOneWidget);
      expect(find.text('TRANSLATED'), findsOneWidget);
    });

    testWidgets('adds nothing under a sentence that is already the text',
        (WidgetTester tester) async {
      await pumpMeaningLine(
        tester,
        const BookSentence(
          chinese: 'Dear BaoBao,',
          pinyin: '',
          english: '',
        ),
      );

      // Nothing rendered, and above all no translator: the letter is not "translated
      // into" the reader's language, it is simply shown.
      expect(find.text('TRANSLATED'), findsNothing);
      expect(
        find.byType(Text),
        findsNothing,
        reason: 'the reader is already showing this line',
      );
    });
  });
}
