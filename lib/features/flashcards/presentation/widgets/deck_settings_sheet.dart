import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';

class DeckSettingsSheet extends ConsumerStatefulWidget {
  final Deck deck;

  const DeckSettingsSheet({super.key, required this.deck});

  @override
  ConsumerState<DeckSettingsSheet> createState() => _DeckSettingsSheetState();
}

class _DeckSettingsSheetState extends ConsumerState<DeckSettingsSheet> {
  late int _newCardsLimit;
  late int _reviewLimit;

  @override
  void initState() {
    super.initState();
    _newCardsLimit = widget.deck.dailyNewCardsLimit;
    _reviewLimit = widget.deck.dailyReviewLimit;
  }

  Future<void> _saveSettings() async {
    final updatedDeck = widget.deck.copyWith(
      dailyNewCardsLimit: _newCardsLimit,
      dailyReviewLimit: _reviewLimit,
    );
    await ref.read(deckControllerProvider.notifier).updateDeck(updatedDeck);
    if (mounted) Navigator.pop(context, updatedDeck);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFDFCF0),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 8,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            l10n.deckSettings,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.deck.localizedName(context),
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildLimitSetting(
            title: l10n.dailyNewCards,
            value: _newCardsLimit,
            presets: const [0, 10, 20, 50, -1],
            onChanged: (val) => setState(() => _newCardsLimit = val),
            icon: Icons.fiber_new_rounded,
            color: Colors.green,
            isDark: isDark,
          ),
          const SizedBox(height: 24),
          _buildLimitSetting(
            title: l10n.dailyReviewLimit,
            value: _reviewLimit,
            presets: const [0, 50, 100, 200, -1],
            onChanged: (val) => setState(() => _reviewLimit = val),
            icon: Icons.repeat_rounded,
            color: Colors.indigo,
            isDark: isDark,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _saveSettings,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
            ),
            child: Text(
              l10n.saveSettings,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitSetting({
    required String title,
    required int value,
    required List<int> presets,
    required ValueChanged<int> onChanged,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            // Expanded takes the free space that the old Spacer reserved, so a
            // longer translation wraps instead of overflowing the row.
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                ),
              ),
            ),
            IconButton(
              tooltip: 'Decrease',
              onPressed: value <= 0 ? null : () => onChanged(value - 1),
              icon: const Icon(Icons.remove_circle_outline),
            ),
            InkWell(
              onTap: () => _showExactValueDialog(title, value, onChanged),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                constraints: const BoxConstraints(minWidth: 72),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  value < 0 ? 'Unlimited' : value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: 'Increase',
              onPressed: () => onChanged(value < 0 ? 1 : value + 1),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: presets.map((preset) {
            return ChoiceChip(
              label: Text(preset < 0 ? 'Unlimited' : preset.toString()),
              selected: value == preset,
              onSelected: (_) => onChanged(preset),
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        Text(
          value == 0
              ? '0 means this card type is disabled.'
              : AppLocalizations.of(context)!.tapTheValueToEnter,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Future<void> _showExactValueDialog(
    String title,
    int currentValue,
    ValueChanged<int> onChanged,
  ) async {
    // Capture the root navigator context before the dialog opens. Using the
    // root navigator decouples the AlertDialog from the bottom sheet's widget
    // subtree, preventing the '_dependents.isEmpty' assertion crash that occurs
    // when Flutter tries to resolve InheritedWidgets through a context that is
    // being removed from the tree.
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    final controller = TextEditingController(
      text: currentValue < 0 ? '' : currentValue.toString(),
    );
    final value = await showDialog<int>(
      context: rootContext,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.exactDailyLimit,
            helperText: AppLocalizations.of(context)!.enter0ToDisable,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.cancelAction),
          ),
          TextButton(
            onPressed: () {
              final parsed = int.tryParse(controller.text.trim());
              if (parsed != null && parsed >= 0) {
                Navigator.pop(dialogContext, parsed);
              }
            },
            child: Text(AppLocalizations.of(context)!.apply),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value != null) onChanged(value);
  }
}
