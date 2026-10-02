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
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/scholar_stroke_lesson.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';

/// Everything a builder is allowed to read.
class TutorArtefactData {
  const TutorArtefactData({
    this.cardsByHanzi = const <String, Flashcard>{},
    this.metadata = const <String, dynamic>{},
    this.radicals = const <String, dynamic>{},
  });

  /// The learner's own cards, so a stroke lesson reuses strokes the app has
  /// already loaded for that character.
  final Map<String, Flashcard> cardsByHanzi;

  /// `assets/data/hanzi_metadata.json`: radical + decomposition per character.
  final Map<String, dynamic> metadata;

  /// `assets/data/radicals.json`, localised: name + meaning + mnemonic.
  final Map<String, dynamic> radicals;

  /// The characters this bundle can actually show something for. It is handed to
  /// the parser as `allowedHanzi`, which is how a reply is stopped from naming a
  /// character the app cannot render at all.
  Set<String> get describableHanzi {
    final Set<String> hanzi = <String>{};
    for (final Flashcard card in cardsByHanzi.values) {
      if (card.strokePaths.isNotEmpty) hanzi.add(card.hanzi);
    }
    hanzi.addAll(metadata.keys);
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
    final String? hanzi = artefact.hanzi;
    if (hanzi == null) return null;

    switch (artefact.type) {
      case TutorArtefactType.strokeOrder:
        return _strokeOrder(hanzi, data, isDark);
      case TutorArtefactType.characterAnatomy:
        return _anatomy(hanzi, data, isDark);
    }
  }

  static Widget? _strokeOrder(String hanzi, TutorArtefactData data, bool isDark) {
    final Flashcard? card = data.cardsByHanzi[hanzi];
    // The data guard: without real stroke paths there is no stroke lesson.
    if (card == null || card.strokePaths.isEmpty) return null;
    return ScholarStrokeLesson(
      hanzi: hanzi,
      strokePaths: card.strokePaths,
      medianPaths: card.medianPaths,
      isFlipped: card.isFlipped,
      isDark: isDark,
    );
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
  static List<TutorComponent> componentsOf(String hanzi, TutorArtefactData data) {
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
      final String name = curated?['name']?.toString() ??
          own?['definition']?.toString() ??
          '';
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
    final Color accent =
        isDark ? const Color(0xFFFFB300) : const Color(0xFF8B0000);

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
                child: Center(
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
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${components.length} building block'
                  '${components.length == 1 ? '' : 's'}',
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
                    child: Text(
                      component.hanzi,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: accent,
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
                                  'RADICAL',
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
