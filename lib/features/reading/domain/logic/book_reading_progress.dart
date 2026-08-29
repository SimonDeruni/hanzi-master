double calculateBookReadingProgress({
  required List<int> sentenceCounts,
  required int chapterIndex,
  required int sentenceIndex,
}) {
  final totalSentences =
      sentenceCounts.fold<int>(0, (sum, count) => sum + count);
  if (totalSentences == 0) return 0.0;

  final safeChapterIndex = chapterIndex.clamp(0, sentenceCounts.length - 1);
  final currentChapterCount = sentenceCounts[safeChapterIndex];
  final completedEarlierSentences = sentenceCounts
      .take(safeChapterIndex)
      .fold<int>(0, (sum, count) => sum + count);

  if (currentChapterCount == 0) {
    return (completedEarlierSentences / totalSentences).clamp(0.0, 1.0);
  }

  final safeSentenceIndex = sentenceIndex.clamp(0, currentChapterCount - 1);
  final reachedSentences = completedEarlierSentences + safeSentenceIndex + 1;
  return (reachedSentences / totalSentences).clamp(0.0, 1.0);
}
