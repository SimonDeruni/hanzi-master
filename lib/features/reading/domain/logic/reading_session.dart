import 'package:equatable/equatable.dart';

class ReadingSessionData extends Equatable {
  final String bookId;
  final int chapterIndex;
  final int sentenceIndex;
  final bool wasAudiobook;
  final DateTime lastActiveTimestamp;

  const ReadingSessionData({
    required this.bookId,
    required this.chapterIndex,
    required this.sentenceIndex,
    required this.wasAudiobook,
    required this.lastActiveTimestamp,
  });

  factory ReadingSessionData.fromJson(Map<String, dynamic> json) {
    return ReadingSessionData(
      bookId: json['bookId'] as String? ?? '',
      chapterIndex: json['chapterIndex'] as int? ?? 1,
      sentenceIndex: json['sentenceIndex'] as int? ?? 0,
      wasAudiobook: json['wasAudiobook'] as bool? ?? false,
      lastActiveTimestamp: json['lastActiveTimestamp'] != null
          ? DateTime.tryParse(json['lastActiveTimestamp'] as String) ??
              DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'chapterIndex': chapterIndex,
        'sentenceIndex': sentenceIndex,
        'wasAudiobook': wasAudiobook,
        'lastActiveTimestamp': lastActiveTimestamp.toIso8601String(),
      };

  Duration get timeSinceLastActive =>
      DateTime.now().difference(lastActiveTimestamp);

  bool get isRecentSession =>
      timeSinceLastActive.inMinutes < 30;

  bool get isActiveSession =>
      timeSinceLastActive.inDays < 30;

  /// Human-readable relative time string
  String get relativeTime {
    final diff = timeSinceLastActive;
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 30) return '${diff.inDays}d ago';
    return '${diff.inDays ~/ 30}mo ago';
  }

  @override
  List<Object?> get props =>
      [bookId, chapterIndex, sentenceIndex, wasAudiobook, lastActiveTimestamp];
}
