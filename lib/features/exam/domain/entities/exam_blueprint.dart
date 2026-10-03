/// The exam blueprint: what a paper *is*, fixed in the repo rather than conjured
/// from a prompt (`docs/AI_TUTOR_CONCEPT.md` §5.2).
///
/// The whole point of a blueprint is comparability: "HSK 3 practise test" has to
/// mean the same thing on Tuesday as it did on Monday, or two attempts are not
/// worth comparing. So the shape — sections, item counts, minutes, pass mark —
/// lives here, versioned by [ExamBlueprint.id], and the model never invents it.
///
/// **Honesty rules this file encodes** (§5.4.7): a paper built from bundled
/// vocabulary is a *practise* paper in HSK scope. It is not an official HSK test
/// and its score is not an HSK score, and nothing in the UI may say otherwise
/// (see `examNotOfficial`). Item counts are deliberately smaller than a real HSK
/// paper — an app paper you can sit in twenty minutes beats one nobody starts.
library;

/// Which part of the paper a section belongs to.
enum ExamSectionKind {
  /// Audio → choose the character. Needs TTS, which the app has on device.
  listening,

  /// Character ↔ meaning/pinyin, and gap-fill where sentences exist.
  reading,

  /// Reserved: HSK 3+ writing items need sentence data the bundle does not carry
  /// yet, so no blueprint asks for this and the builder would drop it if one did.
  writing,
}

/// The kinds of item the app can build **and grade itself** (§5.3).
///
/// Every one of these has exactly one defensible answer that the builder derives
/// from the app's own data, which is what makes local grading possible and AI
/// grading unnecessary (§5.4.4: closed items are never AI-graded).
///
/// Two are deliberately absent, and the reasons are different from "not yet":
///
///  * **Picture items** (HSK 1-3 listening/reading match a picture). The app ships
///    no vocabulary images, so the stem cannot be built.
///  * **Speaking** (HSK's read-aloud and repeat-after-audio items). Grading one
///    needs a per-word reading from the learner's audio, and the app's only tone
///    grader is fed by a *cloud* transcript (`gemini_service` →
///    `LocalToneGrader.apply`). Without on-device recognition the key cannot be
///    verified locally, and an unverifiable key does not belong in an exam.
enum ExamItemKind {
  /// TTS says the word; the learner picks the character.
  audioToCharacter,

  /// TTS says the word; the learner picks its pinyin, with the options being the
  /// **same syllable in four tones** — a minimal pair, which is the whole skill.
  toneChoice,

  /// The character is shown; the learner picks the meaning.
  characterToMeaning,

  /// The character is shown; the learner picks the pinyin.
  characterToPinyin,

  /// A sentence with a gap; the learner picks the missing word.
  fillBlank,

  /// A passage with one gap; the learner picks the missing word. Slots are only
  /// built when a passage is available, and the key is the word the app blanked.
  passageFill,

  /// Four sentences, three of them untouched and one **altered by the app** with a
  /// declared rule. The key is the sentence the app changed, so the item asks
  /// "which one is broken" with no judgement and no invented answer.
  grammarError,

  /// Jumbled words; the learner puts them back in order. The key is the authored
  /// sentence's own order.
  orderTokens,

  /// TTS says the word; the learner types the pinyin. Graded after normalising
  /// tone marks and tone numbers to the same form.
  dictation,
}

/// One section of a paper.
class ExamSectionPlan {
  const ExamSectionPlan({
    required this.kind,
    required this.items,
    required this.minutes,
    required this.kinds,
  });

  final ExamSectionKind kind;
  final int items;
  final int minutes;

  /// The item kinds this section may use, in priority order. A kind the builder
  /// cannot satisfy from the bundled data is skipped and counted, not faked.
  final List<ExamItemKind> kinds;
}

class ExamBlueprint {
  const ExamBlueprint({
    required this.id,
    required this.level,
    required this.sections,
    this.passMark = 0.6,
  });

  /// Versioned, so a paper knows which definition built it.
  final String id;

  /// HSK level this paper is scoped to (1-6).
  final int level;

  final List<ExamSectionPlan> sections;

  /// 0.6 is HSK's own threshold: levels 3-6 pass at 180/300. Using the real
  /// number keeps the app's "you passed" honest within the practise framing.
  final double passMark;

  static const int minLevel = 1;
  static const int maxLevel = 6;

  int get totalItems => sections.fold(
      0, (int sum, ExamSectionPlan section) => sum + section.items);

  int get totalMinutes => sections.fold(
      0, (int sum, ExamSectionPlan section) => sum + section.minutes);

  bool get hasWriting =>
      sections.any((ExamSectionPlan s) => s.kind == ExamSectionKind.writing);

  /// Listening-first, like the real thing: HSK always opens with audio.
  static const List<ExamItemKind> _listeningKinds = <ExamItemKind>[
    ExamItemKind.audioToCharacter,
    ExamItemKind.audioToCharacter,
    ExamItemKind.toneChoice,
  ];

  /// Reading mixes recognition (meaning) with pronunciation (pinyin), gap-fill
  /// where sentences exist, and — at levels where the corpus supports them — an
  /// error-spotting item and a passage item.
  static const List<ExamItemKind> _readingKinds = <ExamItemKind>[
    ExamItemKind.characterToMeaning,
    ExamItemKind.characterToPinyin,
    ExamItemKind.fillBlank,
    ExamItemKind.grammarError,
    ExamItemKind.passageFill,
  ];

  /// Writing, when the source can carry it: word order and dictation need
  /// sentences, which HSK 1's bundle and cards saved with context have.
  static const List<ExamItemKind> _writingKinds = <ExamItemKind>[
    ExamItemKind.orderTokens,
    ExamItemKind.dictation,
  ];

  /// Item counts and timings per level. The sections grow with the level; the
  /// listening:reading ratio stays roughly 2:3, as in the real paper.
  static final Map<
          int,
          ({
            int listening,
            int listeningMinutes,
            int reading,
            int readingMinutes
          })>
      _shapes = <int,
          ({
    int listening,
    int listeningMinutes,
    int reading,
    int readingMinutes
  })>{
    1: (listening: 10, listeningMinutes: 6, reading: 12, readingMinutes: 10),
    2: (listening: 12, listeningMinutes: 7, reading: 14, readingMinutes: 12),
    3: (listening: 14, listeningMinutes: 8, reading: 16, readingMinutes: 14),
    4: (listening: 16, listeningMinutes: 9, reading: 18, readingMinutes: 16),
    5: (listening: 18, listeningMinutes: 10, reading: 20, readingMinutes: 18),
    6: (listening: 20, listeningMinutes: 12, reading: 24, readingMinutes: 20),
  };

  /// The blueprint for [level], or null when the level is outside 1-6.
  ///
  /// No writing section is planned: HSK 3+ has one, but the app's bundled data
  /// carries sentences for HSK 1 only, and a writing section that silently
  /// vanished would be worse than one that is not promised.
  static ExamBlueprint? forLevel(int level) {
    final ({
      int listening,
      int listeningMinutes,
      int reading,
      int readingMinutes
    })? shape = _shapes[level];
    if (shape == null) return null;
    return ExamBlueprint(
      id: 'hsk$level-practise-v1',
      level: level,
      sections: <ExamSectionPlan>[
        ExamSectionPlan(
          kind: ExamSectionKind.listening,
          items: shape.listening,
          minutes: shape.listeningMinutes,
          kinds: _listeningKinds,
        ),
        ExamSectionPlan(
          kind: ExamSectionKind.reading,
          items: shape.reading,
          minutes: shape.readingMinutes,
          kinds: _readingKinds,
        ),
        // Writing from HSK 3, as in the real paper. Whether it can be *built* is
        // the source's business: word order needs sentences, so a level whose
        // bundle carries none simply has no writing section (and the intro lists
        // what the paper does contain, rather than a count of missing items).
        if (level >= 3)
          ExamSectionPlan(
            kind: ExamSectionKind.writing,
            items: _writingItemsFor(level),
            minutes: _writingMinutesFor(level),
            kinds: _writingKinds,
          ),
      ],
    );
  }

  /// Writing scales more slowly than reading, as it does in the real paper.
  static int _writingItemsFor(int level) => level >= 5 ? 6 : 4;

  static int _writingMinutesFor(int level) => level >= 5 ? 12 : 8;

  /// Every level the app can actually build a paper for.
  static List<int> get supportedLevels => _shapes.keys.toList()..sort();

  /// The fewest words a paper can be made from: four options need five words (the
  /// key plus four to be wrong).
  static const int minimumVocabulary = 5;

  /// A paper **sized to a deck** rather than to a level.
  ///
  /// A deck is not a level: it may hold twelve cards or four hundred. So the shape
  /// scales to what the deck actually has, and the clock scales with it — an exam
  /// from a small deck should be a short exam, not a full paper with two thirds of
  /// its slots dropped. The listening:reading split and the pace per item follow
  /// the HSK shapes above, so the timing still means something.
  ///
  /// Returns null below [minimumVocabulary]: four words are not an exam.
  static ExamBlueprint? forDeck({
    required int vocabularySize,
    int level = 0,
  }) {
    if (vocabularySize < minimumVocabulary) return null;

    // The paper is sized to the deck and split three ways, so the sections add up to
    // the vocabulary the deck actually has: a nine-card deck gets a nine-item paper.
    final int writing = (vocabularySize / 4).round().clamp(2, 6);
    final int listening = (vocabularySize / 4).ceil().clamp(2, 20);
    final int reading = (vocabularySize - listening - writing).clamp(2, 24);

    return ExamBlueprint(
      id: 'deck-practise-v1',
      level: level,
      sections: <ExamSectionPlan>[
        ExamSectionPlan(
          kind: ExamSectionKind.listening,
          items: listening,
          minutes: (listening * 0.6).round().clamp(2, 20),
          kinds: _listeningKinds,
        ),
        ExamSectionPlan(
          kind: ExamSectionKind.reading,
          items: reading,
          minutes: (reading * 0.9).round().clamp(2, 24),
          kinds: _readingKinds,
        ),
        // A deck usually has sentence context and characters, so writing is
        // planned here too; whether it can be built is the source's business.
        ExamSectionPlan(
          kind: ExamSectionKind.writing,
          items: writing,
          minutes: (writing * 2).clamp(3, 14),
          kinds: _writingKinds,
        ),
      ],
    );
  }
}
