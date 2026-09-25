import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:uuid/uuid.dart';

/// Calligraphic deck picker behind "Add to Deck" and "Extract to Deck".
///
/// Zen & Ink rules applied here (see `docs/UI_UX_STANDARDS.md`):
/// * The sheet **hugs its content**. An `Expanded` child used to stretch the
///   modal to the full viewport, leaving two deck rows stranded in empty paper;
///   long deck lists now scroll inside a 45%-of-viewport card instead.
/// * Rows wear the canonical accent (Cinnabar `#8B0000` in light, Emperor's
///   Gold in dark) with a gold hairline, never the generic `colorScheme.primary`
///   indigo, and the "New Deck" dialog is the same ink-plus-gold button family as
///   the deck and book screens.
/// * Every label is localized for all 14 supported locales; confirmations are
///   raised with `ZenToast`, which floats above the reader instead of a bare
///   `SnackBar` hidden behind the modal barrier.
class DeckSelectionSheet extends ConsumerWidget {
  final Flashcard? card;
  final List<Flashcard>? cards;
  final VoidCallback? onAdded;

  const DeckSelectionSheet({super.key, this.card, this.cards, this.onAdded})
      : assert(
            card != null || cards != null, 'Must provide either card or cards');

  static Future<bool?> show(BuildContext context,
      {Flashcard? card, List<Flashcard>? cards, VoidCallback? onAdded}) {
    return GlobalBlurredBottomSheet.show<bool>(
      context,
      child: DeckSelectionSheet(card: card, cards: cards, onAdded: onAdded),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final asyncDecks = ref.watch(deckControllerProvider);
    final isBatch = cards != null && cards!.isNotEmpty;
    final wordCount = isBatch ? cards!.length : 1;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        4,
        24,
        24 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        // Hug the content. `mainAxisSize.min` with an `Expanded` child below was
        // what inflated this sheet to a full screen of empty paper.
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, l10n, wordCount, isBatch),
          const SizedBox(height: 20),
          _buildCreateDeckAction(context, ref, l10n),
          const SizedBox(height: 16),
          asyncDecks.when(
            data: (decks) => _buildDeckList(context, ref, decks, l10n),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: ZenLoader()),
            ),
            error: (err, stack) => _buildErrorState(context, l10n, err),
          ),
        ],
      ),
    );
  }

  /// Seal-style header: accent tile, title, and the contextual save prompt.
  Widget _buildHeader(
    BuildContext context,
    AppLocalizations l10n,
    int wordCount,
    bool isBatch,
  ) {
    final ink = _InkPalette(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ink.accent.withValues(alpha: ink.isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ink.accent.withValues(alpha: 0.3)),
          ),
          child: Icon(Icons.layers_rounded, size: 22, color: ink.accent),
        ),
        const SizedBox(width: 12),
        // Expanded rather than a Spacer: Russian and Vietnamese expand the
        // prompt to roughly twice the English width, so it must wrap.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.chooseADeck,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: ink.primaryText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isBatch
                    ? l10n.whereWouldYouLikeWords(wordCount)
                    : l10n.whereWouldYouLike,
                style: TextStyle(fontSize: 12, color: ink.secondaryText),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Gold-hairline action card for creating a deck, matching the book-screen
  /// secondary button (Xuan parchment fill, Emperor's Gold border).
  Widget _buildCreateDeckAction(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final ink = _InkPalette(context);

    return BouncingButton(
      onPressed: () async {
        // Captured before the awaits: the failure confirmation must still be
        // raised if this sheet is dismissed while the deck is being created.
        final OverlayState? overlay =
            Overlay.maybeOf(context, rootOverlay: true);
        final newDeckName = await _showCreateDeckDialog(context);
        if (newDeckName == null || newDeckName.trim().isEmpty) return;
        if (!context.mounted) return;

        final deckCtrl = ref.read(deckControllerProvider.notifier);
        final newDeck = await deckCtrl.createDeck(newDeckName.trim());
        if (!context.mounted) return;

        if (newDeck != null) {
          _addCardsToDeck(
            context,
            ref,
            newDeck.id,
            newDeck.localizedName(context),
          );
          return;
        }

        final error = ref.read(deckControllerProvider).error?.toString();
        _showInkToast(
          overlay,
          error ?? l10n.failedToCreateDeck,
          tone: ZenToastTone.error,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: ink.isDark
              ? ink.accent.withValues(alpha: 0.08)
              : AppTheme.cardBgLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ink.goldBorder.withValues(alpha: ink.isDark ? 0.7 : 0.55),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ink.glyphTile,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.add_rounded, size: 20, color: ink.accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.createNewDeck,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: ink.accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Grouped, hairline-separated deck card that never grows past half the
  /// viewport: a short list keeps the sheet hugging its content, a long one
  /// scrolls inside the card.
  Widget _buildDeckList(
    BuildContext context,
    WidgetRef ref,
    List<Deck> decks,
    AppLocalizations l10n,
  ) {
    final ink = _InkPalette(context);

    if (decks.isEmpty) {
      return Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 18, color: ink.secondaryText),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.noDecksFound,
              style: TextStyle(fontSize: 13, color: ink.secondaryText),
            ),
          ),
        ],
      );
    }

    // One pass over the library instead of a filtered scan per deck row.
    final allCards = ref.watch(flashcardControllerProvider).value ?? [];
    final cardCounts = <String, int>{};
    for (final Flashcard c in allCards) {
      cardCounts[c.deckId] = (cardCounts[c.deckId] ?? 0) + 1;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.45,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ink.rowFill,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: ink.hairline),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: decks.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            indent: 62,
            endIndent: 12,
            color: ink.hairline,
          ),
          itemBuilder: (context, index) {
            final deck = decks[index];
            return _buildDeckRow(
              context: context,
              ref: ref,
              deck: deck,
              cardCount: cardCounts[deck.id] ?? 0,
              l10n: l10n,
              ink: ink,
            );
          },
        ),
      ),
    );
  }

  /// A single deck row: accent seal tile, localized name, live card count and a
  /// chevron affordance. [BouncingButton] supplies the haptic plus the Tier 2
  /// press feedback (`ZenMotion.tap`).
  Widget _buildDeckRow({
    required BuildContext context,
    required WidgetRef ref,
    required Deck deck,
    required int cardCount,
    required AppLocalizations l10n,
    required _InkPalette ink,
  }) {
    final isDefaultDeck = deck.id == 'default';

    return BouncingButton(
      onPressed: () => _addCardsToDeck(
        context,
        ref,
        deck.id,
        deck.localizedName(context),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ink.glyphTile,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isDefaultDeck
                    ? Icons.library_books_rounded
                    : Icons.menu_book_rounded,
                size: 19,
                color: ink.accent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deck.localizedName(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: ink.primaryText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.deckItemsCount(cardCount),
                    style: TextStyle(fontSize: 11.5, color: ink.secondaryText),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 20, color: ink.chevron),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    AppLocalizations l10n,
    Object err,
  ) {
    final ink = _InkPalette(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error_outline_rounded, size: 18, color: ink.error),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '${l10n.errorPrefix}$err',
            style: TextStyle(fontSize: 13, color: ink.error),
          ),
        ),
      ],
    );
  }

  /// Calligraphic "New Deck" dialog: the shared Hanzi text field, with the
  /// book-screen primary button (carbon ink in light mode, Emperor's Gold in
  /// dark mode).
  Future<String?> _showCreateDeckDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ink = _InkPalette(context);

    // Capture the root navigator context before the dialog opens. Resolving
    // InheritedWidgets through the sheet's own subtree while it is being removed
    // triggers the `_dependents.isEmpty` assertion.
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    final controller = TextEditingController();

    return showDialog<String>(
      context: rootContext,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.newDeck),
        content: HanziTextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: l10n.deckName,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancelAction),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  ink.isDark ? Colors.amber.shade700 : AppTheme.carbonInkLight,
              foregroundColor:
                  ink.isDark ? AppTheme.carbonInkLight : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(l10n.createAction),
          ),
        ],
      ),
    ).whenComplete(() => controller.dispose());
  }

  void _addCardsToDeck(BuildContext context, WidgetRef ref, String deckId,
      String deckName) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = ref.read(flashcardControllerProvider.notifier);
    final navigator = Navigator.of(context);
    // Resolved before the first await: this sheet pops itself as it saves, so
    // its context cannot be used once the writes complete.
    final OverlayState? overlay = Overlay.maybeOf(context, rootOverlay: true);

    if (cards != null && cards!.isNotEmpty) {
      // Get existing cards to detect duplicates (for accurate count)
      final existingCards = ref.read(flashcardControllerProvider).value ?? [];
      final existingHanzi = existingCards.map((c) => c.hanzi).toSet();

      int addedCount = 0;
      int skippedCount = 0;
      for (final c in cards!) {
        final newCard = Flashcard(
          id: const Uuid().v4(),
          hanzi: c.hanzi,
          pinyin: c.pinyin,
          definition: c.definition,
          hskLevel: c.hskLevel,
          strokePaths: const [],
          modeStats: const {},
          deckId: deckId,
        );
        if (existingHanzi.contains(c.hanzi)) {
          // Already exists — update its definition/pinyin but keep the existing card
          skippedCount++;
          await controller
              .addFlashcard(newCard); // This will update the existing one
        } else {
          await controller.addFlashcard(newCard);
          addedCount++;
          existingHanzi
              .add(c.hanzi); // Track for subsequent duplicates in same batch
        }
      }

      final String message;
      if (skippedCount > 0 && addedCount > 0) {
        message = l10n.addedWordsAndUpdatedWords(
          addedCount,
          skippedCount,
          deckName,
        );
      } else if (skippedCount > 0) {
        message = l10n.updatedWordsInDeck(skippedCount, deckName);
      } else {
        message = l10n.addedWordsToDeck(addedCount, deckName);
      }
      _showInkToast(overlay, message);
    } else if (card != null) {
      final newCard = Flashcard(
        id: const Uuid().v4(),
        hanzi: card!.hanzi,
        pinyin: card!.pinyin,
        definition: card!.definition,
        hskLevel: card!.hskLevel,
        strokePaths: const [],
        modeStats: const {},
        deckId: deckId,
      );
      await controller.addFlashcard(newCard);
      _showInkToast(
        overlay,
        l10n.addedCardToDeck(card!.hanzi, deckName),
      );
    }

    // `true` signals a successful add; dismissal leaves this null so callers can
    // tell "words were saved" apart from "the user backed out".
    navigator.pop(true);
    if (onAdded != null) onAdded!();
  }

  /// Success is Jade Green, failures are Cinnabar, and both float above the
  /// reader for the standard toast dwell so long translations stay readable.
  void _showInkToast(
    OverlayState? overlay,
    String message, {
    ZenToastTone tone = ZenToastTone.success,
  }) {
    ZenToast.showOn(overlay, message, tone: tone);
  }
}

/// The Zen & Ink palette for this sheet, resolved once per build.
///
/// Mirrors the vocabulary used by the ambient soundscape and reading sheets, so
/// the modal reads as one surface family rather than a Material default.
class _InkPalette {
  final bool isDark;

  /// Cinnabar `#8B0000` in light mode, Emperor's Gold in dark mode.
  final Color accent;

  _InkPalette(BuildContext context)
      : isDark = Theme.of(context).brightness == Brightness.dark,
        accent = AppTheme.accentOf(context);

  Color get primaryText =>
      isDark ? AppTheme.carbonInkDark : AppTheme.carbonInkLight;

  Color get secondaryText => isDark ? Colors.white60 : const Color(0xFF6B655B);

  /// Emperor's Gold hairline used by the calligraphic sheets.
  Color get goldBorder =>
      isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);

  Color get hairline => isDark
      ? Colors.white.withValues(alpha: 0.1)
      : Colors.black.withValues(alpha: 0.08);

  Color get rowFill =>
      isDark ? Colors.white.withValues(alpha: 0.04) : const Color(0xFFF7F3E9);

  Color get glyphTile => accent.withValues(alpha: isDark ? 0.18 : 0.1);

  Color get chevron => isDark ? Colors.white24 : Colors.black26;

  /// Cinnabar `#C62828` for failures. Success feedback lives on [ZenToast].
  Color get error => isDark ? Colors.redAccent : const Color(0xFFC62828);
}
