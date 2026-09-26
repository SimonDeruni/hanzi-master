/// Narrows a block of text down to a line that is actually worth shadowing.
///
/// The context handed to the shadowing studio can be a whole paragraph - the
/// browser in particular sometimes yields a run with no sentence break in it,
/// and then the practice line is unreadable. This keeps the clause that holds
/// [anchor] (the tapped word) and, if that is still long, a window around the
/// word inside it, so the studio always gets something a person can repeat.
library;

/// Chinese and Latin sentence/clause punctuation, in the order we split on.
const String _clauseBreaks = '。！？；!?;，、：,:';

/// Returns the line to shadow from [text], built around [anchor].
String shadowingLine(
  String text,
  String anchor, {
  int maxCharacters = 42,
}) {
  final String trimmed = text.trim();
  if (trimmed.isEmpty) return trimmed;
  if (trimmed.length <= maxCharacters) return trimmed;

  final String needle = anchor.trim();
  final List<String> clauses = <String>[];
  final StringBuffer buffer = StringBuffer();
  for (final int rune in trimmed.runes) {
    final String character = String.fromCharCode(rune);
    buffer.write(character);
    if (_clauseBreaks.contains(character)) {
      clauses.add(buffer.toString().trim());
      buffer.clear();
    }
  }
  if (buffer.isNotEmpty) clauses.add(buffer.toString().trim());

  String chosen = '';
  if (needle.isNotEmpty) {
    for (final String clause in clauses) {
      if (clause.contains(needle)) {
        chosen = clause;
        break;
      }
    }
  }
  if (chosen.isEmpty) chosen = clauses.firstWhere((c) => c.isNotEmpty, orElse: () => trimmed);
  if (chosen.length <= maxCharacters) return chosen;

  // Still too long: a window around the word, so it stays the focus.
  final int anchorIndex = needle.isEmpty ? 0 : chosen.indexOf(needle);
  final int start = anchorIndex < 0
      ? 0
      : (anchorIndex - maxCharacters ~/ 3)
          .clamp(0, chosen.length - maxCharacters)
          .toInt();
  return chosen.substring(start, start + maxCharacters).trim();
}
