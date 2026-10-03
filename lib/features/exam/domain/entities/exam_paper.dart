/// A built exam paper — items, sections and a **frozen answer key**.
///
/// Three rules from `docs/AI_TUTOR_CONCEPT.md` §11.3 shape this file:
///
///  * **Items reference the library, they do not invent it.** Every item carries
///    the character it is about plus the app's own pinyin and definition, so an
///    item can be re-rendered (or re-localised) without regenerating anything.
///  * **The answer key is derived locally and frozen.** [ExamItem.answer] is
///    computed from the app's data when the paper is built and stored *with* the
///    paper. A retake is comparable, and a rebuild cannot silently move the
///    answers under a learner mid-sitting.
///  * **Dropped items are counted, not hidden.** [ExamPaper.dropped] is shown in
///    the report, so a thinner paper is visible rather than assumed.
///
/// Everything here round-trips through JSON, because a paper is stored as JSON in
/// a Hive box (the `graded_stories_v2` pattern) so it can be sat again later.
library;

import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';

/// One question.
class ExamItem {
  const ExamItem({
    required this.kind,
    required this.hanzi,
    required this.answer,
    required this.options,
    this.pinyin,
    this.definition,
    this.sentence,
  });

  final ExamItemKind kind;

  /// The word the item is about. Also exactly what TTS speaks for a listening
  /// item, so the audio and the key can never disagree.
  final String hanzi;

  final String? pinyin;
  final String? definition;

  /// For [ExamItemKind.fillBlank]: the sentence with `＿＿` where the word was.
  final String? sentence;

  /// The correct option. The key: derived locally, frozen here.
  final String answer;

  /// Always contains [answer], always distinct, always 4 long — except for a
  /// **typed** item ([ExamItemKind.dictation]), which has no options at all and is
  /// graded from what the learner wrote.
  final List<String> options;

  Map<String, Object?> toJson() => <String, Object?>{
        'k': kind.name,
        'h': hanzi,
        'p': pinyin,
        'd': definition,
        's': sentence,
        'a': answer,
        'o': options,
      };

  static ExamItem? fromJson(Map<String, dynamic> json) {
    final ExamItemKind? kind = ExamItemKind.values
        .where((ExamItemKind value) => value.name == json['k'])
        .firstOrNull;
    final String hanzi = json['h']?.toString() ?? '';
    final String answer = json['a']?.toString() ?? '';
    final List<String> options = <String>[
      for (final Object? option
          in (json['o'] as List<Object?>? ?? const <Object?>[]))
        option.toString(),
    ];
    if (kind == null || hanzi.isEmpty || answer.isEmpty) return null;
    // A typed item has no options; every other kind is unanswerable without them.
    if (kind != ExamItemKind.dictation && options.isEmpty) return null;
    return ExamItem(
      kind: kind,
      hanzi: hanzi,
      pinyin: json['p']?.toString(),
      definition: json['d']?.toString(),
      sentence: json['s']?.toString(),
      answer: answer,
      options: options,
    );
  }
}

/// One section of a paper: its items and the clock that governs them.
class ExamSection {
  const ExamSection({
    required this.kind,
    required this.minutes,
    required this.items,
  });

  final ExamSectionKind kind;
  final int minutes;
  final List<ExamItem> items;

  Map<String, Object?> toJson() => <String, Object?>{
        'k': kind.name,
        'm': minutes,
        'i': <Object?>[for (final ExamItem item in items) item.toJson()],
      };

  static ExamSection? fromJson(Map<String, dynamic> json) {
    final ExamSectionKind? kind = ExamSectionKind.values
        .where((ExamSectionKind value) => value.name == json['k'])
        .firstOrNull;
    if (kind == null) return null;
    final List<ExamItem> items = <ExamItem?>[
      for (final Object? raw
          in (json['i'] as List<Object?>? ?? const <Object?>[]))
        if (raw is Map) ExamItem.fromJson(raw.cast<String, dynamic>()),
    ].whereType<ExamItem>().toList();
    if (items.isEmpty) return null;
    return ExamSection(
      kind: kind,
      minutes: (json['m'] as num?)?.toInt() ?? 1,
      items: items,
    );
  }
}

class ExamPaper {
  const ExamPaper({
    required this.id,
    required this.blueprintId,
    required this.level,
    required this.createdAt,
    required this.passMark,
    required this.sections,
    this.dropped = 0,
    this.deckId,
    this.deckName,
  });

  final String id;

  /// The blueprint definition that built it (§5.2).
  final String blueprintId;

  /// For a bundled paper, the HSK level it is scoped to. For a deck paper it is
  /// the level the deck's cards mostly are, which is only ever used as a label
  /// hint — the vocabulary is the deck's, not the level's.
  final int level;

  final DateTime createdAt;
  final double passMark;
  final List<ExamSection> sections;

  /// Items the blueprint asked for that could not be built from the source.
  final int dropped;

  /// Set when the paper was built from the learner's own deck rather than the
  /// bundled vocabulary — which changes what the paper may claim about itself.
  final String? deckId;
  final String? deckName;

  bool get isFromDeck => deckId != null;

  /// Every item, in sitting order, so an answer is keyed by a flat index.
  List<ExamItem> get items => <ExamItem>[
        for (final ExamSection section in sections) ...section.items,
      ];

  int get totalItems => items.length;

  int get totalMinutes =>
      sections.fold(0, (int sum, ExamSection section) => sum + section.minutes);

  /// The section a flat item index falls in.
  ExamSection sectionOf(int index) {
    int offset = 0;
    for (final ExamSection section in sections) {
      offset += section.items.length;
      if (index < offset) return section;
    }
    return sections.last;
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'id': id,
        'b': blueprintId,
        'l': level,
        'c': createdAt.toIso8601String(),
        'p': passMark,
        'x': dropped,
        'd': deckId,
        'n': deckName,
        's': <Object?>[
          for (final ExamSection section in sections) section.toJson(),
        ],
      };

  static ExamPaper? fromJson(Map<String, dynamic> json) {
    final String id = json['id']?.toString() ?? '';
    if (id.isEmpty) return null;
    final List<ExamSection> sections = <ExamSection?>[
      for (final Object? raw
          in (json['s'] as List<Object?>? ?? const <Object?>[]))
        if (raw is Map) ExamSection.fromJson(raw.cast<String, dynamic>()),
    ].whereType<ExamSection>().toList();
    if (sections.isEmpty) return null;
    return ExamPaper(
      id: id,
      blueprintId: json['b']?.toString() ?? '',
      level: (json['l'] as num?)?.toInt() ?? ExamBlueprint.minLevel,
      createdAt:
          DateTime.tryParse(json['c']?.toString() ?? '') ?? DateTime.now(),
      passMark: (json['p'] as num?)?.toDouble() ?? 0.6,
      dropped: (json['x'] as num?)?.toInt() ?? 0,
      deckId: json['d']?.toString(),
      deckName: json['n']?.toString(),
      sections: sections,
    );
  }
}
