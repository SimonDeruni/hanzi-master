import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Calligraphic Zen & Ink dialog for renaming a custom deck.
///
/// Returns the updated [Deck] on success, or `null` if cancelled or unchanged.
Future<Deck?> showRenameDeckDialog(
  BuildContext context, {
  required WidgetRef ref,
  required Deck deck,
}) {
  return showDialog<Deck?>(
    context: context,
    useRootNavigator: true,
    builder: (dialogCtx) => _RenameDeckDialog(deck: deck),
  );
}

class _RenameDeckDialog extends ConsumerStatefulWidget {
  final Deck deck;

  const _RenameDeckDialog({required this.deck});

  @override
  ConsumerState<_RenameDeckDialog> createState() => _RenameDeckDialogState();
}

class _RenameDeckDialogState extends ConsumerState<_RenameDeckDialog> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.deck.name)
      ..selection = TextSelection(
        baseOffset: 0,
        extentOffset: widget.deck.name.length,
      );
    _focusNode = FocusNode();
    _isValid = widget.deck.name.trim().isNotEmpty;
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    final valid = _controller.text.trim().isNotEmpty;
    if (valid != _isValid) {
      setState(() => _isValid = valid);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    HapticsManager.light();
    _focusNode.unfocus();
    if (text == widget.deck.name) {
      Navigator.of(context).pop(widget.deck);
      return;
    }
    final updated = await ref
        .read(deckControllerProvider.notifier)
        .renameDeck(widget.deck.id, text);
    if (mounted) {
      Navigator.of(context).pop(updated ?? widget.deck.copyWith(name: text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor:
          isDark ? AppTheme.cardBgDark : AppTheme.xuanPaperLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : const Color(0xFFD4AF37).withValues(alpha: 0.45),
          width: 1.2,
        ),
      ),
      title: Text(
        l10n.renameDeck,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : AppTheme.carbonInkLight,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HanziTextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            hintText: l10n.deckName,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _focusNode.unfocus();
            Navigator.of(context).pop(null);
          },
          child: Text(
            l10n.cancelAction,
            style: TextStyle(
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _isValid ? _submit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isDark ? Colors.amber.shade700 : AppTheme.carbonInkLight,
            foregroundColor:
                isDark ? AppTheme.carbonInkLight : Colors.white,
            disabledBackgroundColor: (isDark
                    ? Colors.amber.shade700
                    : AppTheme.carbonInkLight)
                .withValues(alpha: 0.25),
            disabledForegroundColor: isDark
                ? AppTheme.carbonInkLight.withValues(alpha: 0.4)
                : Colors.white60,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
