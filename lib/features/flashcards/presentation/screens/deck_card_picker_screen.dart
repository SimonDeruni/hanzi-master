import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';

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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addTo(widget.deckName)),
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

          return Column(
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
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.05)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color:
                                      isDark ? Colors.white12 : Colors.black12),
                            ),
                            child: ListTile(
                              leading: Text(
                                card.hanzi,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
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
                                icon: const Icon(Icons.add_circle_outline,
                                    color: Colors.indigo),
                                onPressed: () {
                                  final updatedCard =
                                      card.copyWith(deckId: widget.deckId);
                                  ref
                                      .read(
                                          flashcardControllerProvider.notifier)
                                      .updateFlashcard(updatedCard);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${card.hanzi} ${AppLocalizations.of(context)?.addedToDeck ?? "added to"} ${widget.deckName}'),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
