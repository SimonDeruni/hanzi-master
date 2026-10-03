/// What the app knows about the learner, as **facts it recorded itself**.
///
/// `docs/AI_TUTOR_CONCEPT.md` §6 asks the tutor to be a tutor rather than a
/// chatbot, and what makes that possible is not a bigger model: it is a record of
/// what actually happened. This is that record, and the design rule is deliberately
/// narrow, because a learner profile is exactly the kind of feature that grows into
/// somewhere to store guesses:
///
///  * **Three questions only.** What should I study next, why is this being shown to
///    me, and am I getting better. A field that answers none of them is not here.
///  * **Every number is traceable.** A tally is a count of events the app observed,
///    and [LearnerState.focusAreas] may only ever say something the counts already
///    say, with the counts attached.
///  * **Bounded, like the tutor's memory.** A ring of the last mistakes, a capped map
///    of characters, one row per skill. Turn 500 costs what turn 5 costs, in storage
///    as well as in the prompt (§6.3).
///  * **No judgement, ever.** Nothing here is a "level", a "score" or a sentence the
///    model wrote. §11.3.5 forbids a calibrated claim, and an app that cannot compute
///    one should not store the pretence of one.
library;

import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/domain/logic/exam_grader.dart';/// The skills the app can actually observe. Not a taxonomy of Chinese — just the
/// things its own items and graders produce evidence about.
enum LearnerSkill {
  tone,
  listening,
  meaning,
  pinyin,
  reading,
  grammar,
  wordOrder,
  writing;

  /// What the model should call it. English because it goes into the prompt and
  /// never onto the screen: the tutor paraphrases it into the learner's language.
  String get label {
    switch (this) {
      case LearnerSkill.tone:
        return 'tone';
      case LearnerSkill.listening:
        return 'listening';
      case LearnerSkill.meaning:
        return 'meaning';
      case LearnerSkill.pinyin:
        return 'pinyin';
      case LearnerSkill.reading:
        return 'reading';
      case LearnerSkill.grammar:
        return 'grammar';
      case LearnerSkill.wordOrder:
        return 'word order';
      case LearnerSkill.writing:
        return 'writing';
    }
  }

  /// The skill an exam item measures. One item kind, one skill: an item that tested
  /// two things would make a tally that means nothing.
  static LearnerSkill? ofItem(ExamItemKind kind) {
    switch (kind) {
      case ExamItemKind.toneChoice:
        return LearnerSkill.tone;
      case ExamItemKind.audioToCharacter:
      case ExamItemKind.dictation:
        // Typed, but driven by hearing the word: what failed there is the listening,
        // not the spelling.
        return LearnerSkill.listening;
      case ExamItemKind.characterToMeaning:
        return LearnerSkill.meaning;
      case ExamItemKind.characterToPinyin:
        return LearnerSkill.pinyin;
      case ExamItemKind.fillBlank:
      case ExamItemKind.passageFill:
        return LearnerSkill.reading;
      case ExamItemKind.grammarError:
        return LearnerSkill.grammar;
      case ExamItemKind.orderTokens:
        return LearnerSkill.wordOrder;
    }
  }
}

/// How often the learner was right, for one skill.
class SkillTally {
  const SkillTally({this.attempts = 0, this.correct = 0});

  final int attempts;
  final int correct;

  /// Null when nothing has been observed: "0%" and "no data" are different
  /// statements, and only one of them is true here.
  double? get accuracy => attempts == 0 ? null : correct / attempts;

  SkillTally plus(bool wasCorrect) => SkillTally(
        attempts: attempts + 1,
        correct: correct + (wasCorrect ? 1 : 0),
      );

  Map<String, Object?> toJson() =>
      <String, Object?>{'a': attempts, 'c': correct};

  static SkillTally fromJson(Map<String, dynamic> json) => SkillTally(
        attempts: (json['a'] as num?)?.toInt() ?? 0,
        correct: (json['c'] as num?)?.toInt() ?? 0,
      );
}/// One wrong answer, small enough to keep fifty of.
///
/// This is what makes "explain the mistake I just made" possible without asking the
/// learner to describe it, and it is the raw material a diagnosis needs. No timings
/// and no prose: neither answers any of the three questions.
class MistakeRecord {
  const MistakeRecord({
    required this.skill,
    required this.hanzi,
    required this.given,
    required this.expected,
    required this.at,
    required this.source,
  });

  final LearnerSkill skill;
  final String hanzi;

  /// What the learner answered, and what the answer was — both short by construction.
  final String given;
  final String expected;

  final DateTime at;

  /// Where it happened: `exam`, `quiz`, `review`.
  final String source;

  /// The one-line form the tutor is shown.
  String get line {
    final String said = given.trim().isEmpty ? 'nothing' : given.trim();
    return '$hanzi · answered $said, expected $expected';
  }

  Map<String, Object?> toJson() => <String, Object?>{
        's': skill.name,
        'h': hanzi,
        'g': given,
        'e': expected,
        't': at.toIso8601String(),
        'src': source,
      };

  static MistakeRecord? fromJson(Map<String, dynamic> json) {
    final DateTime? at =
        json['t'] == null ? null : DateTime.tryParse(json['t'].toString());
    if (at == null) return null;
    LearnerSkill? skill;
    for (final LearnerSkill candidate in LearnerSkill.values) {
      if (candidate.name == json['s']) skill = candidate;
    }
    if (skill == null) return null;
    return MistakeRecord(
      skill: skill,
      hanzi: json['h']?.toString() ?? '',
      given: json['g']?.toString() ?? '',
      expected: json['e']?.toString() ?? '',
      at: at,
      source: json['src']?.toString() ?? '',
    );
  }
}

/// What a character has cost the learner *outside* their own SRS state — which the
/// card already tracks, and which therefore is not repeated here.
class CharacterTally {
  const CharacterTally({this.misses = 0, required this.lastSeen});

  final int misses;
  final DateTime lastSeen;

  CharacterTally missedAt(DateTime at) =>
      CharacterTally(misses: misses + 1, lastSeen: at);

  Map<String, Object?> toJson() =>
      <String, Object?>{'m': misses, 't': lastSeen.toIso8601String()};

  static CharacterTally? fromJson(Map<String, dynamic> json) {
    final DateTime? at =
        json['t'] == null ? null : DateTime.tryParse(json['t'].toString());
    if (at == null) return null;
    return CharacterTally(
      misses: (json['m'] as num?)?.toInt() ?? 0,
      lastSeen: at,
    );
  }
}

/// One thing the learner read, and what it cost them.
class ReadingRecord {
  const ReadingRecord({
    required this.title,
    required this.newWords,
    required this.at,
  });

  final String title;
  final int newWords;
  final DateTime at;

  Map<String, Object?> toJson() => <String, Object?>{
        'title': title,
        'new': newWords,
        't': at.toIso8601String(),
      };

  static ReadingRecord? fromJson(Map<String, dynamic> json) {
    final DateTime? at =
        json['t'] == null ? null : DateTime.tryParse(json['t'].toString());
    if (at == null) return null;
    return ReadingRecord(
      title: json['title']?.toString() ?? '',
      newWords: (json['new'] as num?)?.toInt() ?? 0,
      at: at,
    );
  }
}/// The record itself: counts, the last mistakes, and the few statements the counts
/// are allowed to make.
class LearnerState {
  const LearnerState({
    this.skills = const <LearnerSkill, SkillTally>{},
    this.tones = const <int, SkillTally>{},
    this.characters = const <String, CharacterTally>{},
    this.mistakes = const <MistakeRecord>[],
    this.reading = const <ReadingRecord>[],
    this.lastActiveDay = '',
    this.streak = 0,
    this.sittings = 0,
  });

  static const LearnerState empty = LearnerState();

  /// The caps. Each one exists so the record grows with the app's fixed budget
  /// rather than with the person using it (§6.3).
  static const int maxMistakes = 50;
  static const int maxCharacters = 500;
  static const int maxReading = 20;

  /// A focus area needs real evidence: three attempts before it may call something
  /// weak, and two misses before it may name a character.
  static const int minAttemptsForFocus = 3;
  static const double weakBelow = 0.7;
  static const int minMissesForFocus = 2;

  /// One line may not dominate the prompt, and there may not be many of them.
  static const int maxPromptLine = 60;
  static const int maxPromptLines = 8;

  /// The version of the stored shape. A record from a shape this build does not
  /// understand is not read at all: half-reading a profile is how a learner ends up
  /// being told something that was never true.
  static const int schemaVersion = 1;

  final Map<LearnerSkill, SkillTally> skills;

  /// Tones 1-4 only. A tally of "neutral" would be a tally of the app's own
  /// uncertainty, which is not evidence about the learner.
  final Map<int, SkillTally> tones;

  /// Characters the learner got wrong somewhere *other* than their own SRS practice
  /// — the card already tracks that, and repeating it here would double-count.
  final Map<String, CharacterTally> characters;

  /// Newest last.
  final List<MistakeRecord> mistakes;

  /// Newest last.
  final List<ReadingRecord> reading;

  /// `yyyy-MM-dd` of the last day anything was recorded, and the run of days to it.
  final String lastActiveDay;
  final int streak;

  /// Sittings recorded: the cheapest honest answer to "how much have I done".
  final int sittings;

  /// The tally for a skill, or an empty one — never null, so a caller never has to
  /// decide what "no data" means in the middle of a sum.
  SkillTally tallyOf(LearnerSkill skill) =>
      skills[skill] ?? const SkillTally();

  SkillTally toneTallyOf(int tone) => tones[tone] ?? const SkillTally();

  /// Accuracy for a skill, or null when nothing has been observed: "0%" and "no
  /// data" are different statements, and only one of them is true here.
  double? accuracyOf(LearnerSkill skill) => tallyOf(skill).accuracy;

  /// Adds a mistake to the ring and the character map **without** touching the skill
  /// tallies.
  ///
  /// [recordExam] counts a sitting's skills in bulk first, so a miss that also went
  /// through [record] would be counted twice — which is exactly the sort of quiet
  /// double-count that makes every number after it wrong.
  LearnerState _addMistake({
    required LearnerSkill skill,
    required String hanzi,
    required String given,
    required String expected,
    required String source,
    required DateTime at,
  }) {
    if (hanzi.trim().isEmpty) return this;
    // One character, one entry: an item about 好 is about 好.
    final String single = hanzi.trim().substring(0, 1);
    final Map<String, CharacterTally> nextCharacters =
        Map<String, CharacterTally>.from(characters);
    nextCharacters[single] =
        (nextCharacters[single] ?? CharacterTally(lastSeen: at)).missedAt(at);

    return copyWith(
      characters: _cappedCharacters(nextCharacters),
      mistakes: _cappedMistakes(<MistakeRecord>[
        ...mistakes,
        MistakeRecord(
          skill: skill,
          hanzi: single,
          given: given,
          expected: expected,
          at: at,
          source: source,
        ),
      ]),
    );
  }

  /// Records one observed answer — the single entry point every surface uses.
  ///
  /// A wrong answer additionally lands in the mistake ring and the character map,
  /// because those are what a later "explain my mistake" or a diagnosis needs. A
  /// correct answer updates the tallies and the streak and nothing else: there is no
  /// need to remember what went right.
  LearnerState record({
    required LearnerSkill skill,
    required bool correct,
    String hanzi = '',
    String given = '',
    String expected = '',
    String source = 'app',
    int? tone,
    DateTime? at,
  }) {
    final DateTime when = at ?? DateTime.now();
    final Map<LearnerSkill, SkillTally> nextSkills =
        Map<LearnerSkill, SkillTally>.from(skills);
    nextSkills[skill] = tallyOf(skill).plus(correct);

    final Map<int, SkillTally> nextTones = Map<int, SkillTally>.from(tones);
    if (tone != null && tone >= 1 && tone <= 4) {
      nextTones[tone] = toneTallyOf(tone).plus(correct);
    }

    final Map<String, CharacterTally> nextCharacters =
        Map<String, CharacterTally>.from(characters);
    final List<MistakeRecord> nextMistakes = List<MistakeRecord>.from(mistakes);
    if (!correct && hanzi.trim().isNotEmpty) {
      // One character, one entry: an item about 好 is about 好.
      final String single = hanzi.trim().substring(0, 1);
      nextCharacters[single] =
          (nextCharacters[single] ?? CharacterTally(lastSeen: when))
              .missedAt(when);
      nextMistakes.add(MistakeRecord(
        skill: skill,
        hanzi: single,
        given: given,
        expected: expected,
        at: when,
        source: source,
      ));
    }

    return copyWith(
      skills: nextSkills,
      tones: nextTones,
      characters: _cappedCharacters(nextCharacters),
      mistakes: _cappedMistakes(nextMistakes),
      lastActiveDay: _dayOf(when),
      streak: _nextStreak(when),
    );
  }

  /// Records a whole sitting, from what the paper asked and what the report kept.
  ///
  /// The per-skill split comes from the paper's own items and the report's misses —
  /// `correct = asked - missed` — so nothing is graded twice, and the numbers cannot
  /// drift from the score the learner was shown.
  LearnerState recordExam({
    required ExamPaper paper,
    required ExamReport report,
    Map<int, String> answers = const <int, String>{},
    DateTime? at,
  }) {
    final DateTime when = at ?? DateTime.now();
    final Map<LearnerSkill, int> asked = <LearnerSkill, int>{};
    final Map<LearnerSkill, int> missed = <LearnerSkill, int>{};
    final Map<int, int> askedTones = <int, int>{};
    final Map<int, int> wrongTones = <int, int>{};

    for (final ExamItem item in paper.items) {
      final LearnerSkill? skill = LearnerSkill.ofItem(item.kind);
      if (skill == null) continue;
      asked[skill] = (asked[skill] ?? 0) + 1;
      final int tone = PinyinUtils.toneFromSyllable(item.answer);
      if (item.kind == ExamItemKind.toneChoice && tone >= 1 && tone <= 4) {
        askedTones[tone] = (askedTones[tone] ?? 0) + 1;
      }
    }
    for (final ExamItem item in report.missed) {
      final LearnerSkill? skill = LearnerSkill.ofItem(item.kind);
      if (skill == null) continue;
      missed[skill] = (missed[skill] ?? 0) + 1;
      final int tone = PinyinUtils.toneFromSyllable(item.answer);
      if (item.kind == ExamItemKind.toneChoice && tone >= 1 && tone <= 4) {
        wrongTones[tone] = (wrongTones[tone] ?? 0) + 1;
      }
    }

    LearnerState next = copyWith(
      sittings: sittings + 1,
      lastActiveDay: _dayOf(when),
      streak: _nextStreak(when),
    );
    for (final MapEntry<LearnerSkill, int> entry in asked.entries) {
      next = next._recordSkill(
        skill: entry.key,
        attempts: entry.value,
        correct: entry.value - (missed[entry.key] ?? 0),
      );
    }
    for (final MapEntry<int, int> entry in askedTones.entries) {
      next = next._recordTone(
        tone: entry.key,
        attempts: entry.value,
        correct: entry.value - (wrongTones[entry.key] ?? 0),
      );
    }

    // And the misses one by one, so the ring and the character map see them with
    // the answer the learner actually gave.
    final Set<String> missedKeys = <String>{
      for (final ExamItem item in report.missed)
        '${item.kind.name}:${item.hanzi}:${item.answer}',
    };
    int flat = 0;
    for (final ExamSection section in paper.sections) {
      for (final ExamItem item in section.items) {
        if (missedKeys
            .contains('${item.kind.name}:${item.hanzi}:${item.answer}')) {
          final int index = flat;
          next = next._addMistake(
            skill: LearnerSkill.ofItem(item.kind) ?? LearnerSkill.reading,
            hanzi: item.hanzi,
            given: answers[index] ?? '',
            expected: item.answer,
            source: 'exam',
            at: when,
          );
        }
        flat++;
      }
    }
    return next;
  }  /// Bulk-counts a skill: one sitting moves a tally by its size, and the per-item
  /// detail lives in the mistake ring, where it is actually useful.
  LearnerState _recordSkill({
    required LearnerSkill skill,
    required int attempts,
    required int correct,
  }) {
    if (attempts <= 0) return this;
    final Map<LearnerSkill, SkillTally> next =
        Map<LearnerSkill, SkillTally>.from(skills);
    final SkillTally tally = tallyOf(skill);
    next[skill] = SkillTally(
      attempts: tally.attempts + attempts,
      correct: tally.correct + correct.clamp(0, attempts),
    );
    return copyWith(skills: next);
  }

  LearnerState _recordTone({
    required int tone,
    required int attempts,
    required int correct,
  }) {
    if (attempts <= 0 || tone < 1 || tone > 4) return this;
    final Map<int, SkillTally> next = Map<int, SkillTally>.from(tones);
    final SkillTally tally = toneTallyOf(tone);
    next[tone] = SkillTally(
      attempts: tally.attempts + attempts,
      correct: tally.correct + correct.clamp(0, attempts),
    );
    return copyWith(tones: next);
  }

  /// At most three statements, each carrying the counts that produced it.
  ///
  /// This is the whole "intelligence" of the record: it turns observations into
  /// sentences a learner could disagree with — and the evidence stays attached so
  /// they can. Ranked by how often something went wrong, then by how much evidence
  /// there is.
  List<String> focusAreas({int limit = 3}) {
    final List<({String label, int wrong, int attempts})> candidates =
        <({String label, int wrong, int attempts})>[];

    for (final MapEntry<LearnerSkill, SkillTally> entry in skills.entries) {
      final SkillTally tally = entry.value;
      if (tally.attempts < minAttemptsForFocus) continue;
      if ((tally.accuracy ?? 0) >= weakBelow) continue;
      candidates.add((
        label: '${entry.key.label} · ${tally.attempts - tally.correct} of '
            '${tally.attempts} wrong',
        wrong: tally.attempts - tally.correct,
        attempts: tally.attempts,
      ));
    }
    for (final MapEntry<int, SkillTally> entry in tones.entries) {
      final SkillTally tally = entry.value;
      if (tally.attempts < minAttemptsForFocus) continue;
      if ((tally.accuracy ?? 0) >= weakBelow) continue;
      candidates.add((
        label: 'tone ${entry.key} · ${tally.attempts - tally.correct} of '
            '${tally.attempts} wrong',
        wrong: tally.attempts - tally.correct,
        attempts: tally.attempts,
      ));
    }
    for (final MapEntry<String, CharacterTally> entry in characters.entries) {
      if (entry.value.misses < minMissesForFocus) continue;
      candidates.add((
        label: '${entry.key} · ${entry.value.misses} misses',
        wrong: entry.value.misses,
        attempts: entry.value.misses,
      ));
    }

    candidates.sort((({String label, int wrong, int attempts}) a,
        ({String label, int wrong, int attempts}) b) {
      final int byWrong = b.wrong.compareTo(a.wrong);
      return byWrong != 0 ? byWrong : b.attempts.compareTo(a.attempts);
    });

    return <String>[
      for (final ({String label, int wrong, int attempts}) candidate
          in candidates.take(limit))
        candidate.label,
    ];
  }

  /// The newest mistakes, in the one-line form the tutor is shown.
  List<String> recentMistakeLines({int limit = 3}) {
    final List<MistakeRecord> newest = mistakes.length <= limit
        ? mistakes
        : mistakes.sublist(mistakes.length - limit);
    return <String>[for (final MistakeRecord mistake in newest) mistake.line];
  }

  /// The last thing read, as one line, or null when nothing has been.
  String? lastReadingLine() {
    if (reading.isEmpty) return null;
    final ReadingRecord last = reading.last;
    return '${last.title} · ${last.newWords} new words';
  }

  /// The record as the tutor is shown it: a handful of short lines, hard-capped.
  ///
  /// The cap *is* the design. This is the discipline the prompt's own budget test
  /// enforces (§6.3): the model is told what is most true about the learner right
  /// now, never handed a dump of everything the app knows.
  List<String> forPrompt({int focusLimit = 3, int mistakeLimit = 2}) {
    final List<String> lines = <String>[
      ...focusAreas(limit: focusLimit),
      ...recentMistakeLines(limit: mistakeLimit),
    ];
    final String? read = lastReadingLine();
    if (read != null) lines.add('last read · $read');
    if (sittings > 0) lines.add('papers sat · $sittings');
    return <String>[
      for (final String line in lines.take(maxPromptLines))
        line.length <= maxPromptLine ? line : line.substring(0, maxPromptLine),
    ];
  }  /// Records something read: the entry point the reading surfaces will use.
  LearnerState withReading(ReadingRecord entry) => copyWith(
        reading: _cappedReading(<ReadingRecord>[...reading, entry]),
        lastActiveDay: _dayOf(entry.at),
        streak: _nextStreak(entry.at),
      );

  LearnerState copyWith({
    Map<LearnerSkill, SkillTally>? skills,
    Map<int, SkillTally>? tones,
    Map<String, CharacterTally>? characters,
    List<MistakeRecord>? mistakes,
    List<ReadingRecord>? reading,
    String? lastActiveDay,
    int? streak,
    int? sittings,
  }) =>
      LearnerState(
        skills: skills ?? this.skills,
        tones: tones ?? this.tones,
        characters: characters ?? this.characters,
        mistakes: mistakes ?? this.mistakes,
        reading: reading ?? this.reading,
        lastActiveDay: lastActiveDay ?? this.lastActiveDay,
        streak: streak ?? this.streak,
        sittings: sittings ?? this.sittings,
      );

  static List<MistakeRecord> _cappedMistakes(List<MistakeRecord> all) =>
      all.length <= maxMistakes ? all : all.sublist(all.length - maxMistakes);

  static List<ReadingRecord> _cappedReading(List<ReadingRecord> all) =>
      all.length <= maxReading ? all : all.sublist(all.length - maxReading);

  /// Keeps the most recently seen characters when the map is full, so the cap costs
  /// the oldest evidence rather than the record's ability to answer a question about
  /// the present.
  static Map<String, CharacterTally> _cappedCharacters(
    Map<String, CharacterTally> all,
  ) {
    if (all.length <= maxCharacters) return all;
    final List<MapEntry<String, CharacterTally>> entries = all.entries.toList()
      ..sort((MapEntry<String, CharacterTally> a,
              MapEntry<String, CharacterTally> b) =>
          b.value.lastSeen.compareTo(a.value.lastSeen));
    return <String, CharacterTally>{
      for (final MapEntry<String, CharacterTally> entry
          in entries.take(maxCharacters))
        entry.key: entry.value,
    };
  }

  static String _dayOf(DateTime at) =>
      '${at.year.toString().padLeft(4, '0')}-'
      '${at.month.toString().padLeft(2, '0')}-'
      '${at.day.toString().padLeft(2, '0')}';

  /// A streak counts *days something was recorded*: the same day does not extend it,
  /// the next day does, and a gap starts again at one.
  int _nextStreak(DateTime when) {
    final String today = _dayOf(when);
    if (lastActiveDay == today) return streak == 0 ? 1 : streak;
    final DateTime? previous = DateTime.tryParse(lastActiveDay);
    if (previous == null) return 1;
    final DateTime previousDay =
        DateTime(previous.year, previous.month, previous.day);
    final DateTime thisDay = DateTime(when.year, when.month, when.day);
    return thisDay.difference(previousDay).inDays == 1 ? streak + 1 : 1;
  }  Map<String, Object?> toJson() => <String, Object?>{
        'v': schemaVersion,
        'skills': <String, Object?>{
          for (final MapEntry<LearnerSkill, SkillTally> entry in skills.entries)
            entry.key.name: entry.value.toJson(),
        },
        'tones': <String, Object?>{
          for (final MapEntry<int, SkillTally> entry in tones.entries)
            entry.key.toString(): entry.value.toJson(),
        },
        'chars': <String, Object?>{
          for (final MapEntry<String, CharacterTally> entry
              in characters.entries)
            entry.key: entry.value.toJson(),
        },
        'mistakes': <Object?>[
          for (final MistakeRecord mistake in mistakes) mistake.toJson(),
        ],
        'reading': <Object?>[
          for (final ReadingRecord entry in reading) entry.toJson(),
        ],
        'day': lastActiveDay,
        'streak': streak,
        'sittings': sittings,
      };

  /// Reads a record back, tolerantly: anything malformed is skipped rather than
  /// taking the whole profile with it, because a lost tally is a much smaller
  /// problem than a tutor with no memory at all.
  static LearnerState fromJson(Map<String, dynamic> json) {
    if ((json['v'] as num?)?.toInt() != schemaVersion) {
      return LearnerState.empty;
    }

    final Map<LearnerSkill, SkillTally> skills = <LearnerSkill, SkillTally>{};
    final Object? rawSkills = json['skills'];
    if (rawSkills is Map) {
      for (final MapEntry<Object?, Object?> entry in rawSkills.entries) {
        final Object? value = entry.value;
        if (value is! Map) continue;
        for (final LearnerSkill skill in LearnerSkill.values) {
          if (skill.name == entry.key.toString()) {
            skills[skill] = SkillTally.fromJson(value.cast<String, dynamic>());
          }
        }
      }
    }

    final Map<int, SkillTally> tones = <int, SkillTally>{};
    final Object? rawTones = json['tones'];
    if (rawTones is Map) {
      for (final MapEntry<Object?, Object?> entry in rawTones.entries) {
        final Object? value = entry.value;
        final int? tone = int.tryParse(entry.key.toString());
        if (tone == null || value is! Map) continue;
        tones[tone] = SkillTally.fromJson(value.cast<String, dynamic>());
      }
    }

    final Map<String, CharacterTally> characters = <String, CharacterTally>{};
    final Object? rawChars = json['chars'];
    if (rawChars is Map) {
      for (final MapEntry<Object?, Object?> entry in rawChars.entries) {
        final Object? value = entry.value;
        if (value is! Map) continue;
        final CharacterTally? tally =
            CharacterTally.fromJson(value.cast<String, dynamic>());
        if (tally != null) characters[entry.key.toString()] = tally;
      }
    }

    final List<MistakeRecord> mistakes = <MistakeRecord>[];
    final Object? rawMistakes = json['mistakes'];
    if (rawMistakes is List) {
      for (final Object? entry in rawMistakes) {
        if (entry is! Map) continue;
        final MistakeRecord? mistake =
            MistakeRecord.fromJson(entry.cast<String, dynamic>());
        if (mistake != null) mistakes.add(mistake);
      }
    }

    final List<ReadingRecord> reading = <ReadingRecord>[];
    final Object? rawReading = json['reading'];
    if (rawReading is List) {
      for (final Object? entry in rawReading) {
        if (entry is! Map) continue;
        final ReadingRecord? record =
            ReadingRecord.fromJson(entry.cast<String, dynamic>());
        if (record != null) reading.add(record);
      }
    }

    return LearnerState(
      skills: skills,
      tones: tones,
      characters: characters,
      mistakes: _cappedMistakes(mistakes),
      reading: _cappedReading(reading),
      lastActiveDay: json['day']?.toString() ?? '',
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      sittings: (json['sittings'] as num?)?.toInt() ?? 0,
    );
  }
}