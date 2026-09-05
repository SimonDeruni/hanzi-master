class SpokenHanziRange {
  final int start;
  final int end;

  const SpokenHanziRange(this.start, this.end);

  bool contains(int index) => index >= start && index < end;
}

const _nonSpokenCharacters = {
  '，',
  '。',
  '！',
  '？',
  '、',
  '“',
  '”',
  '‘',
  '’',
  '：',
  '；',
  '《',
  '》',
  '（',
  '）',
  '—',
  '…',
  ' ',
  '\n',
  '\r',
  '\t',
  ',',
  '!',
  '?',
  '.',
  ':',
  ';',
  "'",
  '"',
  '(',
  ')',
  '[',
  ']',
  '{',
  '}',
};

/// Converts the UTF-16 offsets reported by platform TTS engines into the
/// punctuation-free Hanzi indexes used by the audiobook ruby renderer.
SpokenHanziRange? spokenHanziRangeForOffsets(
  String text,
  int start,
  int end,
) {
  if (start < 0 || end <= start || start >= text.length) return null;

  final boundedEnd = end.clamp(start + 1, text.length);
  var sourceOffset = 0;
  var hanziIndex = 0;
  int? first;
  int? last;

  for (final rune in text.runes) {
    final character = String.fromCharCode(rune);
    final characterEnd = sourceOffset + character.length;
    final isNonSpoken = _nonSpokenCharacters.contains(character) ||
        RegExp(r'^\d+$').hasMatch(character);

    if (!isNonSpoken && characterEnd > start && sourceOffset < boundedEnd) {
      first ??= hanziIndex;
      last = hanziIndex + 1;
    }

    if (!isNonSpoken) hanziIndex++;
    sourceOffset = characterEnd;
  }

  return first == null ? null : SpokenHanziRange(first, last!);
}
