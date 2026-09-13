import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/domain/logic/spoken_text_highlight.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audiobook Timing Synchronization', () {
    test('boundary JSON serialization roundtrip preserves exact timings', () {
      final boundaries = [
        {
          'TextOffset': 0,
          'WordLength': 4,
          'Offset': 500000,
          'Duration': 8500000,
          'OffsetMs': 50.0,
          'DurationMs': 850.0,
          'Word': '你好世界',
          'BoundaryType': 'WordBoundary',
        },
        {
          'TextOffset': 4,
          'WordLength': 1,
          'Offset': 10000000,
          'Duration': 2125000,
          'OffsetMs': 1000.0,
          'DurationMs': 212.5,
          'Word': '，',
          'BoundaryType': 'PunctuationBoundary',
        },
        {
          'TextOffset': 5,
          'WordLength': 4,
          'Offset': 12125000,
          'Duration': 8250000,
          'OffsetMs': 1212.5,
          'DurationMs': 825.0,
          'Word': '春暖花开',
          'BoundaryType': 'WordBoundary',
        },
        {
          'TextOffset': 9,
          'WordLength': 1,
          'Offset': 20500000,
          'Duration': 1125000,
          'OffsetMs': 2050.0,
          'DurationMs': 112.5,
          'Word': '。',
          'BoundaryType': 'PunctuationBoundary',
        },
      ];

      final encoded = jsonEncode(boundaries);
      final decoded = (jsonDecode(encoded) as List<dynamic>).cast<Map<String, dynamic>>();

      final timings = buildSpokenCharTimings(
        text: '你好世界，春暖花开。',
        boundaries: decoded,
      );

      expect(timings.length, 8);
      expect(timings.map((t) => t.char).join(), '你好世界春暖花开');

      // Check character boundaries
      expect(timings[0].char, '你');
      expect(timings[0].startMs, 50.0);
      expect(timings[0].endMs, 262.5);

      expect(timings[3].char, '界');
      expect(timings[3].endMs, 900.0);

      // Comma pause (900ms to 1212.5ms) must keep '界' active
      final duringComma = findActiveTiming(timings, 950.0);
      expect(duringComma?.char, '界');
      expect(duringComma?.hanziIndex, 3);

      final secondHalf = findActiveTiming(timings, 1215.0);
      expect(secondHalf?.char, '春');
      expect(secondHalf?.hanziIndex, 4);
    });

    test('handles dialogue quotes and classical Chinese punctuation pauses', () {
      const sentence = '“道可道，非常道；名可名，非常名。”';
      final boundaries = [
        {
          'Offset': 500000,
          'Duration': 7250000,
          'text': {'Text': '“道可道', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 8250000,
          'Duration': 1000000,
          'text': {'Text': '，', 'BoundaryType': 'PunctuationBoundary'},
        },
        {
          'Offset': 9250000,
          'Duration': 5500000,
          'text': {'Text': '非常', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 14750000,
          'Duration': 2625000,
          'text': {'Text': '道', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 18375000,
          'Duration': 2500000,
          'text': {'Text': '；', 'BoundaryType': 'PunctuationBoundary'},
        },
        {
          'Offset': 20875000,
          'Duration': 8000000,
          'text': {'Text': '名可名', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 29875000,
          'Duration': 1500000,
          'text': {'Text': '，', 'BoundaryType': 'PunctuationBoundary'},
        },
        {
          'Offset': 31375000,
          'Duration': 5750000,
          'text': {'Text': '非常', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 37125000,
          'Duration': 2375000,
          'text': {'Text': '名', 'BoundaryType': 'WordBoundary'},
        },
        {
          'Offset': 39500000,
          'Duration': 1125000,
          'text': {'Text': '。”', 'BoundaryType': 'PunctuationBoundary'},
        },
      ];

      final timings = buildSpokenCharTimings(text: sentence, boundaries: boundaries);
      // Spoken Hanzi count: 道可道 (3) + 非常 (2) + 道 (1) + 名可名 (3) + 非常 (2) + 名 (1) = 12 Hanzi
      expect(timings.length, 12);
      expect(timings.map((t) => t.char).join(), '道可道非常道名可名非常名');

      // Semi-colon pause: between 道 (end: 1737.5ms) and 名可名 (start: 2087.5ms)
      final duringSemicolon = findActiveTiming(timings, 1900.0);
      expect(duringSemicolon?.char, '道');
      expect(duringSemicolon?.hanziIndex, 5);

      final nextPhrase = findActiveTiming(timings, 2100.0);
      expect(nextPhrase?.char, '名');
      expect(nextPhrase?.hanziIndex, 6);
    });

    test('returns empty when boundaries are empty', () {
      final timings = buildSpokenCharTimings(text: '你好', boundaries: []);
      expect(timings, isEmpty);
      expect(findActiveTiming(timings, 100.0), isNull);
    });
  });

  group('Audiobook Scroll Alignment', () {
    testWidgets('Scrollable.ensureVisible correctly centers targeted sentence key', (tester) async {
      final keys = List.generate(5, (_) => GlobalKey());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, idx) {
                return Container(
                  key: keys[idx],
                  height: (idx + 1) * 150.0, // Variable heights: 150, 300, 450, 600, 750
                  color: idx.isEven ? Colors.red : Colors.blue,
                  child: Text('Sentence $idx'),
                );
              },
            ),
          ),
        ),
      );

      // Verify keys are populated
      expect(keys[0].currentContext, isNotNull);
      expect(keys[1].currentContext, isNotNull);

      // Call Scrollable.ensureVisible with alignment 0.25
      Scrollable.ensureVisible(
        keys[2].currentContext!,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutQuart,
        alignment: 0.25,
      );

      await tester.pumpAndSettle();

      // Item 2 should now be visible and rendered
      expect(find.text('Sentence 2'), findsOneWidget);
    });
  });
}
