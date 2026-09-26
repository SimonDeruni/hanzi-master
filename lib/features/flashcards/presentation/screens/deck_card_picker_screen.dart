import 'dart:async';

import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/shared/widgets/staggered_list_item.dart';
import 'package:hanzi_master/shared/widgets/zen_exit.dart';
import 'package:hanzi_master/shared/widgets/zen_flight.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';

class DeckCardPickerScreen extends ConsumerStatefulWidget {
  final String deckId;
  final String deckName;

  const DeckCardPickerScreen({
    super.key,
    required this.deckId,
    required this.deckName,
  });

  @override
  ConsumerState<DeckCardPickerScreen> createState() =>
      _DeckCardPickerScreenState();
}

class _DeckCardPickerScreenState extends ConsumerState<DeckCardPickerScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  /// Cards whose row is currently leaving. The card is only added to the deck once
  /// the exit finishes, so `ZenExit` has a row left to draw.
  final Set<String> _exiting = <String>{};

  /// One key per row, so the flight has a real origin: the button the user
  /// actually tapped, rather than a guessed corner of the row.
  final Map<String, GlobalKey> _rowKeys = <String, GlobalKey>{};

  /// The deck's name in the app bar — the visible deck a card flies into.
  final GlobalKey _deckTargetKey = GlobalKey();

  GlobalKey _rowKey(String cardId) =>
      _rowKeys.putIfAbsent(cardId, () => GlobalKey());

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// The small card that travels: the word, on the paper of the row it left.
  ///
  /// It must size to its content — `ZenFlight` centres it on its own size.
  Widget _flyingCard(String hanzi, bool isDark) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF232326) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          hanzi,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addTo(widget.deckName),
          // The deck the card is going into, named on screen for the whole
          // session: the target of the flight, never a guessed position.
          key: _deckTargetKey,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor:
          isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: asyncFlashcards.when(
        data: (allCards) {
          // Exclude cards already in this deck
          final availableCards =
              allCards.where((c) => c.deckId != widget.deckId).toList();

          final filteredCards = availableCards.where((c) {
            final query = _searchQuery.toLowerCase();
            return c.hanzi.contains(query) ||
                c.pinyin.toLowerCase().contains(query) ||
                c.definition.toLowerCase().contains(query);
          }).toList();

          return ZenFadeIn(child: Column(
            children: [
              ZenSearchBar(
                controller: _searchController,
                hintText: AppLocalizations.of(context)!.searchDictionaryHint,
                onChanged: (val) => setState(() => _searchQuery = val),
              ),
              Expanded(
                child: filteredCards.isEmpty
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.noAvailableCardsFound,
                          style: TextStyle(
                              color: isDark ? Colors.white54 : Colors.black54),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredCards.length,
                        itemBuilder: (context, index) {
                          final card = filteredCards[index];
                          // Row entrance: the list assembles with a stagger.
                          return StaggeredListItem(
                            index: index,
                            child: ZenExit(
                              // Adding the card takes this row out of the
                              // "available" list; let it leave (ZenMotion.exit)
                              // instead of vanishing, and commit on completion.
                              removing: _exiting.contains(card.id),
                              onRemoved: () {
                                _exiting.remove(card.id);
                                // The row's origin key is spent: the flight
                                // captured where it left from at take-off.
                                _rowKeys.remove(card.id);
                                ref
                                    .read(flashcardControllerProvider.notifier)
                                    .updateFlashcard(
                                        card.copyWith(deckId: widget.deckId));
                                final l10n = AppLocalizations.of(context);
                                final msg = l10n != null
                                    ? l10n.addedCardToDeck(
                                        card.hanzi, widget.deckName)
                                    : 'Added ${card.hanzi} to ${widget.deckName}';
                                ZenToast.info(context, msg);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: isDark
                                          ? Colors.white12
                                          : Colors.black12),
                                ),
                                child: ListTile(
                                  leading: Text(
                                    card.hanzi,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  title: PinyinText(text: card.pinyin),
                                  subtitle: TranslatedDefinition(
                                    definition: card.definition,
                                    definitionLanguage: card.definitionLanguage,
                                    hanzi: card.hanzi,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: IconButton(
                                    // The origin of the flight is this button,
                                    // so the card lifts off exactly what the
                                    // user tapped.
                                    key: _rowKey(card.id),
                                    icon: const Icon(Icons.add_circle_outline,
                                        color: Colors.indigo),
                                    onPressed: () {
                                      // Fire-and-forget: the commit below must
                                      // never wait for the card to land, so the
                                      // landing is not awaited here.
                                      unawaited(ZenFlight.to(
                                        context: context,
                                        from: _rowKey(card.id),
                                        to: _deckTargetKey,
                                        child: _flyingCard(card.hanzi, isDark),
                                      ));
                                      // Hand the row to ZenExit: the commit and
                                      // the toast happen when it has finished
                                      // leaving.
                                      setState(() => _exiting.add(card.id));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ));
        },
        loading: () => const Center(child: ZenLoader()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
