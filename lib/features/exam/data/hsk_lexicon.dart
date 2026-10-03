/// The bundled HSK vocabulary, as the exam builder's only source of truth.
///
/// **Nothing here is generated.** Every word, pinyin, definition and sentence
/// comes from `assets/data/`, which is why an exam item can carry a frozen answer
/// key that is actually correct — the alternative (asking a model to produce
/// items) is the pattern §11.3 flags as unfit for exams specifically: a
/// hallucinated pinyin in a *card* is bad study material, but in an *exam* it
/// fails a learner who answered correctly.
///
/// The bundle shapes differ by level and that is a fact of the assets, not a
/// design: HSK 1 is a bare array with a separate sentences file, HSK 2-6 are
/// `{version, hskLevel, vocabulary: [...]}` and carry no sentences at all.
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:hanzi_master/features/exam/domain/entities/exam_word.dart';

abstract final class HskLexicon {
  /// Loaded levels, so a paper and its retake do not re-parse the bundle.
  static final Map<int, List<ExamWord>> _cache = <int, List<ExamWord>>{};

  /// The vocabulary for [level], or an empty list when it cannot be loaded.
  ///
  /// Empty rather than throwing: the caller counts what it could not build and
  /// tells the learner, which is better than an exception in a screen.
  static Future<List<ExamWord>> level(int level) async {
    final List<ExamWord>? cached = _cache[level];
    if (cached != null) return cached;

    try {
      final Map<String, ExamWord> words = <String, ExamWord>{};
      if (level == 1) {
        final String raw = await rootBundle.loadString('assets/data/hsk1.json');
        for (final Object? entry in json.decode(raw) as List<Object?>) {
          if (entry is! Map) continue;
          final ExamWord? word = _fromVocabulary(entry.cast<String, dynamic>());
          if (word != null) words[word.id] = word;
        }
        // HSK 1 is the only level with sentences; they arrive in a second file
        // and are merged by id.
        final String sentences =
            await rootBundle.loadString('assets/data/hsk1_sentences.json');
        for (final Object? entry in json.decode(sentences) as List<Object?>) {
          if (entry is! Map) continue;
          final Map<String, dynamic> map = entry.cast<String, dynamic>();
          final String uuid = map['uuid']?.toString() ?? '';
          final ExamWord? base = words[uuid];
          if (base == null) continue;
          words[uuid] = ExamWord(
            id: base.id,
            hanzi: base.hanzi,
            pinyin: base.pinyin,
            definition: base.definition,
            sentence: _clean(map['example_sentence']),
          );
        }
      } else {
        final String raw =
            await rootBundle.loadString('assets/data/hsk${level}_bundle.json');
        final Map<String, dynamic> bundle =
            (json.decode(raw) as Map).cast<String, dynamic>();
        for (final Object? entry
            in (bundle['vocabulary'] as List<Object?>? ?? const <Object?>[])) {
          if (entry is! Map) continue;
          final ExamWord? word = _fromVocabulary(entry.cast<String, dynamic>());
          if (word != null) words[word.id] = word;
        }
      }

      // Sorted by id so a seeded paper is identical on any device regardless of
      // the order the bundle happens to be written in.
      final List<ExamWord> loaded = words.values.toList()
        ..sort((ExamWord a, ExamWord b) => a.id.compareTo(b.id));
      _cache[level] = loaded;
      return loaded;
    } catch (_) {
      _cache[level] = const <ExamWord>[];
      return const <ExamWord>[];
    }
  }

  static ExamWord? _fromVocabulary(Map<String, dynamic> map) {
    final String uuid = map['uuid']?.toString() ?? '';
    final String hanzi = map['hanzi']?.toString() ?? '';
    final String pinyin = map['pinyin']?.toString() ?? '';
    final String definition = map['definition']?.toString() ?? '';
    if (uuid.isEmpty || hanzi.isEmpty || pinyin.isEmpty || definition.isEmpty) {
      return null;
    }
    return ExamWord(
      id: uuid,
      hanzi: hanzi,
      pinyin: pinyin,
      definition: definition,
    );
  }

  static String? _clean(Object? value) {
    final String text = value?.toString().trim() ?? '';
    return text.isEmpty ? null : text;
  }

  /// Clears the cache. For tests, which load different bundles per case.
  static void reset() => _cache.clear();
}
