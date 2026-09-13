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

/// Represents the exact start and end millisecond window for a spoken Hanzi character.
class SpokenCharTiming {
  final int hanziIndex;
  final int textOffset;
  final String char;
  final double startMs;
  final double endMs;

  const SpokenCharTiming({
    required this.hanziIndex,
    required this.textOffset,
    required this.char,
    required this.startMs,
    required this.endMs,
  });

  bool contains(double positionMs) =>
      positionMs >= startMs && positionMs < endMs;

  @override
  String toString() =>
      '$char[hanzi=$hanziIndex]: ${startMs.toStringAsFixed(1)}-${endMs.toStringAsFixed(1)}ms';
}

/// Strips leading and trailing non-spoken punctuation and whitespace from boundary words.
String cleanBoundaryWord(String word) {
  if (word.isEmpty) return word;
  final runes = word.runes.toList();
  var start = 0;
  while (start < runes.length) {
    final c = String.fromCharCode(runes[start]);
    if (_nonSpokenCharacters.contains(c) || c.trim().isEmpty) {
      start++;
    } else {
      break;
    }
  }
  var end = runes.length;
  while (end > start) {
    final c = String.fromCharCode(runes[end - 1]);
    if (_nonSpokenCharacters.contains(c) || c.trim().isEmpty) {
      end--;
    } else {
      break;
    }
  }
  if (start >= end) return '';
  return String.fromCharCodes(runes.sublist(start, end));
}

/// Constructs a list of [SpokenCharTiming] by aligning Azure Speech boundary events
/// with the characters in [text]. Handles multi-character compound words, attached quotes,
/// repeated words, and punctuation gaps with monotonic bounded lookahead.
List<SpokenCharTiming> buildSpokenCharTimings({
  required String text,
  required List<Map<String, dynamic>> boundaries,
}) {
  if (text.isEmpty || boundaries.isEmpty) return const [];

  // Map textOffset -> hanziIndex and character for all spoken Hanzi in text
  final hanziIndexByOffset = <int, int>{};
  final hanziCharByOffset = <int, String>{};
  int hanziCounter = 0;
  int offset = 0;
  for (final rune in text.runes) {
    final c = String.fromCharCode(rune);
    final isNonSpoken =
        _nonSpokenCharacters.contains(c) || RegExp(r'^\d+$').hasMatch(c);
    if (!isNonSpoken) {
      hanziIndexByOffset[offset] = hanziCounter;
      hanziCharByOffset[offset] = c;
      hanziCounter++;
    }
    offset += c.length;
  }

  final timings = <SpokenCharTiming>[];
  int searchPos = 0;

  for (final b in boundaries) {
    final rawWord = (b['Word'] ?? b['text']?['Text'] ?? '').toString();
    final boundaryType = (b['BoundaryType'] ??
            b['text']?['BoundaryType'] ??
            b['Type'] ??
            '')
        .toString();
    if (rawWord.isEmpty) continue;

    // Azure emits SentenceBoundary containing the whole sentence; ignore
    if (boundaryType == 'SentenceBoundary') continue;

    // Punctuation boundaries represent pauses; do not map as spoken Hanzi characters
    if (boundaryType == 'PunctuationBoundary') continue;

    final word = cleanBoundaryWord(rawWord);
    if (word.isEmpty) continue;

    final offsetTicks = b['Offset'];
    final durTicks = b['Duration'];
    final double offsetMs = (b['OffsetMs'] as num?)?.toDouble() ??
        ((offsetTicks is int
                ? offsetTicks
                : int.tryParse(offsetTicks.toString()) ?? 0) /
            10000.0);
    final double durMs = (b['DurationMs'] as num?)?.toDouble() ??
        ((durTicks is int
                ? durTicks
                : int.tryParse(durTicks.toString()) ?? 0) /
            10000.0);

    // Advance searchPos past any non-spoken punctuation or whitespace in text
    while (searchPos < text.length) {
      final c = text[searchPos];
      if (_nonSpokenCharacters.contains(c) || c.trim().isEmpty) {
        searchPos++;
      } else {
        break;
      }
    }

    int foundAt = -1;
    if (text.startsWith(word, searchPos)) {
      foundAt = searchPos;
    } else {
      // Bounded local search: inspect at most 6 characters ahead.
      // This strictly prevents jumping across sentences when words repeat (e.g. '在', '他', '的', '了').
      final maxLookahead = (searchPos + 6).clamp(searchPos, text.length);
      final localSub = text.substring(searchPos, maxLookahead);
      final localIdx = localSub.indexOf(word);
      if (localIdx != -1) {
        foundAt = searchPos + localIdx;
      }
    }

    // Word does not match locally (e.g. speech quirk or pronunciation gap)
    // DO NOT search the whole sentence! Leave searchPos in place so subsequent words can match.
    if (foundAt == -1) continue;

    searchPos = foundAt + word.length;

    // Extract spoken Hanzi within this word boundary
    final wordHanziOffsets = <int>[];
    int wOffset = foundAt;
    for (final rune in word.runes) {
      final c = String.fromCharCode(rune);
      if (hanziIndexByOffset.containsKey(wOffset)) {
        wordHanziOffsets.add(wOffset);
      }
      wOffset += c.length;
    }

    if (wordHanziOffsets.isEmpty) continue;

    final charDuration = durMs / wordHanziOffsets.length;
    for (var i = 0; i < wordHanziOffsets.length; i++) {
      final charOffset = wordHanziOffsets[i];
      final charStr = hanziCharByOffset[charOffset] ??
          text.substring(charOffset, charOffset + 1);
      final hanziIdx = hanziIndexByOffset[charOffset]!;
      final cStart = offsetMs + (i * charDuration);
      final cEnd = offsetMs + ((i + 1) * charDuration);
      timings.add(SpokenCharTiming(
        hanziIndex: hanziIdx,
        textOffset: charOffset,
        char: charStr,
        startMs: cStart,
        endMs: cEnd,
      ));
    }
  }

  return timings;
}

/// Finds the active [SpokenCharTiming] for a given [positionMs].
/// If the playback position is in a punctuation pause or between words,
/// the previous spoken character remains active until the next word commences.
SpokenCharTiming? findActiveTiming(
  List<SpokenCharTiming> timings,
  double positionMs,
) {
  if (timings.isEmpty) return null;
  if (positionMs <= timings.first.startMs) return timings.first;
  if (positionMs >= timings.last.endMs) return timings.last;

  for (var i = 0; i < timings.length; i++) {
    final t = timings[i];
    if (positionMs >= t.startMs && positionMs < t.endMs) {
      return t;
    }
    // If in pause before next word, hold on current word
    if (i + 1 < timings.length &&
        positionMs >= t.endMs &&
        positionMs < timings[i + 1].startMs) {
      return t;
    }
  }
  return timings.last;
}
