import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

/// The deck chooser behind "Generate from Deck".
///
/// It replaces the bare `SimpleDialog` that listed deck names as plain text
/// rows — no card counts, no level, no icon, no palette — which is why the step
/// where you *choose the deck* looked like a different app from the rest.
///
/// Each deck is an ink well in the app's vocabulary (card background, gold
/// hairline, 18px radius, accent glyph) carrying what actually helps the choice:
/// its localized name, how many cards it holds, and its HSK level when the deck
/// is one of the graded ones. An empty library explains itself and points at the
/// official decks instead of showing a blank dialog.
class DeckScenarioPickerSheet extends ConsumerWidget {
  const DeckScenarioPickerSheet({super.key});

  /// Presents the picker and resolves to the chosen deck, or null if dismissed.
  static Future<Deck?> show(BuildContext context) {
    return GlobalBlurredBottomSheet.show<Deck>(
      context,
      child: const DeckScenarioPickerSheet(),
    );
  }

  /// HSK level encoded in a deck id (`hsk3` → 3), or null for custom decks.
  static int? hskLevelOf(Deck deck) {
    final RegExpMatch? match =
        RegExp(r'hsk(\d)').firstMatch(deck.id.toLowerCase());
    if (match == null) return null;
    return int.tryParse(match.group(1)!);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color accent = AppTheme.accentOf(context);
    final Color gold = isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    final Color ink = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final Color muted = isDark ? Colors.white60 : const Color(0xFF6B655B);

    final List<Deck> decks =
        ref.watch(deckControllerProvider).valueOrNull ?? const <Deck>[];
    final cards =
        ref.watch(flashcardControllerProvider).valueOrNull ?? const <dynamic>[];

    int cardCount(Deck deck) =>
        cards.where((dynamic card) => card.deckId == deck.id).length;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.8,
      ),
      child: ListView(
        key: const ValueKey<String>('deck-scenario-picker'),
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 24),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 2, 24, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.chooseADeck,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.practiceFlashcardVocabulary,
                  style: TextStyle(fontSize: 12.5, color: muted, height: 1.35),
                ),
              ],
            ),
          ),
          Container(height: 1, color: gold.withValues(alpha: 0.3)),
          const SizedBox(height: 14),
          if (decks.isEmpty)
            _buildEmptyState(l10n: l10n, accent: accent, muted: muted)
          else
            for (final Deck deck in decks)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: _buildDeckRow(
                  context: context,
                  deck: deck,
                  cardCount: cardCount(deck),
                  l10n: l10n,
                  accent: accent,
                  gold: gold,
                  ink: ink,
                  muted: muted,
                  isDark: isDark,
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildDeckRow({
    required BuildContext context,
    required Deck deck,
    required int cardCount,
    required AppLocalizations l10n,
    required Color accent,
    required Color gold,
    required Color ink,
    required Color muted,
    required bool isDark,
  }) {
    final int? hskLevel = hskLevelOf(deck);
    final bool isEmpty = cardCount == 0;

    return Material(
      color: AppTheme.cardBgOf(context),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        key: ValueKey<String>('deck-scenario-${deck.id}'),
        borderRadius: BorderRadius.circular(18),
        // A deck with no cards cannot seed a scenario: the prompt would be given
        // an empty word list. It stays visible (so the library is complete) but
        // cannot be chosen.
        onTap: isEmpty
            ? null
            : () {
                HapticsManager.selection();
                Navigator.of(context).pop(deck);
              },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border:
                Border.all(color: gold.withValues(alpha: isEmpty ? 0.18 : 0.3)),
          ),
          padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: isEmpty ? 0.06 : 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.layers_rounded,
                  size: 20,
                  color: accent.withValues(alpha: isEmpty ? 0.45 : 1),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      deck.localizedName(context),
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: isEmpty ? muted : ink,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        if (hskLevel != null) ...<Widget>[
                          _buildChip('HSK $hskLevel', accent, isDark),
                          const SizedBox(width: 6),
                        ],
                        Flexible(
                          child: _buildChip(
                            l10n.cardsCount(cardCount),
                            muted,
                            isDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Tooltip(
                message: l10n.generateFromDeck,
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 18,
                  color: accent.withValues(alpha: isEmpty ? 0.4 : 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.16 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildEmptyState({
    required AppLocalizations l10n,
    required Color accent,
    required Color muted,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.layers_outlined,
            size: 40,
            color: accent.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 14),
          Text(
            l10n.no_decks_found,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: muted,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.downloadOfficialDecks,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.5, color: muted, height: 1.35),
          ),
        ],
      ),
    );
  }
}
