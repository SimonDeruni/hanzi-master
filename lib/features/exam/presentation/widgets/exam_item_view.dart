/// One question, as a paper shows it.
///
/// Two rules are enforced by what is *absent* here:
///
///  * **No feedback.** Options never turn green or red and nothing says "correct"
///    — a paper that grades as you go is a drill, and the learner can no longer
///    sit it honestly (§5.4.2). The selection is recorded and forgotten until the
///    report.
///  * **No answer anywhere.** The view renders the stem and the options;
///    [ExamItem.answer] is read by the grader alone.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_blueprint.dart';
import 'package:hanzi_master/features/exam/domain/entities/exam_paper.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

class ExamItemView extends ConsumerStatefulWidget {
  const ExamItemView({
    super.key,
    required this.item,
    required this.selected,
    required this.onSelected,
  });

  final ExamItem item;

  /// What the learner has chosen so far, if anything.
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  ConsumerState<ExamItemView> createState() => _ExamItemViewState();
}

class _ExamItemViewState extends ConsumerState<ExamItemView> {
  /// The kinds whose stem is audio: they play on arrival, with a replay control.
  bool get _isAudioItem =>
      widget.item.kind == ExamItemKind.audioToCharacter ||
      widget.item.kind == ExamItemKind.toneChoice ||
      widget.item.kind == ExamItemKind.dictation;

  final TextEditingController _typing = TextEditingController();

  /// The order-token indexes the learner has placed, in the order they placed them.
  /// Indexes rather than values: a sentence can contain the same word twice, and
  /// each token is usable once.
  final List<int> _placed = <int>[];

  @override
  void initState() {
    super.initState();
    // Coming back to an item restores what was already answered: the runner keeps
    // the answer, but the tray and the field live here, so they read it back.
    final String? previous = widget.selected;
    if (previous != null && previous.isNotEmpty) {
      if (widget.item.kind == ExamItemKind.dictation) {
        _typing.text = previous;
      } else if (widget.item.kind == ExamItemKind.orderTokens) {
        final List<bool> taken =
            List<bool>.filled(widget.item.options.length, false);
        for (final String token in previous.split(' ')) {
          for (int i = 0; i < widget.item.options.length; i++) {
            if (!taken[i] && widget.item.options[i] == token) {
              taken[i] = true;
              _placed.add(i);
              break;
            }
          }
        }
      }
    }
    // A listening item that does not play is not a listening item. Played once on
    // arrival, with a replay control below — exactly like the real test.
    if (_isAudioItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _play());
    }
  }

  @override
  void dispose() {
    _typing.dispose();
    super.dispose();
  }

  void _play() {
    if (!mounted) return;
    ref.read(audioServiceProvider).playCharacter(widget.item.hanzi);
  }

  String _prompt(AppLocalizations l10n) {
    switch (widget.item.kind) {
      case ExamItemKind.audioToCharacter:
        return l10n.examPromptAudio;
      case ExamItemKind.toneChoice:
        return l10n.examPromptTone;
      case ExamItemKind.dictation:
        return l10n.examPromptDictation;
      case ExamItemKind.characterToMeaning:
        return l10n.examPromptMeaning;
      case ExamItemKind.characterToPinyin:
        return l10n.examPromptPinyin;
      case ExamItemKind.fillBlank:
      case ExamItemKind.passageFill:
        return l10n.examPromptFill;
      case ExamItemKind.grammarError:
        return l10n.examPromptGrammar;
      case ExamItemKind.orderTokens:
        return l10n.examPromptOrder;
    }
  }

  /// The sequence the learner has built, as the grader compares it.
  void _reportOrder() {
    widget.onSelected(
      _placed.map((int index) => widget.item.options[index]).join(' '),
    );
  }

  void _place(int index) {
    setState(() => _placed.add(index));
    HapticsManager.selection();
    _reportOrder();
  }

  void _unplace() {
    setState(() => _placed.clear());
    // Empty means unanswered: the runner treats it as nothing chosen.
    widget.onSelected('');
  }

  /// The audio control every listening item shares.
  Widget _audioButton(ThemeData theme, AppLocalizations l10n) {
    return BouncingButton(
      onPressed: _play,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.volume_up, color: theme.colorScheme.onPrimary, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                l10n.examReplay,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _prompt(l10n),
          style:
              theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _stem(theme, l10n),
        const SizedBox(height: 20),
        if (widget.item.kind == ExamItemKind.orderTokens)
          _orderArea(theme, l10n)
        else if (widget.item.kind == ExamItemKind.dictation)
          _dictationField(theme, l10n)
        else
          for (final String option in widget.item.options)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _option(theme, option),
            ),
      ],
    );
  }

  Widget _stem(ThemeData theme, AppLocalizations l10n) {
    switch (widget.item.kind) {
      case ExamItemKind.audioToCharacter:
      case ExamItemKind.toneChoice:
      case ExamItemKind.dictation:
        // The character is *not* shown: that would be the answer.
        return _audioButton(theme, l10n);
      case ExamItemKind.characterToMeaning:
      case ExamItemKind.characterToPinyin:
        return Text(
          widget.item.hanzi,
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onSurface,
          ),
        );
      case ExamItemKind.fillBlank:
      case ExamItemKind.passageFill:
        return Text(
          widget.item.sentence ?? widget.item.hanzi,
          style: theme.textTheme.titleMedium?.copyWith(height: 1.6),
        );
      case ExamItemKind.grammarError:
        // The four sentences *are* the stem: there is nothing above them to read.
        return const SizedBox.shrink();
      case ExamItemKind.orderTokens:
        // The words to arrange are the stem, and they are rendered as chips.
        return const SizedBox.shrink();
    }
  }

  /// The words to arrange: what has been placed so far, then what is left.
  Widget _orderArea(ThemeData theme, AppLocalizations l10n) {
    final Set<int> placed = _placed.toSet();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
            ),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final int index in _placed) _token(theme, index),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Each word is usable once, so a sentence with a repeated word still works.
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (int i = 0; i < widget.item.options.length; i++)
              if (!placed.contains(i))
                BouncingButton(
                  onPressed: () => _place(i),
                  child: _token(theme, i, tappable: true),
                ),
          ],
        ),
        if (_placed.isNotEmpty) ...<Widget>[
          const SizedBox(height: 10),
          BouncingButton(
            onPressed: _unplace,
            child: Text(
              l10n.retry,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _token(ThemeData theme, int index, {bool tappable = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            theme.colorScheme.primary.withValues(alpha: tappable ? 0.08 : 0.16),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        widget.item.options[index],
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  Widget _dictationField(ThemeData theme, AppLocalizations l10n) {
    return TextField(
      controller: _typing,
      autofocus: true,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: TextInputAction.done,
      style: theme.textTheme.titleMedium,
      decoration: InputDecoration(
        // Says both acceptable ways to write a tone, so the learner is not graded
        // on a convention they were never told.
        hintText: l10n.examHintPinyin,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      // Reported as it is typed: the runner's question is "has anything been
      // answered", and an empty field must count as nothing.
      onChanged: (String value) {
        final String trimmed = value.trim();
        if (trimmed.isNotEmpty) widget.onSelected(trimmed);
      },
    );
  }

  Widget _option(ThemeData theme, String option) {
    final bool isSelected = widget.selected == option;
    return BouncingButton(
      onPressed: () {
        HapticsManager.selection();
        widget.onSelected(option);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          // Selected is only *selected*: nothing about this colour means "right".
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.12)
              : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withValues(alpha: 0.12),
            width: isSelected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(option, style: theme.textTheme.bodyLarge),
            ),
            if (isSelected)
              Icon(Icons.check_circle,
                  size: 18, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
