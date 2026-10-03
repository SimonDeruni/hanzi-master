/// Grading, done on the device and only on the device.
///
/// Every item type in the blueprint has exactly one defensible answer that the
/// builder derived from the app's own data, so there is nothing for a model to
/// judge (`docs/AI_TUTOR_CONCEPT.md` §5.4.4). An unanswered item is wrong — that
/// is what a paper means — and the report's job is to end in a teaching action,
/// not a number (§5.4.6).
library;

import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';

/// How one section went.
class ExamSectionResult {
  const ExamSectionResult({
    required this.kind,
    required this.correct,
    required this.total,
  });

  final ExamSectionKind kind;
  final int correct;
  final int total;

  bool get isPerfect => total > 0 && correct == total;
}

/// The outcome of one sitting.
class ExamReport {
  const ExamReport({
    required this.correct,
    required this.total,
    required this.passed,
    required this.passMark,
    required this.sections,
    required this.missed,
  });

  final int correct;
  final int total;
  final bool passed;
  final double passMark;
  final List<ExamSectionResult> sections;

  /// Wrong *and* unanswered items, in sitting order — the study list.
  final List<ExamItem> missed;

  int get answered => total - missed.length;

  /// 0.0 - 1.0.
  double get score => total == 0 ? 0 : correct / total;

  int get scorePercent => (score * 100).round();
}

abstract final class ExamGrader {
  /// Grades [answers], keyed by the flat item index of [paper].
  ///
  /// A missing entry is a wrong answer rather than an error: a paper sat with
  /// blanks in it is a paper with blanks in it.
  static ExamReport grade({
    required ExamPaper paper,
    required Map<int, String> answers,
  }) {
    final List<ExamSectionResult> sections = <ExamSectionResult>[];
    final List<ExamItem> missed = <ExamItem>[];
    int correct = 0;
    int index = 0;

    for (final ExamSection section in paper.sections) {
      int sectionCorrect = 0;
      for (final ExamItem item in section.items) {
        final String? given = answers[index];
        if (given != null && _isCorrect(item, given)) {
          correct++;
          sectionCorrect++;
        } else {
          missed.add(item);
        }
        index++;
      }
      sections.add(ExamSectionResult(
        kind: section.kind,
        correct: sectionCorrect,
        total: section.items.length,
      ));
    }

    final int total = paper.totalItems;
    return ExamReport(
      correct: correct,
      total: total,
      passed: total > 0 && correct / total >= paper.passMark,
      passMark: paper.passMark,
      sections: sections,
      missed: missed,
    );
  }

  /// Whether [given] answers [item].
  ///
  /// Everything is a string comparison of the frozen key, except dictation: a
  /// learner may write a tone as a mark or as a number, so both sides are
  /// normalised first. A missing tone is still wrong — that is the whole point of
  /// the item — because normalising only folds the two ways of *writing* a tone.
  static bool _isCorrect(ExamItem item, String given) {
    if (item.kind == ExamItemKind.dictation) {
      return PinyinUtils.normalizePinyin(given) ==
          PinyinUtils.normalizePinyin(item.answer);
    }
    return given == item.answer;
  }
}
