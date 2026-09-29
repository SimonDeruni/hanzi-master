import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:http/http.dart' as http;

/// The shadowing rating is `GeminiService.gradeAudio`'s output, and four of its
/// behaviours were wrong in ways a learner would feel (audit 39):
///
/// * **F2** it *invented* a wrong tone for any word Azure marked incorrect, so a
///   clean tone delivered with a sloppy vowel was reported as the wrong tone;
/// * **F3** it averaged only the words that were evaluated, so omitting half a
///   phrase could still score 100/100;
/// * **F4** it read the expected reading from a context-free per-character
///   lookup, which mis-reads every 多音字 and marked correct speech wrong;
/// * **F5** it advanced the expected-pinyin index by one per word, so after any
///   multi-character word the alignment drifted.
///
/// These tests drive the real grader with a canned Azure response, because the
/// mapping is where all four lived.
class _StubKeyPool extends ApiKeyPool {
  @override
  String get azureSpeechKey => 'test-key';

  @override
  String get azureSpeechRegion => 'test-region';
}

class _SilentAnalytics extends AnalyticsService {
  @override
  Future<void> logApiUsage({
    required String apiName,
    required String feature,
    int? tokensUsed,
    int? durationMs,
    bool success = true,
  }) async {}
}

class _StubClient extends http.BaseClient {
  _StubClient(this.payload);

  final Map<String, dynamic> payload;
  int calls = 0;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    calls++;
    return http.StreamedResponse(
      Stream<List<int>>.value(utf8.encode(jsonEncode(payload))),
      200,
    );
  }
}

Map<String, dynamic> _word(
  String text, {
  int accuracy = 95,
  String? errorType,
  List<String>? syllables,
  bool assessed = true,
}) {
  return <String, dynamic>{
    'Word': text,
    'PronunciationAssessment': <String, dynamic>{
      'AccuracyScore': accuracy,
      // Azure **omits `ErrorType` entirely** for a word it did not assess. This helper
      // always sent one, which is precisely why the `?? 'None'` bug in the service was
      // invisible to every test in this file: the fabricated default and the fixture
      // that hid it were written to agree.
      if (assessed) 'ErrorType': errorType ?? 'None',
      'PronScore': accuracy,
    },
    if (syllables != null)
      'Syllables': <Map<String, dynamic>>[
        for (final String syllable in syllables)
          <String, dynamic>{
            'Syllable': syllable,
            'PronunciationAssessment': <String, dynamic>{
              'AccuracyScore': accuracy,
            },
          },
      ],
  };
}

Map<String, dynamic> _azurePayload(
  List<Map<String, dynamic>> words, {
  int pronScore = 90,
}) {
  return <String, dynamic>{
    'RecognitionStatus': 'Success',
    'NBest': <Map<String, dynamic>>[
      <String, dynamic>{
        'PronunciationAssessment': <String, dynamic>{
          'PronScore': pronScore,
          'AccuracyScore': pronScore,
          'CompletenessScore': 100,
          'FluencyScore': 100,
        },
        'Words': words,
      },
    ],
  };
}

Future<Map<String, dynamic>> _grade(
  List<Map<String, dynamic>> words, {
  required String hanzi,
  required String pinyin,
  int pronScore = 90,
}) {
  final GeminiService service = GeminiService(
    pool: _StubKeyPool(),
    analytics: _SilentAnalytics(),
    httpClient: _StubClient(_azurePayload(words, pronScore: pronScore)),
  );
  return service.gradeAudio(<int>[82, 73, 70, 70, 1, 2, 3, 4], hanzi, pinyin);
}

List<Map<String, dynamic>> _words(Map<String, dynamic> grade) =>
    (grade['words'] as List<dynamic>).cast<Map<String, dynamic>>();

Map<String, dynamic> _first(Map<String, dynamic> grade) =>
    _words(grade).first;

void main() {
  group('F2 - the grader does not invent a tone', () {
    test('a mispronounced word reports "not measured", not a wrong tone',
        () async {
      // 妈 mā, first tone, delivered badly. Azure still names the reference
      // syllable `ma1`. The old code saw `!isCorrect && actTone == expTone` and
      // overwrote the tone with `expTone % 4 + 1` = 2, so the sheet announced
      // "you said the rising tone" - a tone the learner never produced.
      final Map<String, dynamic> grade = await _grade(
        <Map<String, dynamic>>[
          _word('妈', accuracy: 40, errorType: 'Mispronunciation',
              syllables: <String>['ma1']),
        ],
        hanzi: '妈',
        pinyin: 'mā',
      );

      final Map<String, dynamic> word = _first(grade);
      expect(word['expectedTone'], 1);
      expect(
        word['actualTone'],
        0,
        reason: '0 is "not measured". Any 1-5 here would be a fabricated claim '
            'about a tone Azure never reported.',
      );
      expect(word['isCorrect'], isFalse);
    });

    test('a word Azure graded error-free keeps its matching tone', () async {
      // The honest half of the comparison: Azure vouched that nothing was wrong
      // with this word, so the tone it reports is the tone on the page.
      final Map<String, dynamic> grade = await _grade(
        <Map<String, dynamic>>[
          _word('好', accuracy: 96, syllables: <String>['hao3']),
        ],
        hanzi: '好',
        pinyin: 'hǎo',
      );

      final Map<String, dynamic> word = _first(grade);
      expect(word['expectedTone'], 3);
      expect(word['actualTone'], 3);
      expect(word['isCorrect'], isTrue);
    });

    test('every returned tone is either the reference or "not measured"',
        () async {
      // Nothing in between: a value that is neither 0 nor the expected tone
      // would be an invented claim.
      final Map<String, dynamic> grade = await _grade(
        <Map<String, dynamic>>[
          _word('妈', accuracy: 40, errorType: 'Mispronunciation',
              syllables: <String>['ma1']),
          _word('好', accuracy: 96, syllables: <String>['hao3']),
          _word('吗', accuracy: 0, errorType: 'Omission',
              syllables: <String>['ma5']),
        ],
        hanzi: '妈好吗',
        pinyin: 'mā hǎo ma',
      );

      for (final Map<String, dynamic> word in _words(grade)) {
        final int expected = word['expectedTone'] as int;
        final int actual = word['actualTone'] as int;
        expect(
          actual == 0 || actual == expected,
          isTrue,
          reason: '${word['word']} reported actualTone $actual against expected '
              '$expected - that is a tone the grader invented.',
        );
      }
    });
  });

  group('F3 - omissions count against the score', () {
    test('a take that skips half the words cannot score 100', () async {
      final List<Map<String, dynamic>> words = <Map<String, dynamic>>[
        for (int i = 0; i < 5; i++)
          _word('好', accuracy: 100, syllables: <String>['hao3']),
        for (int i = 0; i < 5; i++)
          _word('缺', accuracy: 0, errorType: 'Omission'),
      ];

      final Map<String, dynamic> grade = await _grade(
        words,
        hanzi: '好好好好好缺缺缺缺缺',
        pinyin: 'hǎo hǎo hǎo hǎo hǎo quē quē quē quē quē',
        pronScore: 100,
      );

      expect(
        grade['score'],
        lessThan(60),
        reason: 'Five of ten words were never spoken. The old denominator '
            'dropped omissions, so this take scored 100/100 and told the '
            'learner "Perfect pronunciation! Sounds like a native speaker."',
      );
    });

    test('a complete, accurate take still scores top marks', () async {
      final Map<String, dynamic> grade = await _grade(
        <Map<String, dynamic>>[
          for (int i = 0; i < 4; i++)
            _word('好', accuracy: 100, syllables: <String>['hao3']),
        ],
        hanzi: '好好好好',
        pinyin: 'hǎo hǎo hǎo hǎo',
      );

      expect(grade['score'], 100);
      expect(grade['overallFeedback'],
          'Perfect pronunciation! Sounds like a native speaker.');
    });
  });

  group('F4 - the expected reading comes from the pinyin the learner was shown',
      () {
    test('a 多音字 is graded against the phrase reading, not a default',
        () async {
      // 长 is `cháng` alone but `zhǎng` in 长大. The old code ran
      // `PinyinHelper.getPinyinE` per character and never read the
      // `expectedPinyin` argument, so a learner who said exactly what the screen
      // displayed was marked against the wrong tone.
      final Map<String, dynamic> grade = await _grade(
        <Map<String, dynamic>>[
          _word('长', accuracy: 95, syllables: <String>['zhang3']),
        ],
        hanzi: '长',
        pinyin: 'zhǎng',
      );

      final Map<String, dynamic> word = _first(grade);
      expect(word['pinyin'], 'zhǎng',
          reason: 'The pill must echo the reading the learner was shown.');
      expect(
        word['expectedTone'],
        3,
        reason: 'zhǎng is third tone. A context-free lookup returns cháng - '
            'second tone - which marked a correct answer wrong.',
      );
    });
  });

  group('F5 - the expected-pinyin index does not drift', () {
    test('a single character after a two-character word keeps its own pinyin',
        () async {
      // 你好吗 = nǐ hǎo ma. Azure returns Words ['你好', '吗']. The old code
      // advanced the index by ONE per word, so by the time it reached 吗 it read
      // `hǎo` (index 1) instead of `ma` (index 2) and compared the wrong tone.
      //
      // 吗 deliberately carries **no** Azure syllable: with one, the grader could
      // fall back to it and mask a drifted index. Without one, the only source
      // for this character's reading is the caller's pinyin - which is the
      // alignment under test.
      final Map<String, dynamic> grade = await _grade(
        <Map<String, dynamic>>[
          _word('你好', accuracy: 95, syllables: <String>['ni3', 'hao3']),
          _word('吗', accuracy: 95),
        ],
        hanzi: '你好吗',
        pinyin: 'nǐ hǎo ma',
      );

      final List<Map<String, dynamic>> words = _words(grade);
      expect(words, hasLength(3),
          reason: 'A two-character word is decomposed into two pills.');

      expect(words[0]['word'], '你');
      expect(words[0]['pinyin'], 'nǐ');
      expect(words[0]['expectedTone'], 3);

      expect(words[1]['word'], '好');
      expect(words[1]['pinyin'], 'hǎo');
      expect(words[1]['expectedTone'], 3);

      expect(words[2]['word'], '吗');
      expect(words[2]['pinyin'], 'ma',
          reason: 'Drifted alignment would have used `hǎo` here.');
      expect(words[2]['expectedTone'], 5,
          reason: '吗 is neutral tone; a drifted index reported third tone.');
    });
  });

  group('F1 - the fabrication idiom is gone from the source', () {
    test('no code fabricates a tone from an accuracy percentage', () {
      // A behavioural test cannot reach the tap handlers, and this is the exact
      // shape that was wrong in four places, so pin the source.
      final StringBuffer offenders = StringBuffer();
      for (final FileSystemEntity entity
          in Directory('lib').listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;
        final List<String> lines = entity.readAsLinesSync();
        for (int i = 0; i < lines.length; i++) {
          // Two shapes, both found in the codebase: a tone derived arithmetically
          // from the expected tone, and a tone overwritten by the correctness
          // flag. Neither measures anything.
          if (lines[i].contains('% 4 + 1') ||
              lines[i].contains('isCorrect ? expected : actual')) {
            offenders.writeln('${entity.path}:${i + 1}: ${lines[i].trim()}');
          }
        }
      }
      expect(
        offenders.toString(),
        isEmpty,
        reason: 'A tone is being computed from an accuracy score instead of '
            'reported by the grader. Pass 0 ("not measured") instead:\n'
            '$offenders',
      );
    });
  });

  group('F6 - a take nobody assessed is not a low score', () {
    // The report: *"sometimes it seems so lenient, like if I talk in another language I
    // still get a 15% grades"*. The 15 was the app's, not Azure's: a word with no
    // `ErrorType` was read as *pronounced with no error*, inherited the take's overall
    // accuracy, and was averaged into the score.

    test('an unassessed word is not reported as pronounced correctly', () async {
      final grade = await _grade(
        [_word('妈', accuracy: 95, assessed: false)],
        hanzi: '妈',
        pinyin: 'mā',
      );

      expect(_first(grade)['assessed'], isFalse);
      expect(_first(grade)['isCorrect'], isFalse,
          reason: 'a word Azure never scored is not a word it scored well');
      expect(grade['heardPhrase'], isFalse);
    });

    test("an unassessed word does not inherit the take's accuracy", () async {
      // Accuracy 0 and no ErrorType, beside an overall score of 90. The old fallback
      // handed this word the 90 — a number nobody earned, straight into the average.
      final grade = await _grade(
        [_word('妈', accuracy: 0, assessed: false)],
        hanzi: '妈',
        pinyin: 'mā',
        pronScore: 90,
      );

      expect(_first(grade)['wordScore'], 0);
    });

    test("nothing to score reports 0, not Azure's overall score", () async {
      final grade = await _grade(
        [_word('妈', accuracy: 0, assessed: false)],
        hanzi: '妈',
        pinyin: 'mā',
        pronScore: 90,
      );

      expect(grade['score'], 0,
          reason: "Azure's 90 is the take's score, not this word's");
      expect(grade['heardPhrase'], isFalse);
    });

    test('a phrase that was skipped is not an attempt', () async {
      final grade = await _grade(
        [_word('你好', errorType: 'Omission', accuracy: 0)],
        hanzi: '你好',
        pinyin: 'nǐ hǎo',
      );

      expect(grade['heardPhrase'], isFalse);
      expect(grade['score'], 0);
      expect(grade['overallFeedback'], contains('could not hear'));
    });

    test('a real attempt is still graded, and still praised', () async {
      final grade = await _grade(
        [_word('你好', accuracy: 95)],
        hanzi: '你好',
        pinyin: 'nǐ hǎo',
      );

      expect(grade['heardPhrase'], isTrue);
      expect(grade['score'], 95);
      expect(grade['overallFeedback'], isNot(contains('could not hear')));
    });
  });

  group('F7 - the favourable default for missing data cannot come back', () {
    test('nothing defaults a missing Azure ErrorType to a benign value', () {
      // `ErrorType ?? 'None'` reads as "pronounced with no error" when the truth is
      // "never assessed". It is what let an unassessable take come back with a
      // percentage, and it was invisible here because `_word` used to fabricate the same
      // default in its fixtures — the bug and the test that hid it were written to agree.
      // Flattening the file is deliberate: the offending expression wraps across lines,
      // and matching line-by-line would also catch the comments that explain it.
      final StringBuffer offenders = StringBuffer();
      for (final FileSystemEntity entity
          in Directory('lib').listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;
        final String flat =
            entity.readAsLinesSync().map((String l) => l.trim()).join(' ');

        if (flat.contains("?['ErrorType'] ?? w['ErrorType'] ?? 'None'")) {
          offenders.writeln('${entity.path}: ErrorType defaults to None');
        }
        if (flat.contains("wAccuracy == 0 && wErrorType == 'None'")) {
          offenders.writeln(
              '${entity.path}: accuracy inherited without checking `assessed`');
        }
      }
      expect(
        offenders.toString(),
        isEmpty,
        reason: 'A missing Azure ErrorType is being defaulted to a benign value '
            'again. It means "not assessed", not "no error" — use `NotAssessed` and '
            'gate the consequence on `assessed`:\n$offenders',
      );
    });
  });
}
