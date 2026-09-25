import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/domain/logic/insight_sections.dart';

/// Contract for the daily AI briefing shown on CulturalContextScreen.
///
/// `cultural_context_provider` asks the model for `## Summary` first, then a
/// variable set of context sections, all written in the user's target language.
/// These tests pin that contract without needing a live model call.
void main() {
  const englishBriefing = '''
## Summary
- The article covers a rare diplomatic gesture at the airport.
- Talks between the two sides remain unresolved.

## Context
- 习近平 is the Chinese president.

## Key Vocabulary
- **得失** means gain and loss.
''';

  const frenchBriefing = '''
## Résumé
- L'article revient sur une visite diplomatique récente.
- Il analyse la « gestion de l'impasse ».

## Contexte culturel
- 两会 désigne les deux grandes sessions annuelles.
''';

  group('parseInsightSections', () {
    test('splits markdown into headed sections', () {
      final sections = parseInsightSections(englishBriefing);

      expect(sections.length, 3);
      expect(sections[0].heading, 'Summary');
      expect(sections[1].heading, 'Context');
      expect(sections[2].heading, 'Key Vocabulary');
    });

    test('keeps bullet lines intact for the renderer', () {
      final sections = parseInsightSections(englishBriefing);

      expect(
        sections.first.lines.where((line) => line.trim().startsWith('- ')),
        hasLength(2),
        reason: 'bullet prefixes must survive parsing',
      );
    });

    test('ignores leading blank lines before the first heading', () {
      final sections = parseInsightSections('\n\n## Summary\n- Only one.\n');

      expect(sections, hasLength(1));
      expect(sections.single.heading, 'Summary');
    });

    test('drops a bare ## marker instead of leaking it into the body', () {
      final sections =
          parseInsightSections('## Summary\n- Real content.\n##\n');

      expect(sections, hasLength(1));
      expect(
        sections.single.lines.any((line) => line.trim().startsWith('##')),
        isFalse,
      );
    });

    test('returns no sections for whitespace-only input', () {
      expect(parseInsightSections('   \n\n  \t\n'), isEmpty);
    });
  });

  group('isSummaryHeading', () {
    test('matches the Summary heading in every supported locale', () {
      const headings = <String>[
        'Summary', // en
        'Résumé', // fr
        'Zusammenfassung', // de
        'Resumen', // es
        'Riepilogo', // it
        'Resumo', // pt
        'Краткое содержание', // ru
        '要約', // ja
        '요약', // ko
        'Tóm tắt', // vi
        'Ringkasan', // id
        'सारांश', // hi
        'สรุป', // th
        'ملخص', // ar
      ];

      for (final heading in headings) {
        expect(
          isSummaryHeading(heading),
          isTrue,
          reason: 'should recognise the summary heading "$heading"',
        );
      }
    });

    test('does not match non-summary section headings', () {
      const headings = <String>[
        'Contexte culturel',
        'Cultural Context',
        'Historical Background',
        'Key Vocabulary',
        'The Quote',
        'The Setting',
        '历史背景',
      ];

      for (final heading in headings) {
        expect(
          isSummaryHeading(heading),
          isFalse,
          reason: '"$heading" must not be treated as the summary',
        );
      }
    });

    test('is case insensitive', () {
      expect(isSummaryHeading('SUMMARY'), isTrue);
      expect(isSummaryHeading('zUsAmMeNfAsSuNg'), isTrue);
    });
  });

  group('splitInsightBriefing', () {
    test('separates the English summary from the context sections', () {
      final briefing = splitInsightBriefing(englishBriefing);

      expect(briefing.summary, isNotNull);
      expect(briefing.summary!.heading, 'Summary');
      expect(
        briefing.summary!.lines.join(' '),
        contains('rare diplomatic gesture'),
      );
      expect(briefing.context, hasLength(2));
      expect(briefing.context[0].heading, 'Context');
      expect(briefing.context[1].heading, 'Key Vocabulary');
    });

    test('separates the French summary from the context sections', () {
      final briefing = splitInsightBriefing(frenchBriefing);

      expect(briefing.summary, isNotNull);
      expect(briefing.summary!.heading, 'Résumé');
      expect(briefing.context, hasLength(1));
      expect(briefing.context.single.heading, 'Contexte culturel');
    });

    test('finds the summary when it is not the first section', () {
      const raw =
          '## Contexte\n- Background first.\n\n## Summary\n- The gist.\n';
      final briefing = splitInsightBriefing(raw);

      expect(briefing.summary!.heading, 'Summary');
      expect(briefing.context.single.heading, 'Contexte');
    });

    test('falls back to the first section when no marker matches', () {
      const raw =
          '## Vue d ensemble\n- Something happened.\n\n## Contexte\n- Background.\n';
      final briefing = splitInsightBriefing(raw);

      expect(briefing.summary, isNotNull);
      expect(briefing.summary!.heading, 'Vue d ensemble');
      expect(briefing.context.single.heading, 'Contexte');
    });

    test('keeps heading-less prose whole so it still renders', () {
      const raw = 'The solar terms timed sowing and harvest for two thousand '
          'years.\n\nFamilies still eat by them today.';
      final briefing = splitInsightBriefing(raw);

      expect(
        briefing.summary,
        isNull,
        reason: 'no headings means there is no summary block to split out',
      );
      expect(briefing.context, hasLength(1));
      expect(briefing.context.single.hasHeading, isFalse);
      expect(briefing.context.single.hasContent, isTrue);
    });

    test('never loses content when splitting', () {
      final briefing = splitInsightBriefing(englishBriefing);
      final combined = <String>[
        if (briefing.summary != null) ...briefing.summary!.lines,
        for (final section in briefing.context) ...section.lines,
      ].where((line) => line.trim().isNotEmpty).toList();

      // Derived from the source so the assertion cannot drift out of date:
      // every non-blank, non-heading line must land in exactly one section,
      // in order, with nothing dropped or duplicated.
      final expected = englishBriefing
          .split('\n')
          .where(
            (line) => line.trim().isNotEmpty && !line.trim().startsWith('##'),
          )
          .toList();

      expect(combined, expected);
      expect(combined, isNotEmpty);
    });

    test('handles empty input without throwing', () {
      final briefing = splitInsightBriefing('');

      expect(briefing.summary, isNull);
      expect(briefing.context, isEmpty);
    });
  });
}
