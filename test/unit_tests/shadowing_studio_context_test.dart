import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:lpinyin/lpinyin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ShadowingStudioScreen Context Sentence & Target Hanzi Highlight', () {
    test('PinyinHelper generates full sentence pinyin with tone marks for context', () {
      const sentence = '台湾艺术家郑亭亭突然得知';
      final pinyin = PinyinHelper.getPinyinE(
        sentence,
        separator: ' ',
        format: PinyinFormat.WITH_TONE_MARK,
      );

      // Sentence pinyin must contain syllables for words across the sentence, not just a single character
      expect(pinyin, contains('tái'));
      expect(pinyin, contains('wān'));
      expect(pinyin, contains('zhèng'));
      expect(pinyin, contains('dé'));
      expect(pinyin, contains('zhī'));
      expect(pinyin.split(' ').length, greaterThan(4));
    });

    testWidgets('renders full sentence and highlights the specific tapped character in Scholar Indigo', (tester) async {
      const targetChar = '得';
      const sentence = '8月初，台湾艺术家郑亭亭突然得知消息。';
      final sentencePinyin = PinyinHelper.getPinyinE(
        sentence,
        separator: ' ',
        format: PinyinFormat.WITH_TONE_MARK,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ShadowingStudioScreen(
                initialHanzi: targetChar,
                initialContextSentence: sentence,
                initialPinyin: sentencePinyin,
                initialTranslation: 'In early August, Taiwanese artist Cheng Ting-Ting suddenly learned the news.',
                isCompact: false,
              ),
            ),
          ),
        ),
      );

      // Allow frame to render
      await tester.pump();

      // Verify the sentence pinyin is rendered
      expect(find.text(sentencePinyin), findsOneWidget);

      // Verify the sentence translation is rendered
      expect(find.text('In early August, Taiwanese artist Cheng Ting-Ting suddenly learned the news.'), findsOneWidget);

      // Verify that the Chinese sentence is rendered with the highlighted target character
      final highlightedFinder = find.byWidgetPredicate((widget) {
        if (widget is Text && widget.textSpan is TextSpan) {
          final span = widget.textSpan as TextSpan;
          final plainText = span.toPlainText();
          if (plainText.contains(sentence)) {
            final children = span.children;
            if (children != null && children.isNotEmpty) {
              for (final child in children) {
                if (child is TextSpan && child.text == targetChar) {
                  final style = child.style;
                  if (style != null &&
                      style.color == const Color(0xFF4F46E5) &&
                      style.fontWeight == FontWeight.bold) {
                    return true;
                  }
                }
              }
            }
          }
        }
        return false;
      });

      expect(highlightedFinder, findsOneWidget);
    });

    testWidgets('renders multi-character tapped word highlighted in full sentence', (tester) async {
      const targetWord = '艺术家';
      const sentence = '台湾艺术家郑亭亭前往伦敦。';
      final sentencePinyin = PinyinHelper.getPinyinE(
        sentence,
        separator: ' ',
        format: PinyinFormat.WITH_TONE_MARK,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ShadowingStudioScreen(
                initialHanzi: targetWord,
                initialContextSentence: sentence,
                initialPinyin: sentencePinyin,
                initialTranslation: 'Taiwanese artist Cheng Ting-Ting traveled to London.',
                isCompact: true,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      final highlightedFinder = find.byWidgetPredicate((widget) {
        if (widget is Text && widget.textSpan is TextSpan) {
          final span = widget.textSpan as TextSpan;
          if (span.toPlainText().contains(sentence)) {
            final children = span.children;
            if (children != null) {
              for (final child in children) {
                if (child is TextSpan && child.text == targetWord) {
                  final style = child.style;
                  if (style != null &&
                      style.color == const Color(0xFF4F46E5) &&
                      style.fontWeight == FontWeight.bold) {
                    return true;
                  }
                }
              }
            }
          }
        }
        return false;
      });

      expect(highlightedFinder, findsOneWidget);
    });
  });
}
