import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/core/providers/hanzi_metadata_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/dictionary_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/cross_reference_text.dart';

class DefinitionFormatter extends ConsumerWidget {
  final String rawDefinition;
  final TextStyle? style;
  final TextAlign textAlign;

  const DefinitionFormatter({
    super.key,
    required this.rawDefinition,
    this.style,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (rawDefinition.isEmpty) {
      return const SizedBox.shrink();
    }

    final definitions = _parse(rawDefinition, ref);

    if (definitions.length == 1) {
      return CrossReferenceText(
        definitions.first,
        style: style,
        textAlign: textAlign,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: definitions.map((def) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: style),
              Expanded(child: CrossReferenceText(def, style: style)),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Static helper — returns a clean, human-readable string for list tiles.
  /// Each meaning is on its own line (maxLines + ellipsis in the tile handles overflow).
  static String cleanRaw(String raw, WidgetRef ref) {
    return _parse(raw, ref).join(', ');
  }

  static List<String> _parse(String raw, WidgetRef ref) {
    // Pre-load the character-level metadata map (covers all ~20k hanzi)
    final charDefs = ref.read(hanziCharDefinitionsProvider).valueOrNull ?? {};

    // 1. Convert Traditional|Simplified[pinyin] OR Simplified[pinyin] into
    //    "Simplified (pīnyīn — English meaning)" using a two-tier lookup:
    //    Tier 1: hanzi_metadata.json (individual character definitions)
    //    Tier 2: HSK master dictionary (word-level definitions)
    var cleaned = raw.replaceAllMapped(
      RegExp(r'(?:[\u4e00-\u9fa5]+\|)?([\u4e00-\u9fa5]+)\[(.*?)\]'),
      (match) {
        final hanzi = match.group(1)!;
        final pinyin = PinyinUtils.convertNumericToMarks(match.group(2)!);

        // Tier 1: character-level lookup (always has single characters like 石, 里)
        final charDef = charDefs[hanzi];
        if (charDef != null && charDef.isNotEmpty) {
          final shortMeaning = charDef
              .replaceAll(RegExp(r'\[.*?\]'), '')
              .split(';')
              .first
              .split(',')
              .first
              .trim();
          return '$hanzi ($pinyin — $shortMeaning)';
        }

        // Tier 2: HSK word-level lookup (for compound words)
        final wordEntry =
            ref.read(masterDictionaryProvider.notifier).lookup(hanzi);
        if (wordEntry != null && wordEntry.definition.isNotEmpty) {
          final shortMeaning = wordEntry.definition
              .replaceAll(RegExp(r'\[.*?\]'), '')
              .split(';')
              .first
              .trim();
          return '$hanzi ($pinyin — $shortMeaning)';
        }

        // Fallback: just show character + pinyin
        return '$hanzi ($pinyin)';
      },
    );

    // Remove any leftover floating pinyin brackets like [sha1]
    cleaned = cleaned.replaceAll(RegExp(r'\[.*?\]'), '');

    // 2. Expand common CC-CEDICT abbreviations to plain English
    cleaned = cleaned.replaceAll(RegExp(r'\bsb\b'), 'somebody');
    cleaned = cleaned.replaceAll(RegExp(r'\bsth\b'), 'something');
    cleaned = cleaned.replaceAll(RegExp(r'\babbr\.\b'), 'abbreviation for');
    cleaned = cleaned.replaceAll('CL:', 'Measure word: ');

    // 3. Split by semicolon into individual meanings
    final parts = cleaned.split(';');

    // 4. Trim, remove blanks, capitalise each entry, and polish known patterns
    return parts
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .where((p) => !p.toLowerCase().startsWith('abbreviation for '))
        .map((p) => p[0].toUpperCase() + p.substring(1))
        .map((p) {
      // "Surname Shi" → "Chinese family name (Shi)"
      final surnameMatch =
          RegExp(r'^Surname\s+(\S+)$', caseSensitive: false).firstMatch(p);
      if (surnameMatch != null) {
        return 'Chinese family name (${surnameMatch.group(1)})';
      }
      // "Surname Shi; also used in ..." → keep the suffix too
      final surnamePrefix =
          RegExp(r'^Surname\s+(\S+)(.*)', caseSensitive: false).firstMatch(p);
      if (surnamePrefix != null && surnamePrefix.group(2)!.isNotEmpty) {
        return 'Chinese family name (${surnamePrefix.group(1)})${surnamePrefix.group(2)}';
      }
      return p;
    }).toList();
  }
}
