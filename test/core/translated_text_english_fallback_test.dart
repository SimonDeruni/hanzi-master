import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/core/widgets/translated_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Book chapters carry a hard-coded per-sentence `english` field, and the reader
/// used to print it for every user because its `TranslatedText` branch only ran
/// when that field happened to be empty. The Little Prince was the visible
/// symptom: a French or Japanese reader was shown the English the book data
/// shipped, and the translator was never asked.
///
/// [TranslatedText.englishFallback] is the fix, and these tests pin both halves
/// of its contract: the English is used verbatim when English is the target
/// (with no request spent), and it is only a placeholder otherwise.
class _RecordingTranslationService extends LocalTranslationService {
  _RecordingTranslationService({required String targetLanguage})
      : super(targetLanguage: targetLanguage);

  final List<String> requests = <String>[];
  String result = 'TRADUIT';
  Completer<String>? pending;

  @override
  Future<String> translate(String text) async {
    requests.add(text);
    final Completer<String>? gate = pending;
    if (gate != null) return gate.future;
    return result;
  }
}

const String _chinese =
    '我六岁的时候，在一本书中看到了一幅精彩的插画，画的是一条蟒蛇正在吞食一只野兽。';
const String _bundledEnglish =
    'When I was six years old, I saw a magnificent picture in a book, depicting '
    'a boa constrictor swallowing a wild beast.';
const String _french = 'À six ans, j’ai vu une magnifique image dans un livre.';

Future<_RecordingTranslationService> _pumpTranslatedText(
  WidgetTester tester, {
  required String language,
  String? englishFallback,
  String text = _chinese,
  void Function(_RecordingTranslationService service)? configure,
}) async {
  SharedPreferences.setMockInitialValues(<String, Object>{'app_locale': 'en'});
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final _RecordingTranslationService service =
      _RecordingTranslationService(targetLanguage: language);
  // The widget translates during `initState`, so the fake must already be armed
  // with its result (or its gate) before the first pump.
  configure?.call(service);
  final ProviderContainer container = ProviderContainer(
    overrides: <Override>[
      sharedPreferencesProvider.overrideWithValue(preferences),
      localTranslationServiceProvider.overrideWithValue(service),
    ],
  );
  addTearDown(container.dispose);
  await container.read(translationLanguageProvider.notifier).setLanguage(language);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: Scaffold(
          body: TranslatedText(text, englishFallback: englishFallback),
        ),
      ),
    ),
  );
  return service;
}

void main() {
  testWidgets('an English target shows the bundled English and spends no request',
      (WidgetTester tester) async {
    final _RecordingTranslationService service = await _pumpTranslatedText(
      tester,
      language: 'English',
      englishFallback: _bundledEnglish,
    );
    await tester.pump();

    expect(find.text(_bundledEnglish), findsOneWidget);
    expect(
      service.requests,
      isEmpty,
      reason: 'The chapter data already holds the English; asking the API for it '
          'would burn a request per sentence to produce the same string.',
    );
  });

  testWidgets('a non-English target translates the Chinese, not the English',
      (WidgetTester tester) async {
    final _RecordingTranslationService service = await _pumpTranslatedText(
      tester,
      language: 'French',
      englishFallback: _bundledEnglish,
      configure: (_RecordingTranslationService service) =>
          service.result = _french,
    );
    await tester.pump();
    await tester.pump();

    expect(
      service.requests,
      <String>[_chinese],
      reason: 'The translator must receive the Chinese source. Feeding it the '
          'bundled English would both mistranslate and skip the cache keyed on '
          'the Chinese text.',
    );
    expect(find.text(_french), findsOneWidget);
    expect(
      find.text(_bundledEnglish),
      findsNothing,
      reason: 'The bundled English must not survive as the final line for a '
          'French reader - that was the reported bug.',
    );
  });

  testWidgets('the bundled English holds the line while the translation is in flight',
      (WidgetTester tester) async {
    final _RecordingTranslationService service = await _pumpTranslatedText(
      tester,
      language: 'French',
      englishFallback: _bundledEnglish,
      configure: (_RecordingTranslationService service) =>
          service.pending = Completer<String>(),
    );
    await tester.pump();
    await tester.pump();

    expect(
      find.text(_bundledEnglish),
      findsOneWidget,
      reason: 'While the request is pending the reader must see readable text, '
          'not an empty box and not "...".',
    );

    service.pending!.complete(_french);
    await tester.pump();
    await tester.pump();

    expect(find.text(_french), findsOneWidget);
    expect(find.text(_bundledEnglish), findsNothing);
  });

  testWidgets('a caller with no English fallback keeps the legacy behaviour',
      (WidgetTester tester) async {
    final _RecordingTranslationService service = await _pumpTranslatedText(
      tester,
      language: 'French',
      configure: (_RecordingTranslationService service) =>
          service.result = _french,
    );
    await tester.pump();
    await tester.pump();

    expect(service.requests, <String>[_chinese]);
    expect(find.text(_french), findsOneWidget);
  });
}
