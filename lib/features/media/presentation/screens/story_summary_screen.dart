import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../domain/models/library_story.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../reading/presentation/providers/story_controller.dart';
import '../../../reading/presentation/screens/story_reader_screen.dart';
import '../widgets/story_cover_art.dart';
import 'web_browser_screen.dart';
import '../../../../shared/widgets/tappable_hanzi_text.dart';
import '../../../../shared/widgets/quick_look_sheet.dart';
import '../../../../shared/widgets/zen_loader.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/utils/hero_transition.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// The first screen of a story.
///
/// Laid out like the book screen ([BookDetailScreen]): a portrait cover card,
/// the title, a badge row, one primary action, then cards for the summary and
/// the keywords — so opening a Mandarin Bean story and opening a classical book
/// feel like the same product.
///
/// The cover is the story's own artwork, resolved by [StoryCoverArt]:
/// `imageUrl` when the feed provides one, otherwise the Mandarin Bean cover that
/// ships in `assets/images/mandarin_bean/` (134 of the 150 bundled stories have
/// one, named after the article slug). The generic ink-wash mountains that every
/// story used to show are gone.
class StorySummaryScreen extends ConsumerStatefulWidget {
  final LibraryStory story;

  const StorySummaryScreen({super.key, required this.story});

  @override
  ConsumerState<StorySummaryScreen> createState() => _StorySummaryScreenState();
}

class _StorySummaryScreenState extends ConsumerState<StorySummaryScreen> {
  late StoryBlueprint _blueprint;
  String? _enrichedSummary;
  bool _isEnriching = false;

  List<String> get _placeholders => [
        AppLocalizations.of(context)!.aClassicTangDynastyPoem,
        AppLocalizations.of(context)!.aClassicTangDynastyPoemBy,
        '经典唐诗',
      ];

  bool _isPlaceholder(String text) {
    return _placeholders.any((p) => text.startsWith(p)) || text.length < 60;
  }

  /// Mandarin Bean articles are bundled with the app, so they read offline.
  bool get _isBundledArticle =>
      widget.story.link.contains('mandarinbean.com') ||
      widget.story.link.startsWith('local_');

  @override
  void initState() {
    super.initState();
    _blueprint = StoryBlueprint(
      id: widget.story.link,
      title: widget.story.title,
      topic: widget.story.title,
      category: widget.story.category,
      // The cover the reader will also open on, so the artwork travels with it.
      imageUrl: widget.story.imageUrl ??
          StoryCoverArt.bundledCoverAsset(widget.story.link) ??
          '',
      tags: [widget.story.category],
    );

    // Start loading the story immediately to fetch vocabulary
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StoryController controller =
          ref.read(storyControllerProvider.notifier);
      if (widget.story.link.startsWith('custom_')) {
        controller.loadOrGenerateStory(_blueprint, widget.story.hskLevel);
      } else if (widget.story.link.startsWith('tang_poetry_') ||
          _isBundledArticle) {
        // `fetchAndParseLocalStory` is the path that knows how to read the
        // bundled JSON by link — Mandarin Bean articles used to be sent to the
        // Firestore path, which is why their key words never loaded.
        controller.fetchAndParseLocalStory(_blueprint, widget.story.hskLevel);
      } else {
        controller.fetchAndParseFirebaseStory(
            _blueprint, widget.story.hskLevel);
      }
    });
  }

  /// Guards the one-shot summary enrichment in [didChangeDependencies].
  bool _enrichmentConsidered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_enrichmentConsidered) return;
    _enrichmentConsidered = true;

    // Enrich placeholder summaries with AI-generated content.
    //
    // Deliberately NOT in `initState`: `_isPlaceholder` reads the localizations,
    // and `AppLocalizations.of(context)` in `initState` trips
    // "dependOnInheritedWidgetOfExactType … called before initState completed"
    // in every debug build. `didChangeDependencies` runs once the inherited
    // widgets are available, and the flag keeps it to a single pass.
    // Prefer the localized summary (read from
    // `assets/data/l10n/mandarin_bean_stories_<locale>.json`) and fall back to
    // the English the story data itself carries.
    final summaryText = widget.story.summary.isNotEmpty
        ? widget.story.summary
        : (widget.story.summaryEn ?? '');
    if (_isPlaceholder(summaryText) &&
        widget.story.link.startsWith('tang_poetry_')) {
      _enrichSummary();
    }
  }

  Future<void> _enrichSummary() async {
    final localeCode = Localizations.localeOf(context).toLanguageTag();
    setState(() => _isEnriching = true);
    try {
      // Load the Tang poetry JSON to get the full poem text
      final jsonString =
          await rootBundle.loadString('assets/data/tang_poetry_en.json');
      final data = json.decode(jsonString) as List<dynamic>;
      final entry = data.firstWhere(
        (d) => (d['link'] ?? 'tang_poetry_${d['title']}') == widget.story.link,
        orElse: () => null,
      );
      if (entry == null) return;

      final rawText = entry['rawText'] as String? ?? '';
      if (rawText.isEmpty) return;

      final gemini = ref.read(geminiServiceProvider);
      final result = await gemini.generateDetailedSummary(
        widget.story.localizedTitle(
          localeCode,
        ),
        rawText,
        gemini.targetLanguage,
      );
      if (result.isNotEmpty && mounted) {
        setState(() => _enrichedSummary = result);
      }
    } catch (e) {
      debugPrint('Error enriching summary: $e');
    } finally {
      if (mounted) setState(() => _isEnriching = false);
    }
  }

  void _startReading() {
    Navigator.push(
      context,
      SwipeBackPageRoute(
        builder: (context) => StoryReaderScreen(
          blueprint: _blueprint,
          hskLevel: widget.story.hskLevel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final storyState = ref.watch(storyControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localeCode = Localizations.localeOf(context).toLanguageTag();

    // The book screen's ground, ink wells and accent — one reading vocabulary.
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final mutedText = isDark ? Colors.white60 : const Color(0xFF6B655B);
    final accent = isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);
    final gold = isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);

    final String localizedTitle = widget.story.localizedTitle(localeCode);
    final bool isRemote = widget.story.link.startsWith('http');

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // 1. The story's own cover — the Mandarin Bean artwork the app
                  //    ships for it — composed as a portrait card, exactly as the
                  //    catalogue draws a book. The source is named once, in the
                  //    badge row below, so the cover stays clean.
                  ZenFadeIn(
                    child: Center(
                      // Receives the daily-story card's flight from the library
                      // (`HeroTransition.heroTag('story_library', link)`).
                      child: HeroTransition.wrap(
                        context: context,
                        tag: HeroTransition.heroTag(
                            'story_library', widget.story.link),
                        child: StoryCoverArt(
                          story: widget.story,
                          showSourceBadge: false,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
// 2. Title, with the original line beneath it when the two
                  //    differ (a Tang poem keeps its Hanzi title).
                  TappableHanziText(
                    localizedTitle,
                    textAlign: TextAlign.center,
                    quickLookPresentation: QuickLookPresentation.readingPopover,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryText,
                      letterSpacing: 1.0,
                    ),
                  ),
                  if (widget.story.titleEn != null &&
                      widget.story.title != localizedTitle) ...<Widget>[
                    const SizedBox(height: 6),
                    TappableHanziText(
                      widget.story.title,
                      textAlign: TextAlign.center,
                      quickLookPresentation:
                          QuickLookPresentation.readingPopover,
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: mutedText,
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
// 3. Badges: reading level, subject, source. The subject badge
                  //    borrows the cover's own hue, so the two agree.
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: <Widget>[
                      if (widget.story.hskLevel > 0)
                        _buildBadge('HSK ${widget.story.hskLevel}', accent)
                      else
                        _buildBadge(l10n.native, accent),
                      _buildBadge(
                        widget.story.category,
                        StoryCoverArt.topicGradient(widget.story.category)
                            .first,
                      ),
                      if (widget.story.sourceName.isNotEmpty)
                        _buildBadge(widget.story.sourceName, gold),
                    ],
                  ),
                  const SizedBox(height: 20),
// 4. One primary action, in the book screen's button style:
                  //    carbon ink in light mode, Emperor's gold in dark. A
                  //    minimum height, not a fixed one, so a 2x text scale fits.
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 52),
                    child: ElevatedButton.icon(
                      onPressed: isRemote
                          ? () {
                              Navigator.push(
                                context,
                                SwipeBackPageRoute(
                                  builder: (_) => WebBrowserScreen(
                                    initialUrl: widget.story.link,
                                    autoReadingMode: true,
                                    isStoryMode: true,
                                  ),
                                ),
                              );
                            }
                          : _startReading,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.amber.shade700
                            : const Color(0xFF1A1A1B),
                        foregroundColor:
                            isDark ? const Color(0xFF1A1A1B) : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(
                        isRemote
                            ? Icons.open_in_new_rounded
                            : Icons.menu_book_rounded,
                        size: 20,
                      ),
                      label: Text(
                        isRemote ? l10n.openOriginalWebsite : l10n.startReading,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
// 5. Summary ink well.
                  _buildCard(
                    isDark: isDark,
                    cardBg: cardBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                l10n.summary,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryText,
                                ),
                              ),
                            ),
                            if (_isEnriching) ...<Widget>[
                              const SizedBox(width: 12),
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: ZenLoader(strokeWidth: 2),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 12),
                        TappableHanziText(
                          _enrichedSummary ??
                              (widget.story.summary.isNotEmpty
                                  ? widget.story.summary
                                  : (widget.story.summaryEn ?? '')),
                          quickLookPresentation:
                              QuickLookPresentation.readingPopover,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.75)
                                : const Color(0xFF1A1A1B)
                                    .withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
// 6. Key words ink well.
                  _buildCard(
                    isDark: isDark,
                    cardBg: cardBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.keyWords,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryText,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildKeyWords(storyState),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Book-screen vocabulary (same shapes as `book_detail_screen.dart`) ──────
  Widget _buildCard({
    required bool isDark,
    required Color cardBg,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildKeyWords(StoryState storyState) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (storyState.isLoading && storyState.currentStory == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ZenLoader(
            color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
          ),
        ),
      );
    }

    if (storyState.currentStory == null) {
      return Text(
        AppLocalizations.of(context)!.couldNotLoadVocabulary,
        style:
            TextStyle(color: isDark ? Colors.white60 : const Color(0xFF6B655B)),
      );
    }

    // Extract vocabulary from sentences and deduplicate
    final Set<String> seenHanzi = {};
    final vocabList =
        storyState.currentStory!.sentences.expand((s) => s.words).where((word) {
      // Filter out punctuation and non-Chinese characters
      if (!RegExp(r'[\u4e00-\u9fa5]').hasMatch(word.hanzi)) return false;

      if (seenHanzi.contains(word.hanzi)) return false;
      seenHanzi.add(word.hanzi);
      return true;
    }).toList();

    if (vocabList.isEmpty) {
      return Text(
        AppLocalizations.of(context)!.noKeyWordsFoundForThisStory,
        style:
            TextStyle(color: isDark ? Colors.white60 : const Color(0xFF6B655B)),
      );
    }

    // Sort to prioritize multi-character words (idioms, names, compounds) over single characters
    vocabList.sort((a, b) {
      if (a.hanzi.length != b.hanzi.length) {
        return b.hanzi.length.compareTo(a.hanzi.length);
      }
      return 0;
    });

    // Take up to 8 keywords for the preview
    final previewVocab = vocabList.take(8).toList();

    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: previewVocab.map((word) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            // The same ink well as the cards around them.
            color: isDark ? const Color(0xFF1E1E22) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37))
                  .withValues(alpha: 0.28),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TappableHanziText(
                word.hanzi,
                quickLookPresentation: QuickLookPresentation.readingPopover,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                word.pinyin,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : const Color(0xFF6B655B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                word.meaning,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white38 : const Color(0xFF8A857C),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
