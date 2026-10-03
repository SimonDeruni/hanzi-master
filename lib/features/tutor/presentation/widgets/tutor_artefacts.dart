/// The artefact registry: `type` → widget, built from data the app owns.
///
/// This is the SHOW half of the reply (§4.2/§12). Two rules are enforced here
/// rather than trusted:
///
///  * **A builder returns `null` when it cannot build**, and the reply view drops
///    that block. A stroke lesson needs stroke paths; if the learner's library has
///    none for that character, the honest outcome is *no widget* — not a spinner,
///    not an error, and never a made-up drawing.
///  * **Nothing is fetched.** Everything comes from [TutorArtefactData], which the
///    caller assembles from the library and the bundled metadata.
library;

import 'package:flutter/material.dart';
import 'package:hanzi_master/core/character_loader.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/scholar_stroke_lesson.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Everything a builder is allowed to read.
class TutorArtefactData {
  const TutorArtefactData({
    this.cardsByHanzi = const <String, Flashcard>{},
    this.metadata = const <String, dynamic>{},
    this.radicals = const <String, dynamic>{},
    this.hsk1Strokes = const <String, dynamic>{},
  });

  /// The learner's own cards, so a stroke lesson reuses strokes the app has
  /// already loaded for that character.
  final Map<String, Flashcard> cardsByHanzi;

  /// `assets/data/hanzi_metadata.json`: radical + decomposition per character.
  final Map<String, dynamic> metadata;

  /// `assets/data/radicals.json`, localised: name + meaning + mnemonic.
  final Map<String, dynamic> radicals;

  /// `assets/data/hsk1_strokes.json`: real stroke outlines and medians for every
  /// HSK 1 character.
  ///
  /// This is what makes "how do I write 好?" answerable for a learner whose deck
  /// does not happen to contain 好 — the level almost everyone starts at, and the
  /// characters a beginner is most likely to ask about.
  final Map<String, dynamic> hsk1Strokes;

  /// The characters this bundle can actually show something for. It is handed to
  /// the parser as `allowedHanzi`, which is how a reply is stopped from naming a
  /// character the app cannot render at all.
  Set<String> get describableHanzi {
    final Set<String> hanzi = <String>{};
    for (final Flashcard card in cardsByHanzi.values) {
      if (card.strokePaths.isNotEmpty) hanzi.add(card.hanzi);
    }
    hanzi.addAll(metadata.keys);
    hanzi.addAll(hsk1Strokes.keys);
    return hanzi;
  }
}

abstract final class TutorArtefactRegistry {
  /// `null` means "drop this block", which is a normal outcome.
  static Widget? build(
    BuildContext context, {
    required TutorArtefact artefact,
    required TutorArtefactData data,
    required bool isDark,
  }) {
    switch (artefact.type) {
      // The table is about two *sides*, not one character, so it is the one widget
      // that does not go through the character guard.
      case TutorArtefactType.contrastTable:
        return _contrastCard(artefact.args, data, isDark);
      case TutorArtefactType.strokeOrder:
        return _forHanzi(
            artefact, (String hanzi) => _strokeOrder(hanzi, data, isDark));
      case TutorArtefactType.characterAnatomy:
        return _forHanzi(
            artefact, (String hanzi) => _anatomy(hanzi, data, isDark));
      case TutorArtefactType.exampleSet:
        return _forHanzi(
            artefact, (String hanzi) => _exampleSet(hanzi, data, isDark));
    }
  }

  /// Runs a character-shaped builder, or returns `null` when the artefact named no
  /// character to build it for.
  static Widget? _forHanzi(
    TutorArtefact artefact,
    Widget? Function(String hanzi) build,
  ) {
    final String? hanzi = artefact.hanzi;
    if (hanzi == null) return null;
    return build(hanzi);
  }

  static Widget? _strokeOrder(
      String hanzi, TutorArtefactData data, bool isDark) {
    // The learner's own card first: it carries their stroke data *and* whether they
    // have flipped the character, so a lesson drawn from the library looks like the
    // one they practise with.
    final Flashcard? card = data.cardsByHanzi[hanzi];
    if (card != null && card.strokePaths.isNotEmpty) {
      return ScholarStrokeLesson(
        hanzi: hanzi,
        strokePaths: card.strokePaths,
        medianPaths: card.medianPaths,
        isFlipped: card.isFlipped,
        isDark: isDark,
      );
    }
    // Otherwise the bundled HSK 1 outlines, transformed exactly the way the library
    // and the onboarding lesson transform them: one geometry, three callers.
    return _bundledStrokeLesson(hanzi, data, isDark);
  }

  /// A stroke lesson from `hsk1_strokes.json`, or null when the character is not in
  /// it — the bundle covers HSK 1, so the answer to "show me how to write 好" does
  /// not depend on whether 好 happens to be in the learner's own deck.
  static Widget? _bundledStrokeLesson(
    String hanzi,
    TutorArtefactData data,
    bool isDark,
  ) {
    final Object? entry = data.hsk1Strokes[hanzi];
    if (entry is! Map) return null;

    final List<String> paths = <String>[
      for (final Object? stroke
          in (entry['strokes'] as List? ?? const <Object?>[]))
        if (stroke is String && stroke.trim().isNotEmpty) stroke,
    ];
    final List<List<Offset>> medians = <List<Offset>>[
      for (final Object? median
          in (entry['medians'] as List? ?? const <Object?>[]))
        if (median is List)
          CharacterLoader.flipPoints(<Offset>[
            for (final Object? point in median)
              if (point is List && point.length >= 2)
                Offset(
                  (point[0] as num).toDouble(),
                  (point[1] as num).toDouble(),
                ),
          ]).map(CharacterLoader.transformPoint).toList(),
    ];

    // The same guard the card path uses: no outlines, or outlines that do not pair up
    // with medians, is no lesson — a drawing half the size of the character would be
    // worse than none at all.
    if (paths.isEmpty || medians.isEmpty) return null;
    if (paths.length != medians.length) return null;

    return ScholarStrokeLesson(
      hanzi: hanzi,
      strokePaths: paths,
      medianPaths: medians,
      isFlipped: false,
      isDark: isDark,
    );
  }

  /// The app's own examples of a character in use: the sentence the learner's card
  /// was saved with, and the context around it. Nothing here is generated, which is
  /// the point — an example they have already met is a reminder, not a new claim.
  ///
  /// Null when there is neither an example nor a definition: a block that only
  /// repeats the character back is not worth showing.
  static Widget? _exampleSet(
    String hanzi,
    TutorArtefactData data,
    bool isDark,
  ) {
    final Flashcard? card = data.cardsByHanzi[hanzi];
    final List<String> examples = <String>[
      if ((card?.sourceSentence ?? '').trim().isNotEmpty)
        card!.sourceSentence!.trim(),
      if ((card?.sourceContext ?? '').trim().isNotEmpty)
        card!.sourceContext!.trim(),
    ];
    final String definition = _definitionOf(data, hanzi);
    if (examples.isEmpty && definition.isEmpty) return null;

    final String reading = spellingOf(hanzi, data);
    return _ExampleCard(
      hanzi: hanzi,
      reading: reading.isEmpty ? null : reading,
      definition: definition,
      examples: examples,
      spellingOf: (String text) => spellingOf(text, data),
      isDark: isDark,
    );
  }

  /// The grammar comparison: the model's two sides and their examples, *spelled by
  /// the app* (see [spellingOf]) and already checked by the parser against the
  /// characters this build can describe.
  static Widget? _contrastCard(
    Map<String, Object?> args,
    TutorArtefactData data,
    bool isDark,
  ) {
    final String title = args['title']?.toString() ?? '';
    final String left = args['left']?.toString() ?? '';
    final String right = args['right']?.toString() ?? '';
    final Object? rawRows = args['rows'];
    if (title.isEmpty || left.isEmpty || right.isEmpty || rawRows is! List) {
      return null;
    }

    final List<(String, String, String)> rows = <(String, String, String)>[
      for (final Object? entry in rawRows)
        if (entry is Map)
          (
            entry['left']?.toString() ?? '',
            entry['right']?.toString() ?? '',
            entry['note']?.toString() ?? '',
          ),
    ]
        .where(((String, String, String) row) =>
            row.$1.isNotEmpty && row.$2.isNotEmpty)
        .toList();
    if (rows.isEmpty) return null;

    return _ContrastCard(
      title: title,
      left: left,
      right: right,
      rows: rows,
      spellingOf: (String text) => spellingOf(text, data),
      isDark: isDark,
    );
  }

  /// [text] spelled with the app's own readings: one syllable per character, joined
  /// with spaces, nothing invented.
  ///
  /// A character the metadata has no reading for is left out rather than guessed —
  /// an approximation of a pronunciation is worse than an absence of one.
  static String spellingOf(String text, TutorArtefactData data) {
    final List<String> syllables = <String>[];
    for (final String char in text.split('')) {
      if (!_isHan(char)) continue;
      final String? reading = _readingOf(data, char);
      if (reading != null) syllables.add(reading);
    }
    return syllables.join(' ');
  }

  /// The first reading the app's metadata gives [hanzi], or null.
  ///
  /// Defensive on purpose: the catalogue holds readings as a list and has held more
  /// than one shape over time, and a widget that guesses a pronunciation is worse
  /// than one that omits it.
  static String? _readingOf(TutorArtefactData data, String hanzi) {
    final Object? entry = data.metadata[hanzi];
    if (entry is! Map) return null;
    final Object? readings = entry['pinyin'];
    if (readings is! List) return null;
    for (final Object? reading in readings) {
      if (reading is String && reading.trim().isNotEmpty) {
        return reading.trim();
      }
      if (reading is Map) {
        final Object? value = reading['pinyin'] ?? reading['romanization'];
        if (value is String && value.trim().isNotEmpty) return value.trim();
      }
    }
    return null;
  }

  static String _definitionOf(TutorArtefactData data, String hanzi) {
    final Object? entry = data.metadata[hanzi];
    if (entry is! Map) return '';
    return (entry['definition']?.toString() ?? '').trim();
  }

  static bool _isHan(String char) {
    if (char.isEmpty) return false;
    final int rune = char.runes.first;
    return rune >= 0x4E00 && rune <= 0x9FFF;
  }

  static Widget? _anatomy(String hanzi, TutorArtefactData data, bool isDark) {
    final List<TutorComponent> components = componentsOf(hanzi, data);
    if (components.isEmpty) return null;
    return _AnatomyCard(hanzi: hanzi, components: components, isDark: isDark);
  }

  /// The character's radical first, then whatever its decomposition names.
  ///
  /// This is the same metadata-first rule the character sheet uses: the bundled
  /// metadata says *which* radical a character has, and the curated catalogue is
  /// only ever an enrichment (71 entries, against 9574 assigned radicals).
  static List<TutorComponent> componentsOf(
      String hanzi, TutorArtefactData data) {
    final Map<String, dynamic>? meta =
        (data.metadata[hanzi] as Map?)?.cast<String, dynamic>();
    if (meta == null) return const [];

    final List<TutorComponent> found = <TutorComponent>[];
    void add(String char) {
      if (char.isEmpty || char == hanzi) return;
      if (found.any((TutorComponent c) => c.hanzi == char)) return;
      final Map<String, dynamic>? curated =
          (data.radicals[char] as Map?)?.cast<String, dynamic>();
      final Map<String, dynamic>? own =
          (data.metadata[char] as Map?)?.cast<String, dynamic>();
      final String name =
          curated?['name']?.toString() ?? own?['definition']?.toString() ?? '';
      if (name.isEmpty) return;
      found.add(TutorComponent(
        hanzi: char,
        name: name,
        meaning: curated?['meaning']?.toString() ?? '',
        isRadical: char == meta['radical']?.toString(),
      ));
    }

    add(meta['radical']?.toString() ?? '');
    final String decomposition = meta['decomposition']?.toString() ?? '';
    for (final int rune in decomposition.runes) {
      // Skip the IDS markers (⿰⿱⿲…) and the "unknown" placeholder.
      if (rune >= 0x2FF0 && rune <= 0x2FFF) continue;
      final String char = String.fromCharCode(rune);
      if (char == '？' || char == '?') continue;
      add(char);
    }
    return found;
  }
}

class TutorComponent {
  const TutorComponent({
    required this.hanzi,
    required this.name,
    required this.meaning,
    required this.isRadical,
  });

  final String hanzi;
  final String name;
  final String meaning;
  final bool isRadical;
}

/// The anatomy card: the character, then its parts, with the radical marked.
class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard({
    required this.hanzi,
    required this.components,
    required this.isDark,
  });

  final String hanzi;
  final List<TutorComponent> components;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    // The app's canonical accents (cinnabar on paper, amber in the dark theme)
    // rather than a second copy of the hex.
    final Color accent = isDark ? AppTheme.accentDark : AppTheme.accentLight;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                // A glyph tile: a 46x46 square is right for a hanzi, so the text
                // scales down rather than clipping if a face needs more room.
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      hanzi,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        color: accent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  // The count is the one thing here that has to be translated:
                  // "3 building blocks" is a sentence, not a glyph.
                  l10n.tutorComponentCount(components.length),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final TutorComponent component in components)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 26,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        component.hanzi,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: accent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                component.name,
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (component.isRadical) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: accent.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  l10n.radical,
                                  style: TextStyle(
                                    fontSize: 9,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold,
                                    color: accent,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (component.meaning.isNotEmpty)
                          Text(
                            component.meaning,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.65),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// The examples card: a character the learner has met, in the sentences the app
/// already holds for it.
///
/// Deliberately not a generated example. The app's own sentence is what the card was
/// saved with; showing that sentence back *with its reading* is the reminder a
/// vocabulary card is for, and it costs nothing to be certain of.
class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.hanzi,
    required this.reading,
    required this.definition,
    required this.examples,
    required this.spellingOf,
    required this.isDark,
  });

  final String hanzi;
  final String? reading;
  final String definition;
  final List<String> examples;
  final String Function(String) spellingOf;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final Color accent = theme.colorScheme.primary;
    final List<(String, String)> lines = <(String, String)>[
      for (final String example in examples) (example, spellingOf(example)),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                hanzi,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (reading != null)
                      Text(
                        reading!,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (definition.isNotEmpty)
                      Text(
                        definition,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                l10n.tutorInUse,
                style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ],
          ),
          if (lines.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            for (final (String example, String spelling) in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // The sentence as the learner met it, then the app's own reading
                    // of it — never a reading of the model's invention.
                    Text(
                      example,
                      style: theme.textTheme.titleMedium?.copyWith(height: 1.5),
                    ),
                    if (spelling.isNotEmpty)
                      Text(
                        spelling,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            Text(
              l10n.tutorFromYourCards,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// One comparison row, with both sides already spelled by the app.
typedef _ContrastRow = ({
  String left,
  String right,
  String leftSpelling,
  String rightSpelling,
  String note,
});

/// The grammar comparison: two sides of a point, each with checked examples.
///
/// The shape is the app's and the readings are the app's; only the choice of what to
/// compare, and the words of the note, come from the model — which is what makes this
/// an *explanation* rather than a lookup, and the parser's character check is what
/// keeps it honest.
class _ContrastCard extends StatelessWidget {
  const _ContrastCard({
    required this.title,
    required this.left,
    required this.right,
    required this.rows,
    required this.spellingOf,
    required this.isDark,
  });

  final String title;
  final String left;
  final String right;
  final List<(String, String, String)> rows;
  final String Function(String) spellingOf;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color accent = theme.colorScheme.primary;

    final List<_ContrastRow> spelled = <_ContrastRow>[
      for (final (String a, String b, String note) in rows)
        (
          left: a,
          right: b,
          leftSpelling: spellingOf(a),
          rightSpelling: spellingOf(b),
          note: note,
        ),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(child: _side(theme, accent, left)),
              const SizedBox(width: 10),
              Expanded(child: _side(theme, accent, right)),
            ],
          ),
          for (final _ContrastRow row in spelled)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _cell(theme, accent, row.left, row.leftSpelling),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child:
                            _cell(theme, accent, row.right, row.rightSpelling),
                      ),
                    ],
                  ),
                  if (row.note.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        row.note.trim(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _side(ThemeData theme, Color accent, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.labelLarge
            ?.copyWith(color: accent, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _cell(ThemeData theme, Color accent, String text, String spelling) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text, style: theme.textTheme.titleMedium?.copyWith(height: 1.4)),
        if (spelling.isNotEmpty)
          Text(
            spelling,
            style: theme.textTheme.bodySmall?.copyWith(
              color: accent,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
