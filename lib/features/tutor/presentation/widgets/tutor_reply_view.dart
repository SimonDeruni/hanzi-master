/// Renders a [TutorReply] as a stack of blocks, in a fixed order:
/// **SAY → SHOW → CITE → MAKE → ASK** (`docs/AI_TUTOR_CONCEPT.md` §12).
///
/// The view owns no data and no writes. It is handed an already-validated reply
/// plus the local bundle the artefacts build from, and callbacks for the things
/// it cannot do itself: executing a proposal, following a citation, answering a
/// question. A block that cannot render simply does not appear.
library;

import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_make_result.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_artefacts.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

typedef TutorMakeExecutor = Future<TutorMakeResult> Function(TutorMake make);

class TutorReplyView extends StatelessWidget {
  const TutorReplyView({
    super.key,
    required this.reply,
    required this.data,
    this.onMake,
    this.onAskOption,
    this.onOpenDeck,
    this.onOpenPaper,
    this.onOpenStory,
    this.onOpenVideo,
  });

  final TutorReply reply;
  final TutorArtefactData data;

  /// Runs a proposal. Absent means the block cannot be acted on, so it renders as
  /// a description rather than a button.
  final TutorMakeExecutor? onMake;

  final ValueChanged<TutorAskOption>? onAskOption;
  final ValueChanged<String>? onOpenDeck;

  /// Opens a paper a `make` created, by its id. Separate from [onOpenDeck]
  /// because a paper is not a deck: it lives in the exam store, and it opens in
  /// the sitting screen rather than the deck screen.
  final ValueChanged<String>? onOpenPaper;

  /// Opens a reading pack's story: the catalogue blueprint it came from, and the
  /// level it was written for. Absent means the link is not offered at all.
  final void Function(String blueprintId, int level)? onOpenStory;

  /// Opens a cited teaching video in the app's own YouTube player. Absent means
  /// the chip is inert, exactly as a deck chip is without [onOpenDeck].
  final ValueChanged<String>? onOpenVideo;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    const EdgeInsets gap = EdgeInsets.only(top: 10);

    final List<Widget> blocks = <Widget>[];

    // SAY
    if (reply.say != null) blocks.add(_sayBubble(theme, isDark, reply.say!));

    // SHOW — a builder that cannot build returns null, and the block is dropped.
    for (final TutorArtefact artefact in reply.artefacts) {
      final Widget? widget = TutorArtefactRegistry.build(
        context,
        artefact: artefact,
        data: data,
        isDark: isDark,
      );
      if (widget != null) blocks.add(Padding(padding: gap, child: widget));
    }

    // CITE
    if (reply.cites.isNotEmpty) {
      blocks.add(Padding(
        padding: gap,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: reply.cites
              .map((TutorCite cite) => _citeChip(context, theme, cite))
              .toList(),
        ),
      ));
    }

    // MAKE — a proposal, always confirmed by the learner.
    for (final TutorMake make in reply.makes) {
      blocks.add(Padding(
        padding: gap,
        child: _MakeCard(
          make: make,
          executor: onMake,
          onOpenDeck: onOpenDeck,
          onOpenPaper: onOpenPaper,
          onOpenStory: onOpenStory,
        ),
      ));
    }

    // ASK
    final TutorAsk? ask = reply.ask;
    if (ask != null) {
      blocks.add(Padding(padding: gap, child: _askBlock(theme, ask)));
    }

    // Provenance (§4.1), as a footnote rather than a block: when the model did not
    // answer, the reply says so. A local answer is a real answer, but passing it
    // off as the tutor's would undo the one rule this feature is built on.
    if (!reply.fromModel) {
      blocks.add(Padding(
        padding: gap,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.offline_bolt_outlined,
              size: 13,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                AppLocalizations.of(context)!.tutorAnsweredLocally,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ),
          ],
        ),
      ));
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: blocks);
  }

  Widget _sayBubble(ThemeData theme, bool isDark, String say) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252525) : const Color(0xFFFFF8EE),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomRight: Radius.circular(18),
          bottomLeft: Radius.circular(6),
        ),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.07),
        ),
      ),
      child: Text(
        say,
        style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
      ),
    );
  }

  Widget _citeChip(BuildContext context, ThemeData theme, TutorCite cite) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final (IconData icon, String label) = switch (cite.source) {
      TutorCiteSource.deck => (Icons.style_outlined, cite.note ?? l10n.deck),
      TutorCiteSource.book => (
          Icons.menu_book_outlined,
          cite.quote ?? cite.note ?? l10n.reading
        ),
      TutorCiteSource.dictionary => (
          Icons.translate,
          cite.note ?? cite.quote ?? cite.id
        ),
      TutorCiteSource.video => (
          Icons.play_circle_outline,
          cite.why ?? l10n.openInYoutube
        ),
    };

    // A video chip reads "Open in YouTube", so it has to open YouTube — it was
    // drawn with a play glyph and then ignored every tap. Both kinds are inert
    // when the host supplied no way to follow them.
    final VoidCallback? onTap = switch (cite.source) {
      TutorCiteSource.deck when onOpenDeck != null => () =>
          onOpenDeck!(cite.id),
      TutorCiteSource.video when onOpenVideo != null => () =>
          onOpenVideo!(cite.id),
      _ => null,
    };
    return Semantics(
      button: onTap != null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _askBlock(ThemeData theme, TutorAsk ask) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ask.question,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        if (ask.options.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ask.options
                .map((TutorAskOption option) => BouncingButton(
                      onPressed: onAskOption == null
                          ? null
                          : () => onAskOption!(option),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.cardBgLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.35),
                          ),
                        ),
                        child: Text(
                          option.label,
                          style: theme.textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }
}

/// The confirm card for a `make` proposal.
///
/// §4.4: **the tutor proposes, the learner commits.** Nothing is written until
/// [TutorReplyView.onMake] runs, which only the Create button calls — so the
/// tutor can never edit a library on its own, and a refusal (a deck too small for
/// the request) is shown as an answer rather than swallowed.
class _MakeCard extends StatefulWidget {
  const _MakeCard({
    required this.make,
    required this.executor,
    this.onOpenDeck,
    this.onOpenPaper,
    this.onOpenStory,
  });

  final TutorMake make;
  final TutorMakeExecutor? executor;
  final ValueChanged<String>? onOpenDeck;
  final ValueChanged<String>? onOpenPaper;

  /// Opens a reading pack's story: the catalogue blueprint it came from, and the
  /// level it was written for.
  final void Function(String blueprintId, int level)? onOpenStory;

  @override
  State<_MakeCard> createState() => _MakeCardState();
}

class _MakeCardState extends State<_MakeCard> {
  bool _isRunning = false;
  TutorMakeResult? _result;

  Future<void> _run() async {
    final TutorMakeExecutor? executor = widget.executor;
    if (executor == null || _isRunning) return;
    setState(() => _isRunning = true);
    final TutorMakeResult result = await executor(widget.make);
    if (!mounted) return;
    setState(() {
      _isRunning = false;
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final TutorMakeResult? result = _result;
    final Deck? deck = result?.deck;
    final String? paperId = result?.paperId;
    final String? packBlueprintId = result?.blueprintId;
    final int? packLevel = result?.hskLevel;
    final bool created = result != null &&
        result.status != TutorMakeStatus.failed &&
        result.status != TutorMakeStatus.notEnoughCards &&
        result.status != TutorMakeStatus.nothingDue;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school_outlined,
                  size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  // What it will be called if it is made — and the model's own
                  // title when it proposed one, because "an exam on my Tones deck"
                  // reads better than the app's generic name.
                  widget.make.title ?? widget.make.scope ?? _kindName(l10n),
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (created)
                Text(
                  l10n.done,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          // How many items, in the app's own wording (`deckItemsCount` is the
          // string the deck picker already uses) rather than "3 items" glued
          // together in Dart. A proposal that counts nothing (a review sprint, a
          // reading pack) says nothing here rather than claiming "0 items".
          if (widget.make.items > 0)
            Text(
              l10n.deckItemsCount(widget.make.items),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          const SizedBox(height: 10),
          if (result?.status == TutorMakeStatus.notEnoughCards)
            Text(
              // The app's existing sentence for this refusal — the same one a
              // quiz start shows — instead of a count glued to a lowercased
              // noun, which read as "3 deck" and broke in German.
              l10n.notEnoughCardsFor,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          if (result?.status == TutorMakeStatus.nothingDue)
            Text(
              l10n.tutorNothingDue,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          // A pack that could not be written (offline, or no key for its words):
          // said plainly, because the alternative is a card that looks like it
          // worked.
          if (result?.status == TutorMakeStatus.failed)
            Text(
              l10n.tutorMakeFailed,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          // `Wrap`, not `Row`: a single action does not need a row, and a second
          // one (or a longer translation) must never push the first out.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              if (result == null)
                BouncingButton(
                  onPressed:
                      widget.executor == null || _isRunning ? null : _run,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      l10n.create,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else if (result.status == TutorMakeStatus.createdReadingPack &&
                  packBlueprintId != null &&
                  packLevel != null) ...[
                // A reading pack's first link is the story itself: reading it is the
                // point, and it opens out of the library's own cache.
                if (widget.onOpenStory != null)
                  BouncingButton(
                    onPressed: () =>
                        widget.onOpenStory!(packBlueprintId, packLevel),
                    child: _linkRow(theme, l10n,
                        icon: Icons.menu_book_outlined,
                        label: l10n.tutorOpenStory),
                  ),
                // And the questions, only when the app could actually build them.
                if (paperId != null && widget.onOpenPaper != null)
                  BouncingButton(
                    onPressed: () => widget.onOpenPaper!(paperId),
                    child: _linkRow(theme, l10n,
                        icon: Icons.timer_outlined,
                        label: l10n.tutorStoryQuestions(result.itemCount)),
                  ),
              ] else if (deck != null && widget.onOpenDeck != null)
                // The folder exists now, so this is the reply's link to it: a real
                // affordance with an icon and a chevron, not the deck's name
                // hoping to be recognised as tappable.
                BouncingButton(
                  onPressed: () => widget.onOpenDeck!(deck.id),
                  child: _linkRow(theme, l10n,
                      icon: Icons.folder_open_outlined,
                      label: l10n.tutorOpenQuiz),
                )
              else if (paperId != null && widget.onOpenPaper != null)
                // The paper exists now: the same link, pointing at the test.
                BouncingButton(
                  onPressed: () => widget.onOpenPaper!(paperId),
                  child: _linkRow(theme, l10n,
                      icon: Icons.timer_outlined, label: l10n.examStart),
                ),
            ],
          ),
          if (deck != null ||
              result?.status == TutorMakeStatus.createdReadingPack)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              // Answers "where did it go?", which is the question a created
              // folder — or a created story — leaves behind: in the library the
              // rest of the app already uses. (A paper says nothing here — it is a
              // sitting, not a place.)
              child: Text(
                l10n.tutorSavedToLibrary,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// What the app calls this kind of object, for a proposal the model did not name
  /// itself. A reading pack and a review sprint have neither a deck nor a level to
  /// be named after, so they need a name of their own.
  String _kindName(AppLocalizations l10n) {
    switch (widget.make.kind) {
      case TutorMakeKind.examFolder:
        return l10n.deck;
      case TutorMakeKind.examPaper:
        return l10n.examTitle(widget.make.level ?? 1);
      case TutorMakeKind.readingPack:
        return l10n.tutorReadingPack(widget.make.level ?? 1);
      case TutorMakeKind.reviewSprint:
        return l10n.tutorReviewSprint;
    }
  }

  /// The one link style every kind of `make` uses: an icon, a localised label and
  /// a chevron, so "open it" looks the same whether it opens a folder, a test or a
  /// story.
  Widget _linkRow(
    ThemeData theme,
    AppLocalizations l10n, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          // Flexible, like every localised child in a row: a longer translation
          // wraps instead of pushing the chevron off the edge.
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.chevron_right,
            size: 18,
            color: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
