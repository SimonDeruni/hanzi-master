/// Where a paper and its attempts live.
///
/// JSON in a `Box<String>` rather than a typed box with a `TypeAdapter`, for the
/// same reason `graded_stories_v2` and `custom_blueprints_v2` are: a paper is
/// written once and read whole, so a migration-free blob is the cheap and safe
/// shape. The boxes are opened in `main.dart`.
///
/// Every method tolerates the box being closed — unit tests never open Hive, and a
/// store that throws where it should miss would break them — which is the same
/// guard the AI transport cache uses.
library;

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hive/hive.dart';

/// One sitting, remembered: the score is only comparable if it was kept.
class ExamAttempt {
  const ExamAttempt({
    required this.paperId,
    required this.satAt,
    required this.correct,
    required this.total,
    required this.passed,
  });

  final String paperId;
  final DateTime satAt;
  final int correct;
  final int total;
  final bool passed;

  int get percent => total == 0 ? 0 : ((correct / total) * 100).round();

  Map<String, Object?> toJson() => <String, Object?>{
        'p': paperId,
        't': satAt.toIso8601String(),
        'c': correct,
        'n': total,
        'ok': passed,
      };

  static ExamAttempt? fromJson(Map<String, dynamic> json) {
    final String paperId = json['p']?.toString() ?? '';
    if (paperId.isEmpty) return null;
    return ExamAttempt(
      paperId: paperId,
      satAt: DateTime.tryParse(json['t']?.toString() ?? '') ?? DateTime.now(),
      correct: (json['c'] as num?)?.toInt() ?? 0,
      total: (json['n'] as num?)?.toInt() ?? 0,
      passed: json['ok'] == true,
    );
  }
}

class ExamStore {
  static const String papersBoxName = 'exams';
  static const String attemptsBoxName = 'exam_attempts';

  Box<String>? get _papers =>
      Hive.isBoxOpen(papersBoxName) ? Hive.box<String>(papersBoxName) : null;

  Box<String>? get _attempts => Hive.isBoxOpen(attemptsBoxName)
      ? Hive.box<String>(attemptsBoxName)
      : null;

  Future<void> savePaper(ExamPaper paper) async {
    await _papers?.put(paper.id, jsonEncode(paper.toJson()));
  }

  Future<ExamPaper?> paper(String id) async {
    final String? raw = _papers?.get(id);
    if (raw == null || raw.isEmpty) return null;
    try {
      return ExamPaper.fromJson(
          (json.decode(raw) as Map).cast<String, dynamic>());
    } catch (_) {
      return null;
    }
  }

  /// Newest first, so a "my tests" list needs no extra index.
  Future<List<ExamPaper>> recentPapers({int limit = 20}) async {
    final Box<String>? box = _papers;
    if (box == null) return const <ExamPaper>[];
    final List<ExamPaper> papers = <ExamPaper>[];
    for (final String raw in box.values) {
      try {
        final ExamPaper? paper = ExamPaper.fromJson(
            (json.decode(raw) as Map).cast<String, dynamic>());
        if (paper != null) papers.add(paper);
      } catch (_) {
        // A corrupt entry loses itself, not the list.
      }
    }
    papers
        .sort((ExamPaper a, ExamPaper b) => b.createdAt.compareTo(a.createdAt));
    return papers.take(limit).toList();
  }

  Future<void> saveAttempt(ExamAttempt attempt) async {
    await _attempts?.add(jsonEncode(attempt.toJson()));
  }

  Future<List<ExamAttempt>> attemptsFor(String paperId) async {
    final Box<String>? box = _attempts;
    if (box == null) return const <ExamAttempt>[];
    final List<ExamAttempt> found = <ExamAttempt>[];
    for (final String raw in box.values) {
      try {
        final ExamAttempt? attempt = ExamAttempt.fromJson(
            (json.decode(raw) as Map).cast<String, dynamic>());
        if (attempt != null && attempt.paperId == paperId) found.add(attempt);
      } catch (_) {
        // Same: one bad record is not a broken history.
      }
    }
    found.sort((ExamAttempt a, ExamAttempt b) => a.satAt.compareTo(b.satAt));
    return found;
  }

  /// The best previous score on [paperId], so a retake can be compared without
  /// claiming a calibrated HSK score (§11.3.5).
  Future<ExamAttempt?> bestAttempt(String paperId) async {
    final List<ExamAttempt> all = await attemptsFor(paperId);
    ExamAttempt? best;
    for (final ExamAttempt attempt in all) {
      if (best == null || attempt.percent > best.percent) best = attempt;
    }
    return best;
  }
}

final examStoreProvider = Provider<ExamStore>((Ref ref) => ExamStore());
