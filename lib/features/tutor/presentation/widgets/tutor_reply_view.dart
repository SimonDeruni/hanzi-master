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
import 'package:hanzi_master/features/tutor/data/exam_folder_builder.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_artefacts.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

typedef TutorMakeExecutor = Future<ExamFolderResult> Function(TutorMake make);

class TutorReplyView extends StatelessWidget {
  const TutorReplyView({
    super.key,
    required this.reply,
    required this.data,
    this.onMake,
    this.onAskOption,
    this.onOpenDeck,
  });

  final TutorReply reply;
  final TutorArtefactData data;

  /// Runs a proposal. Absent means the block cannot be acted on, so it renders as
  /// a description rather than a button.
  final TutorMakeExecutor? onMake;

  final ValueChanged<TutorAskOption>? onAskOption;
  final ValueChanged<String>? onOpenDeck;

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
        ),
      ));
    }

    // ASK
    final TutorAsk? ask = reply.ask;
    if (ask != null) {
      blocks.add(Padding(padding: gap, child: _askBlock(theme, ask)));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: blocks);
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
      TutorCiteSource.book =>
        (Icons.menu_book_outlined, cite.quote ?? cite.note ?? l10n.reading),
      TutorCiteSource.dictionary =>
        (Icons.translate, cite.note ?? cite.quote ?? cite.id),
      TutorCiteSource.video =>
        (Icons.play_circle_outline, cite.why ?? l10n.openInYoutube),
    };

    final bool tappable = cite.source == TutorCiteSource.deck && onOpenDeck != null;
    return Semantics(
      button: tappable,
      child: GestureDetector(
        onTap: tappable ? () => onOpenDeck!(cite.id) : null,
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
                      onPressed:
                          onAskOption == null ? null : () => onAskOption!(option),
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
  const _MakeCard({required this.make, required this.executor, this.onOpenDeck});

  final TutorMake make;
  final TutorMakeExecutor? executor;
  final ValueChanged<String>? onOpenDeck;

  @override
  State<_MakeCard> createState() => _MakeCardState();
}

class _MakeCardState extends State<_MakeCard> {
  bool _isRunning = false;
  ExamFolderResult? _result;

  Future<void> _run() async {
    final TutorMakeExecutor? executor = widget.executor;
    if (executor == null || _isRunning) return;
    setState(() => _isRunning = true);
    final ExamFolderResult result = await executor(widget.make);
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
    final ExamFolderResult? result = _result;
    final Deck? deck = result?.deck;

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
                  // Numbers and a proper noun: nothing here needs translating.
                  '${widget.make.items}  ·  ${widget.make.title ?? widget.make.scope ?? widget.make.deckId}',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (deck != null)
                Text(
                  l10n.done,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (result?.status == ExamFolderStatus.notEnoughCards)
            Text(
              // Why it could not be built, in the learner's own terms.
              '${result!.poolSize} ${l10n.deck.toLowerCase()}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          Row(
            children: [
              if (result == null)
                BouncingButton(
                  onPressed: widget.executor == null || _isRunning ? null : _run,
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
              else if (deck != null && widget.onOpenDeck != null)
                BouncingButton(
                  onPressed: () => widget.onOpenDeck!(deck.id),
                  child: Text(
                    deck.name,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
