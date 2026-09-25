/// One `## Heading` block of the daily AI briefing.
///
/// [heading] is empty for text that appears before the first heading, which
/// happens when the model drops the `##` markers.
class InsightSection {
  final String heading;
  final List<String> lines;

  const InsightSection({required this.heading, required this.lines});

  bool get hasHeading => heading.trim().isNotEmpty;

  /// True when the block has any non-blank line.
  bool get hasContent => lines.any((line) => line.trim().isNotEmpty);
}

/// A briefing split into its Summary block and the remaining context blocks.
///
/// [summary] is null when the model returned no headings at all, in which case
/// [context] holds the entire response.
class InsightBriefing {
  final InsightSection? summary;
  final List<InsightSection> context;

  const InsightBriefing({required this.summary, required this.context});
}

/// Heading words the briefing model can emit for the mandatory `## Summary`
/// block. Headings are written in the user's target language, so every
/// supported locale is listed here.
const List<String> kSummaryHeadingMarkers = <String>[
  'summary', // en
  'résumé', 'resume', // fr
  'zusammenfassung', // de
  'resumen', // es
  'riepilogo', 'sommario', // it
  'resumo', // pt
  'кратк', // ru
  '要約', // ja
  '요약', // ko
  'tóm tắt', // vi
  'ringkasan', // id
  'सारांश', // hi
  'สรุป', // th
  'ملخص', // ar
];

/// True when [heading] names the briefing's Summary block.
bool isSummaryHeading(String heading) {
  final normalized = heading.toLowerCase();
  for (final marker in kSummaryHeadingMarkers) {
    if (normalized.contains(marker)) return true;
  }
  return false;
}

/// Splits briefing markdown into `## Heading` sections.
///
/// Empty sections are dropped so stray blank lines between headings do not
/// turn into empty cards.
List<InsightSection> parseInsightSections(String text) {
  final sections = <InsightSection>[];
  var heading = '';
  var lines = <String>[];

  void flush() {
    if (heading.isNotEmpty || lines.any((line) => line.trim().isNotEmpty)) {
      sections.add(InsightSection(heading: heading, lines: List.of(lines)));
    }
  }

  for (final raw in text.split('\n')) {
    final trimmed = raw.trim();
    // `##` is accepted with or without the trailing space so a stray marker
    // line cannot leak into the rendered body.
    if (trimmed.startsWith('##')) {
      flush();
      heading = trimmed.substring(2).trim();
      lines = <String>[];
    } else {
      lines.add(raw);
    }
  }
  flush();
  return sections;
}

/// Splits a briefing into the Summary block and everything else.
///
/// `cultural_context_provider` makes `## Summary` the first mandatory section,
/// so the first section is the fallback when no localized heading marker
/// matches (the model renamed or reordered the heading).
InsightBriefing splitInsightBriefing(String text) {
  final sections = parseInsightSections(text);

  final hasHeadings = sections.any((section) => section.hasHeading);
  if (!hasHeadings) {
    return InsightBriefing(summary: null, context: sections);
  }

  final markerIndex = sections.indexWhere(
    (section) => isSummaryHeading(section.heading),
  );
  final summaryIndex = markerIndex >= 0 ? markerIndex : 0;

  return InsightBriefing(
    summary: sections[summaryIndex],
    context: <InsightSection>[
      for (var i = 0; i < sections.length; i++)
        if (i != summaryIndex) sections[i],
    ],
  );
}
