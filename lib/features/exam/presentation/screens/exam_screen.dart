/// Sitting a paper: intro → timed sections → report.
///
/// What makes this an exam rather than a quiz (`docs/AI_TUTOR_CONCEPT.md` §5):
///
///  * **A clock.** Each section gets the blueprint's minutes, the timer is
///    app-side, and a backgrounded paper is **paused** rather than silently lost
///    (§5.4.3).
///  * **No answers before submission.** The item view gives no feedback, and the
///    key stays in [ExamPaper] until [ExamGrader] reads it at the end (§5.4.2).
///  * **A report that ends in a teaching action.** The missed items are listed and
///    one tap turns them into a deck to study, because an exam that does not change
///    what you study next is entertainment (§5.4.6).
///  * **No false claims.** It says what it is: a practise paper in HSK scope, not
///    an official HSK test and not an HSK score (§5.4.7).
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/exam/data/exam_builder.dart';
import 'package:hanzi_master/features/learner/data/learner_state_store.dart';
import 'package:hanzi_master/features/exam/data/exam_store.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_word.dart';
import 'package:hanzi_master/features/exam/domain/logic/exam_grader.dart';
import 'package:hanzi_master/features/exam/presentation/widgets/exam_item_view.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/writing_bench_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:uuid/uuid.dart';

enum ExamPhase { intro, sitting, report }

class ExamScreen extends ConsumerStatefulWidget {
  const ExamScreen({super.key, required this.paper});

  final ExamPaper paper;

  @override
  ConsumerState<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends ConsumerState<ExamScreen>
    with WidgetsBindingObserver {
  ExamPhase _phase = ExamPhase.intro;

  int _sectionIndex = 0;
  int _itemIndex = 0;

  /// The item's index across the whole paper, which is how an answer is keyed.
  int _flatIndex = 0;

  final Map<int, String> _answers = <int, String>{};
  String? _selected;

  Timer? _timer;
  int _secondsLeft = 0;

  ExamReport? _report;

  /// The best earlier sitting on this paper, so a retake has a comparison.
  ExamAttempt? _previousBest;

  /// So the missed-items deck is offered once, not on every rebuild.
  bool _savedMissed = false;

  /// The papers the learner has sat before, newest first, each with its best
  /// attempt — the "my tests" list the exam store has been able to answer since the
  /// first paper was ever saved.
  List<(ExamPaper, ExamAttempt?)> _history =
      const <(ExamPaper, ExamAttempt?)>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPreviousBest();
    _loadHistory();
  }

  /// Reads the store once, on arrival: a paper list is not something that changes
  /// while a sitting is on screen.
  Future<void> _loadHistory() async {
    final ExamStore store = ref.read(examStoreProvider);
    final List<ExamPaper> papers = await store.recentPapers();
    final List<(ExamPaper, ExamAttempt?)> history =
        <(ExamPaper, ExamAttempt?)>[];
    for (final ExamPaper paper in papers) {
      // The paper on screen is not "history": it is what the learner is about to sit.
      if (paper.id == widget.paper.id) continue;
      history.add((paper, await store.bestAttempt(paper.id)));
    }
    if (!mounted) return;
    setState(() => _history = history);
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// §5.4.3: a paper that is left is *paused* — not lost, and not still counting
  /// down while the learner answers a message.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_phase != ExamPhase.sitting) return;
    if (state == AppLifecycleState.resumed) {
      _startClock();
    } else {
      _timer?.cancel();
    }
  }

  ExamSection get _section => widget.paper.sections[_sectionIndex];

  void _startClock() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) return;
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) {
        timer.cancel();
        ZenToast.info(context, AppLocalizations.of(context)!.examTimeUp);
        _advanceSection();
      }
    });
  }

  void _begin() {
    HapticsManager.light();
    setState(() {
      _phase = ExamPhase.sitting;
      _sectionIndex = 0;
      _itemIndex = 0;
      _flatIndex = 0;
      _answers.clear();
      _selected = null;
      _report = null;
      _savedMissed = false;
      _secondsLeft = widget.paper.sections.first.minutes * 60;
    });
    _startClock();
  }

  void _select(String option) {
    setState(() {
      _answers[_flatIndex] = option;
      _selected = option;
    });
  }

  void _next() {
    if (_selected == null || _selected!.isEmpty) {
      // A paper can be sat with blanks in it, but not by accident.
      ZenToast.info(context, AppLocalizations.of(context)!.examChooseAnAnswer);
      return;
    }
    HapticsManager.selection();
    if (_itemIndex < _section.items.length - 1) {
      setState(() {
        _itemIndex++;
        _flatIndex++;
        _selected = _answers[_flatIndex];
      });
      return;
    }
    _advanceSection();
  }

  void _advanceSection() {
    _timer?.cancel();
    if (_sectionIndex >= widget.paper.sections.length - 1) {
      _finish();
      return;
    }
    setState(() {
      _sectionIndex++;
      _itemIndex = 0;
      _flatIndex++;
      _selected = _answers[_flatIndex];
      _secondsLeft = _section.minutes * 60;
    });
    _startClock();
  }

  Future<void> _finish() async {
    final ExamReport report = ExamGrader.grade(
      paper: widget.paper,
      answers: _answers,
    );
    setState(() {
      _phase = ExamPhase.report;
      _report = report;
    });
    // §6.2: a sitting also feeds the learner's own record — what was asked, what was
    // missed, and the answer given where there was one. Not awaited: the report is on
    // screen already, and nothing about the learner should wait on storage.
    unawaited(ref.read(learnerStateProvider.notifier).recordExam(
          paper: widget.paper,
          report: report,
          answers: _answers,
        ));
    await ref.read(examStoreProvider).saveAttempt(ExamAttempt(
          paperId: widget.paper.id,
          satAt: DateTime.now(),
          correct: report.correct,
          total: report.total,
          passed: report.passed,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
      body: SafeArea(
        child: CalligraphyBackground(
          child: switch (_phase) {
            ExamPhase.intro => _intro(theme),
            ExamPhase.sitting => _sitting(theme),
            ExamPhase.report => _reportView(theme),
          },
        ),
      ),
    );
  }

  // ── Intro ────────────────────────────────────────────────────────────────
  Widget _intro(ThemeData theme) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ExamPaper paper = widget.paper;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            // A deck paper is named and framed by the deck, because "HSK 3 scope"
            // would be a claim about scoping the deck never made.
            paper.isFromDeck
                ? l10n.examTitleDeck(paper.deckName ?? l10n.deck)
                : l10n.examTitle(paper.level),
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // The honesty rule, on the first screen rather than in a footnote.
          Text(
            paper.isFromDeck
                ? l10n.examFromDeck(paper.deckName ?? l10n.deck)
                : l10n.examNotOfficial(paper.level),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < paper.sections.length; i++)
            _sectionRow(theme, paper.sections[i], i + 1),
          const SizedBox(height: 4),
          Text(
            l10n.examPassMark((paper.passMark * 100).round()),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          if (paper.dropped > 0) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              // A thinner paper is stated, not hidden (§11.3.3).
              l10n.examDropped(paper.dropped),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.error),
            ),
          ],
          const SizedBox(height: 24),
          BouncingButton(
            onPressed: _begin,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  l10n.examStart,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          if (_history.isNotEmpty) ...<Widget>[
            const SizedBox(height: 26),
            Text(
              l10n.examHistory,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (final (ExamPaper paper, ExamAttempt? best) in _history)
              _historyRow(theme, l10n, paper, best),
          ],
        ],
      ),
    );
  }

  /// One paper from earlier: what it was, how it went, and a way back in.
  ///
  /// The exam store has held these since the first paper was ever saved, so "my
  /// tests" is a surface rather than a feature — and sitting an old paper again
  /// builds a fresh sitting from the same frozen key, not a re-run of the questions
  /// the learner has already seen the answers to.
  Widget _historyRow(
    ThemeData theme,
    AppLocalizations l10n,
    ExamPaper paper,
    ExamAttempt? best,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: BouncingButton(
        onPressed: () => Navigator.of(context).push(
          SwipeBackPageRoute(
            builder: (BuildContext context) => ExamScreen(paper: paper),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                paper.deckName ?? l10n.examTitle(paper.level),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(width: 10),
            if (best != null)
              Text(
                // The sentence a retake already uses for its comparison, so "best"
                // means one thing in this app rather than two.
                l10n.examPreviousScore(best.correct, best.total),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _sectionRow(ThemeData theme, ExamSection section, int number) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '$number. ${_sectionName(l10n, section.kind)}',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${l10n.deckItemsCount(section.items.length)} · '
            '${section.minutes} min',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  String _sectionName(AppLocalizations l10n, ExamSectionKind kind) {
    switch (kind) {
      case ExamSectionKind.listening:
        return l10n.examSectionListening;
      case ExamSectionKind.reading:
        // The app's own word for this section (`reading`), not a second one.
        return l10n.reading;
      case ExamSectionKind.writing:
        return l10n.examSectionWriting;
    }
  }

  // ── The sitting ──────────────────────────────────────────────────────────
  Widget _sitting(ThemeData theme) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ExamSection section = _section;
    final ExamItem item = section.items[_itemIndex];
    final bool isLastItem = _sectionIndex == widget.paper.sections.length - 1 &&
        _itemIndex == section.items.length - 1;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _sectionName(l10n, section.kind),
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              // mm:ss is not language: no key, and no translation that can drift.
              Text(
                _clock,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _secondsLeft <= 30
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
          child: Text(
            l10n.examQuestionProgress(_itemIndex + 1, section.items.length),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExamItemView(
              // Keyed per item, so the next listening question plays instead of
              // inheriting the previous one's state.
              key: ValueKey<int>(_flatIndex),
              item: item,
              selected: _selected,
              onSelected: _select,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: BouncingButton(
            onPressed: _next,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  isLastItem ? l10n.done : l10n.next,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String get _clock {
    final int seconds = _secondsLeft < 0 ? 0 : _secondsLeft;
    final String mm = (seconds ~/ 60).toString().padLeft(2, '0');
    final String ss = (seconds % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  // ── The report ───────────────────────────────────────────────────────────
  Widget _reportView(ThemeData theme) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ExamReport? report = _report;
    if (report == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            l10n.results,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  l10n.score(report.correct, report.total),
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                report.passed ? l10n.examPassed : l10n.examNotPassed,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: report.passed
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                ),
              ),
            ],
          ),
          if (_previousBest != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              // A retake is comparable because the key was frozen, not because
              // the app claims a calibrated HSK score (§11.3.5).
              l10n.examPreviousScore(
                  _previousBest!.correct, _previousBest!.total),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
          const SizedBox(height: 18),
          for (final ExamSectionResult result in report.sections)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _sectionName(l10n, result.kind),
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('${result.correct}/${result.total}',
                      style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          if (widget.paper.dropped > 0) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              l10n.examDropped(widget.paper.dropped),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.error),
            ),
          ],
          const SizedBox(height: 22),
          if (report.missed.isNotEmpty) ...<Widget>[
            Text(
              l10n.review,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (final ExamItem item in report.missed) _missedRow(theme, item),
            const SizedBox(height: 16),
            // §5.4.6: the report ends in a teaching action, not a number.
            BouncingButton(
              onPressed: _savedMissed ? null : _studyMissed,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    l10n.examStudyMissed(report.missed.length),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ] else
            Text(
              l10n.examAllCorrect,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              // §5.4.6's other half: the *same* words, asked about again, built by
              // the same builder — so a retake is a real short paper rather than a
              // second look at the questions just answered.
              if (report.missed.length >= ExamBlueprint.minimumVocabulary)
                BouncingButton(
                  onPressed: () => _practiseMissed(report),
                  child: Text(
                    l10n.examPracticeMissed(report.missed.length),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              // And what the same sitting can teach the hand: the characters that
              // were missed, on the app's existing writing bench. Offered only for
              // characters the learner's own cards have stroke data for.
              if (_writableMissed().isNotEmpty)
                BouncingButton(
                  onPressed: _practiseWriting,
                  child: Text(
                    l10n.examPracticeWriting(_writableMissed().length),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              BouncingButton(
                onPressed: _begin,
                child: Text(
                  l10n.retry,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BouncingButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text(
                  l10n.done,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _missedRow(ThemeData theme, ExamItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 44,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(item.hanzi, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.pinyin ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                Text(item.definition ?? '', style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// The characters this sitting missed that the app can actually guide: only those
  /// the learner's own cards carry stroke data for, because a writing bench with no
  /// guide stroke is not a writing exercise.
  List<Flashcard> _writableMissed() {
    final List<Flashcard> library =
        ref.read(flashcardControllerProvider).valueOrNull ??
            const <Flashcard>[];
    final Map<String, Flashcard> byHanzi = <String, Flashcard>{
      for (final Flashcard card in library)
        if (card.strokePaths.isNotEmpty) card.hanzi: card,
    };

    final List<Flashcard> found = <Flashcard>[];
    for (final ExamItem item in _report?.missed ?? const <ExamItem>[]) {
      final Flashcard? known = byHanzi[item.hanzi];
      if (known != null &&
          !found.any((Flashcard card) => card.hanzi == known.hanzi)) {
        found.add(known);
      }
    }
    return found;
  }

  /// Practises the missed characters on the writing bench — the same screen a deck
  /// opens for writing practice, so handwriting has one home in this app rather
  /// than two.
  void _practiseWriting() {
    final List<Flashcard> cards = _writableMissed();
    if (cards.isEmpty) return;
    HapticsManager.light();
    Navigator.of(context).push(
      SwipeBackPageRoute(
        builder: (BuildContext context) => WritingBenchScreen(cards: cards),
      ),
    );
  }

  /// A short paper over the words that were missed, assembled by the exam's own
  /// builder.
  ///
  /// §5.4.6 asks a report to end in a teaching action, and "look at the answers
  /// again" is not one: this asks the learner to *answer* the words they got wrong,
  /// with a fresh key drawn from the same vocabulary source.
  Future<void> _practiseMissed(ExamReport report) async {
    final List<ExamWord> words = report.missed.map(ExamWord.fromItem).toList();
    final ExamBlueprint? blueprint =
        ExamBlueprint.forDeck(vocabularySize: words.length);
    if (blueprint == null) return;

    final ExamPaper? paper = ExamBuilder.buildFrom(
      blueprint: blueprint,
      words: words,
    );
    if (paper == null || !mounted) return;

    await ref.read(examStoreProvider).savePaper(paper);
    if (!mounted) return;
    HapticsManager.light();
    Navigator.of(context).push(
      SwipeBackPageRoute(
        builder: (BuildContext context) => ExamScreen(paper: paper),
      ),
    );
  }

  /// The teaching action: the missed items become cards in a new deck, copied
  /// through the same repository path the exam folder uses (§5.4.6).
  ///
  /// Strokes are borrowed from the learner's own card for that character when they
  /// have one, so a missed item does not become a card with an empty stroke panel.
  Future<void> _studyMissed() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    final Deck? deck =
        await ref.read(deckControllerProvider.notifier).createDeck(
              widget.paper.isFromDeck
                  // From a deck, so a level number would be wrong: name it after
                  // the source, in the app's own words for a created card set.
                  ? l10n.tutorQuizFolderName(widget.paper.deckName ?? l10n.deck)
                  : l10n.examMissedDeckName(widget.paper.level),
              description: l10n.generatedByAi,
            );
    if (deck == null || !mounted) return;

    final List<Flashcard> library =
        ref.read(flashcardControllerProvider).valueOrNull ??
            const <Flashcard>[];
    final Map<String, Flashcard> byHanzi = <String, Flashcard>{
      for (final Flashcard card in library)
        if (card.hanzi.isNotEmpty) card.hanzi: card,
    };
    final String deckId = deck.id;
    const Uuid uuid = Uuid();

    for (final ExamItem item in _report?.missed ?? const <ExamItem>[]) {
      final Flashcard? known = byHanzi[item.hanzi];
      await ref.read(flashcardRepositoryProvider).saveFlashcard(
            Flashcard(
              id: uuid.v4(),
              deckId: deckId,
              hanzi: item.hanzi,
              pinyin: item.pinyin ?? '',
              definition: item.definition ?? '',
              hskLevel: widget.paper.level,
              strokePaths: known?.strokePaths ?? const <String>[],
              medianPaths: known?.medianPaths ?? const <List<Offset>>[],
              isFlipped: known?.isFlipped ?? false,
              modeStats: const <StudyMode, ReviewStats>{},
            ),
          );
    }

    await ref.read(deckControllerProvider.notifier).loadDecks();
    if (!mounted) return;
    setState(() => _savedMissed = true);
    ZenToast.success(context, l10n.tutorSavedToLibrary);
  }

  Future<void> _loadPreviousBest() async {
    final ExamAttempt? best =
        await ref.read(examStoreProvider).bestAttempt(widget.paper.id);
    if (!mounted || best == null) return;
    setState(() => _previousBest = best);
  }
}
