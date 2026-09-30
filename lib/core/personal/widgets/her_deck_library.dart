import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/personal/her_content.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';

/// The flashcards library as one account sees it: a single deck, and the words in it.
///
/// The ordinary library (`TomeManagerScreen`) is a catalogue — six HSK tiers and twenty
/// curated shelves to install from. For her that catalogue is noise around one deck, so
/// this is what she gets instead: her deck, her six words, *on the screen*, and a tap
/// that opens the deck she has rather than offering her one she does not.
///
/// The deck is seeded on open rather than at app start: it only has to exist by the time
/// she can touch it, and a write on every launch would be paid by every account.
class HerDeckLibrary extends ConsumerStatefulWidget {
  const HerDeckLibrary({super.key});

  @override
  ConsumerState<HerDeckLibrary> createState() => _HerDeckLibraryState();
}

class _HerDeckLibraryState extends ConsumerState<HerDeckLibrary> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _seedDeck());
  }

  Future<void> _seedDeck() async {
    await ref.read(flashcardControllerProvider.notifier).ensureLoveDeck();
    if (!mounted) return;
    // Anything that lists decks reads its own provider; without this, the first open on
    // a fresh account could show a card pointing at a deck that is not there yet.
    ref.invalidate(deckControllerProvider);
  }

  /// The `Deck` the detail screen opens. Built here rather than read back from Hive so
  /// the tap works on the same frame the screen does, before the seed has landed.
  Deck get _deck => Deck(
        id: HerContent.deckId,
        name: HerContent.deckName,
        description: HerContent.deckDescription,
        createdAt: DateTime.now(),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CalligraphyBackground(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            GlobalSliverAppBar(
              title: l10n.deckLibraryTitle,
              subtitle: l10n.deckLibrarySubtitle,
              showBackButton: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                child: _buildDeckCard(context, isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeckCard(BuildContext context, bool isDark) {
    final Color primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final Color cardBg = isDark ? const Color(0xFF1E1E24) : Colors.white;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => Navigator.push(
        context,
        SwipeBackPageRoute(builder: (_) => DeckDetailScreen(deck: _deck)),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFE9739B).withValues(alpha: 0.35),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('💗', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // The deck's name is content and stays in one language: it is the
                      // name she gave it.
                      Text(
                        HerContent.deckName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        HerContent.deckDescription,
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryText.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${HerContent.deckVocabulary.length} 词',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryText.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            for (final Map<String, String> word in HerContent.deckVocabulary)
              _buildWordRow(word, primaryText),
          ],
        ),
      ),
    );
  }

  /// One card, as she will study it: the character, then its sound, then what it means.
  /// No fixed heights anywhere — every line is text, and text grows with the reader's
  /// text scale (the trap the birthday shelf's first cut fell into).
  Widget _buildWordRow(Map<String, String> word, Color primaryText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            word['hanzi']!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: primaryText,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  word['pinyin']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryText.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  word['definition']!,
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryText.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
