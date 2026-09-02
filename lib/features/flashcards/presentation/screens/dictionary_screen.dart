import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/course/domain/entities/course_unit.dart';
import 'package:hanzi_master/features/course/presentation/widgets/radical_detail_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/dictionary_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/shared/widgets/staggered_list_item.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/mastery_seal.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/shared/widgets/nuance_compare_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/radical_library_screen.dart';
import 'package:hanzi_master/features/course/presentation/screens/tome_manager_screen.dart'
    as hanzi_tome;
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/utils/definition_formatter.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/core/presentation/widgets/zen_search_bar.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/core/providers.dart';

class DictionaryScreen extends ConsumerStatefulWidget {
  const DictionaryScreen({super.key});

  @override
  ConsumerState<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends ConsumerState<DictionaryScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(searchFocusRequestProvider, (previous, next) {
      if (next == true) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            _searchFocusNode.requestFocus();
            ref.read(searchFocusRequestProvider.notifier).state = false;
          }
        });
      }
    });

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final asyncDecks = ref.watch(deckControllerProvider);
    final masterResults =
        ref.watch(masterSearchProvider(_searchQuery)).valueOrNull ?? [];

    return Scaffold(
      body: CalligraphyBackground(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            GlobalSliverAppBar(
              title: l10n?.scholarsLibrary ?? "The Scholar's Library",
              actions: const [],
              showBackButton: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ZenSearchBar(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        hintText: l10n?.searchPinyinHanziEnglish ??
                            AppLocalizations.of(context)!
                                .searchPinyinHanziEnglish,
                        onChanged: (value) =>
                            setState(() => _searchQuery = value),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: theme.colorScheme.onPrimary,
                        onPressed: () {
                          Navigator.push(
                              context,
                              SwipeBackPageRoute(
                                  builder: (context) =>
                                      const UniversalScannerScreen(
                                          intent: CameraIntent.dictionary)));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ..._buildLibrarySlivers(
              context: context,
              ref: ref,
              isDark: isDark,
              l10n: l10n,
              searchQuery: _searchQuery,
              asyncFlashcards: asyncFlashcards,
              asyncDecks: asyncDecks,
              masterResults: masterResults,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'dictionary_add_fab',
        backgroundColor: Colors.purple,
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: Text(l10n?.generate ?? AppLocalizations.of(context)!.generate,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () => AiDeckGeneratorSheet.show(context),
      ),
    );
  }

  List<Widget> _buildLibrarySlivers({
    required BuildContext context,
    required WidgetRef ref,
    required bool isDark,
    required AppLocalizations? l10n,
    required String searchQuery,
    required AsyncValue<List<Flashcard>> asyncFlashcards,
    required AsyncValue<List<Deck>> asyncDecks,
    required List<Flashcard> masterResults,
  }) {
    return asyncFlashcards.when(
      data: (flashcards) {
        final libraryMap = {for (var card in flashcards) card.hanzi: card};

        // 1. Map master results, replacing with library versions if they exist to keep streak data
        final List<Flashcard> unifiedResults = masterResults.map((masterCard) {
          return libraryMap[masterCard.hanzi] ?? masterCard;
        }).toList();

        // 2. Find local-only cards that match the query but weren't in masterResults (e.g. custom user cards)
        final unifiedHanziSet = unifiedResults.map((c) => c.hanzi).toSet();
        final localOnlyMatches = flashcards.where((card) {
          if (unifiedHanziSet.contains(card.hanzi)) return false;
          final query = searchQuery.toLowerCase();
          final cleanPinyin =
              PinyinUtils.removeToneMarks(card.pinyin).toLowerCase();
          return card.hanzi.contains(query) ||
              cleanPinyin.contains(query) ||
              card.pinyin.toLowerCase().contains(query) ||
              card.definition.toLowerCase().contains(query);
        }).toList();

        unifiedResults.addAll(localOnlyMatches);

        if (searchQuery.isEmpty) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        l10n?.latestDiscoveries ?? "Latest Discoveries",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 140,
                      child: flashcards.isEmpty
                          ? Center(
                              child: Text(l10n?.noCharactersInLexicon ??
                                  "No characters in lexicon"))
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              scrollDirection: Axis.horizontal,
                              itemCount: flashcards.length > 10
                                  ? 10
                                  : flashcards.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                final card =
                                    flashcards[flashcards.length - 1 - index];
                                return _LexiconMiniCard(card: card);
                              },
                            ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              SwipeBackPageRoute(
                                  builder: (context) =>
                                      const RadicalLibraryScreen()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1A1A1B), Color(0xFF3A3A3C)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1A1A1B)
                                    .withValues(alpha: 0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text('氵',
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        l10n?.radicalsIndex ?? "Radicals Index",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(
                                        l10n?.masterBuildingBlocks ??
                                            "Master the building blocks",
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 13)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: BouncingButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              SwipeBackPageRoute(
                                  builder: (context) =>
                                      const hanzi_tome.TomeManagerScreen()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.download_for_offline_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 28),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .hskCollections,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text("Download official HSK collections",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withValues(alpha: 0.8),
                                            fontSize: 13)),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        l10n?.yourBookshelf ?? "Your Bookshelf",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            asyncDecks.when(
              data: (decks) => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final deck = decks[index];
                      final deckCardsCount =
                          flashcards.where((c) => c.deckId == deck.id).length;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: StaggeredListItem(
                          index: index,
                          child: _BookshelfVerticalCard(
                              deck: deck, cardCount: deckCardsCount),
                        ),
                      );
                    },
                    childCount: decks.length,
                  ),
                ),
              ),
              loading: () => const SliverToBoxAdapter(
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator()))),
              error: (e, s) => SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.library_books_outlined,
                            size: 48, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                            "We ran into trouble loading the library. Please try again.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            ref.invalidate(deckControllerProvider);
                            ref.invalidate(flashcardControllerProvider);
                          },
                          icon: const Icon(Icons.refresh, size: 16),
                          label: Text(AppLocalizations.of(context)!.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ];
        }

        if (unifiedResults.isEmpty) {
          return [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                  child: Text(
                      AppLocalizations.of(context)!
                          .no_results_found_for(_searchController.text),
                      style: const TextStyle(color: Colors.grey))),
            ),
          ];
        }

        // Group results by their primary definition (first English word/phrase)
        final grouped = <String, List<dynamic>>{};
        for (final card in unifiedResults) {
          final def = DefinitionFormatter.cleanRaw(card.definition, ref);
          final key = _extractDefinitionGroupKey(def);
          grouped.putIfAbsent(key, () => []).add(card);
        }

        // Build grouped items
        final items = <Widget>[];
        for (final entry in grouped.entries) {
          final cards = entry.value;
          final groupLabel = entry.key;

          if (cards.length >= 2) {
            // Group header with AppLocalizations.of(context)!.compare button
            items.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        groupLabel,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        HapticsManager.light();
                        final words = cards
                            .map<Map<String, String>>((c) => {
                                  'hanzi': c.hanzi as String,
                                  'pinyin': c.pinyin as String,
                                  'definition': DefinitionFormatter.cleanRaw(
                                      c.definition, ref),
                                })
                            .toList();
                        NuanceCompareSheet.show(
                          context,
                          words: words,
                          groupLabel: groupLabel,
                        );
                      },
                      icon: const Icon(Icons.compare_arrows, size: 16),
                      label: Text(AppLocalizations.of(context)!.compare),
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Card items
          for (final card in cards) {
            final isInLibrary = libraryMap.containsKey(card.hanzi);
            items.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: _DictionaryItem(card: card, isInLibrary: isInLibrary),
              ),
            );
          }
        }

        return [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => StaggeredListItem(
                  index: index,
                  child: items[index],
                ),
                childCount: items.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ];
      },
      loading: () => [
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: CircularProgressIndicator(color: Colors.brown),
          ),
        ),
      ],
      error: (err, stack) => [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text("Unable to load this section. Please try again.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () =>
                        ref.invalidate(flashcardControllerProvider),
                    icon: const Icon(Icons.refresh, size: 16),
                    label: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LexiconMiniCard extends ConsumerStatefulWidget {
  final Flashcard card;

  const _LexiconMiniCard({required this.card});

  @override
  ConsumerState<_LexiconMiniCard> createState() => _LexiconMiniCardState();
}

class _LexiconMiniCardState extends ConsumerState<_LexiconMiniCard> {
  late String _pinyin;
  late String _definition;

  @override
  void initState() {
    super.initState();
    _pinyin = widget.card.pinyin;
    _definition = widget.card.definition;
    _hydrateIfMissing();
  }

  Future<void> _hydrateIfMissing() async {
    if (_pinyin.trim().isEmpty || _definition.trim().isEmpty) {
      final repo = ref.read(globalDictionaryRepositoryProvider);
      final dictCard = await repo.getExact(widget.card.hanzi);
      if (dictCard != null && mounted) {
        setState(() {
          _pinyin = dictCard.pinyin;
          _definition = dictCard.definition;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BouncingButton(
      onPressed: () {
        HapticsManager.light();
        showQuickLook(context, widget.card.hanzi);
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.card.hanzi,
                style: theme.textTheme.displaySmall?.copyWith(height: 1.1),
              ),
            ),
            const SizedBox(height: 8),
            PinyinText(
              text: _pinyin,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            TranslatedDefinition(
              definition: _definition,
              hanzi: widget.card.hanzi,
              originalStyle: theme.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _BookshelfVerticalCard extends StatelessWidget {
  final Deck deck;
  final int cardCount;

  const _BookshelfVerticalCard({
    required this.deck,
    required this.cardCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDefault = deck.id == 'default';
    final Color deckColor =
        isDefault ? theme.colorScheme.primary : theme.colorScheme.secondary;

    return BouncingButton(
      onPressed: () {
        HapticsManager.light();
        Navigator.push(
          context,
          SwipeBackPageRoute(
              builder: (context) => DeckDetailScreen(deck: deck)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: deckColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDefault ? Icons.library_books : Icons.folder,
                color: deckColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deck.localizedName(context),
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$cardCount cards",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}

class _RadicalLibraryTab extends ConsumerStatefulWidget {
  final String searchQuery;
  const _RadicalLibraryTab({required this.searchQuery});

  @override
  ConsumerState<_RadicalLibraryTab> createState() => _RadicalLibraryTabState();
}

class _RadicalLibraryTabState extends ConsumerState<_RadicalLibraryTab> {
  Map<String, dynamic> _radicals = {};
  Map<String, dynamic> _hanziMeta = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final radString =
          await rootBundle.loadString('assets/data/radicals.json');
      final metaString =
          await rootBundle.loadString('assets/data/hanzi_metadata.json');

      if (mounted) {
        setState(() {
          _radicals = json.decode(radString)['radicals'];
          _hanziMeta = json.decode(metaString);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    final filteredRadicals = _radicals.entries.where((entry) {
      final query = widget.searchQuery.toLowerCase();
      final key = entry.key;
      final name = (entry.value['name'] as String).toLowerCase();
      final meaning = (entry.value['meaning'] as String).toLowerCase();

      return key.contains(query) ||
          name.contains(query) ||
          meaning.contains(query);
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredRadicals.length,
      itemBuilder: (context, index) {
        final entry = filteredRadicals[index];
        return _RadicalCard(
          radical: entry.key,
          info: entry.value,
          metaData: _hanziMeta,
        );
      },
    );
  }
}

class _RadicalCard extends ConsumerWidget {
  final String radical;
  final Map<String, dynamic> info;
  final Map<String, dynamic> metaData;

  const _RadicalCard(
      {required this.radical, required this.info, required this.metaData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BouncingButton(
      onPressed: () {
        HapticsManager.light();
        // 1. Create Sun Node
        final sunNode = CourseNode(uuid: 'rad_$radical', hanzi: radical);

        // 2. Find Children (Characters in library that use this radical)
        final allCards = ref.read(flashcardControllerProvider).value ?? [];
        final List<CourseNode> clusterNodes = [];

        // Add Sun first
        clusterNodes.add(sunNode);

        for (var card in allCards) {
          final meta = metaData[card.hanzi];
          if (meta != null &&
              meta['radical'] == radical &&
              card.hanzi != radical) {
            clusterNodes.add(CourseNode(
                uuid: card.id, hanzi: card.hanzi, parentUuid: sunNode.uuid));
          }
        }

        // 3. Open Detail Sheet
        showModalBottomSheet(
          context: context,
      useRootNavigator: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => RadicalDetailSheet(
            sunNode: sunNode,
            clusterNodes: clusterNodes,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.brown.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(radical,
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent)),
            const SizedBox(height: 8),
            TranslatedDefinition(
              definition: info['name'].toString(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              originalStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white70 : Colors.black87),
            ),
            TranslatedDefinition(
              definition: info['meaning'].toString(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              originalStyle: TextStyle(
                  fontSize: 10, color: isDark ? Colors.white30 : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Extracts a grouping key from a definition string.
/// Takes the first meaningful word/phrase (up to the first comma, semicolon, or slash)
/// and normalizes it for grouping similar definitions together.
String _extractDefinitionGroupKey(String definition) {
  if (definition.isEmpty) return 'Other';

  // Split on common definition separators
  final firstPart =
      definition.split(RegExp(r'[,;/]')).first.trim().toLowerCase();

  // Remove parenthetical notes like "(verb)" or "(adj)"
  final cleaned = firstPart.replaceAll(RegExp(r'\([^)]*\)'), '').trim();

  if (cleaned.isEmpty) return 'Other';

  // Capitalize first letter for display
  return cleaned[0].toUpperCase() + cleaned.substring(1);
}

class _DictionaryItem extends ConsumerStatefulWidget {
  final dynamic card;
  final bool isInLibrary;
  const _DictionaryItem({required this.card, this.isInLibrary = false});

  @override
  ConsumerState<_DictionaryItem> createState() => _DictionaryItemState();
}

class _DictionaryItemState extends ConsumerState<_DictionaryItem> {
  late String _pinyin;
  late String _definition;

  @override
  void initState() {
    super.initState();
    _pinyin = widget.card.pinyin;
    _definition = widget.card.definition;
    _hydrateIfMissing();
  }

  Future<void> _hydrateIfMissing() async {
    if (_pinyin.trim().isEmpty || _definition.trim().isEmpty) {
      final repo = ref.read(globalDictionaryRepositoryProvider);
      final dictCard = await repo.getExact(widget.card.hanzi);
      if (dictCard != null && mounted) {
        setState(() {
          _pinyin = dictCard.pinyin;
          _definition = dictCard.definition;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If it's not in the library, it has no real mastery progress yet.
    final double masteryProgress = widget.isInLibrary
        ? (widget.card.getStatsForMode(StudyMode.reading).streak / 5.0)
            .clamp(0.0, 1.0)
        : 0.0;
    final bool isMastered =
        widget.isInLibrary ? widget.card.isMastered(StudyMode.reading) : false;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BouncingButton(
      onPressed: () {
        HapticsManager.light();
        showQuickLook(context, widget.card.hanzi);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.03)
              : Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isDark ? Colors.white12 : Colors.black12, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Hanzi
            SizedBox(
              width: 80,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.card.hanzi,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.9)
                        : const Color(0xFF2C2C2C),
                    height: 1.1,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Middle: Pinyin & Definition
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PinyinText(
                    text: _pinyin,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark
                          ? Colors.indigo.shade300
                          : Colors.indigo.shade700,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TranslatedDefinition(
                    definition: _definition,
                    hanzi: widget.card.hanzi,
                    originalStyle: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Right: Mastery Seal
            if (widget.isInLibrary) ...[
              const SizedBox(width: 12),
              MasterySeal(
                progress: masteryProgress,
                isMastered: isMastered,
                size: 36,
              ),
            ] else ...[
              // Placeholder for alignment if needed, or just blank
              const SizedBox(width: 48),
            ],
          ],
        ),
      ),
    );
  }
}
