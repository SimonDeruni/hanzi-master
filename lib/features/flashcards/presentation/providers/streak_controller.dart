import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/progression/data/study_progress_service.dart';

final streakProvider = Provider<int>((ref) {
  return ref.watch(studyProgressProvider).valueOrNull?.currentStreak ?? 0;
});
