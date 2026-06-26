class VideoTranscript {
  final String videoId;
  final List<TranscriptLine> lines;

  VideoTranscript({
    required this.videoId,
    required this.lines,
  });
}

class TranscriptLine {
  final String text; // Should always be Hanzi
  final String? pinyin;
  final Duration start;
  final Duration duration;
  final String? translation;

  TranscriptLine({
    required this.text,
    this.pinyin,
    required this.start,
    required this.duration,
    this.translation,
  });

  Duration get end => start + duration;
}
