/// The record's home: one JSON blob in a `Box<String>`.
///
/// The same shape the exam store uses — JSON in a box rather than a typed box with a
/// `TypeAdapter` — for the same reasons: the record is readable in a debugger, a
/// schema change is a version field rather than a migration, and unit tests never
/// have to open Hive. Every method tolerates the box being closed, and a read that
/// fails is an *empty* record rather than an exception: a learner with no record and
/// a learner with an unreadable one are the same learner to the rest of the app.
library;

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/domain/logic/exam_grader.dart';
import 'package:hanzi_master/features/learner/domain/entities/learner_state.dart';

class LearnerStateStore {
  static const String boxName = 'learner_state_v1';
  static const String _key = 'state';

  Box<String>? get _box =>
      Hive.isBoxOpen(boxName) ? Hive.box<String>(boxName) : null;

  /// The record as it stands, or an empty one.
  LearnerState read() {
    final Box<String>? box = _box;
    if (box == null) return LearnerState.empty;
    final String? raw = box.get(_key);
    if (raw == null) return LearnerState.empty;
    try {
      final Object? decoded = json.decode(raw);
      if (decoded is! Map) return LearnerState.empty;
      return LearnerState.fromJson(decoded.cast<String, dynamic>());
    } catch (_) {
      return LearnerState.empty;
    }
  }

  /// Writes the record. A no-op when storage is not open, so a unit test can call it.
  Future<void> write(LearnerState state) async {
    final Box<String>? box = _box;
    if (box == null) return;
    await box.put(_key, json.encode(state.toJson()));
  }

  /// Records a sitting: the one write the exam makes.
  Future<LearnerState> recordExam({
    required ExamPaper paper,
    required ExamReport report,
    Map<int, String> answers = const <int, String>{},
  }) async {
    final LearnerState next = read().recordExam(
      paper: paper,
      report: report,
      answers: answers,
    );
    await write(next);
    return next;
  }
}/// The store, as the app reaches it.
final learnerStateStoreProvider =
    Provider<LearnerStateStore>((ref) => LearnerStateStore());

/// The record, kept in memory so a screen can read it *synchronously* while writes
/// happen in the background. A record is a small object; nothing should ever wait on
/// storage to render a reply.
final learnerStateProvider =
    StateNotifierProvider<LearnerStateController, LearnerState>(
        (ref) => LearnerStateController(ref.watch(learnerStateStoreProvider)));

class LearnerStateController extends StateNotifier<LearnerState> {
  LearnerStateController(this._store) : super(_store.read());

  final LearnerStateStore _store;

  /// Records a whole sitting, from what the paper asked and what the report kept.
  Future<void> recordExam({
    required ExamPaper paper,
    required ExamReport report,
    Map<int, String> answers = const <int, String>{},
  }) async {
    state = await _store.recordExam(
      paper: paper,
      report: report,
      answers: answers,
    );
  }

  /// One answer, from a surface that has no sitting to hand — a quiz, a review, a
  /// tone check. The exam uses [recordExam] because it has the whole paper.
  Future<void> record({
    required LearnerSkill skill,
    required bool correct,
    String hanzi = '',
    String given = '',
    String expected = '',
    String source = 'app',
    int? tone,
  }) async {
    final LearnerState next = state.record(
      skill: skill,
      correct: correct,
      hanzi: hanzi,
      given: given,
      expected: expected,
      source: source,
      tone: tone,
    );
    state = next;
    await _store.write(next);
  }
}