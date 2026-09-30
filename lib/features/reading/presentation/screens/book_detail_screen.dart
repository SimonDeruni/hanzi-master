import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/audiobook_player_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/shared/utils/hero_transition.dart';
import 'package:hanzi_master/shared/widgets/staggered_list_item.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';
import 'package:hanzi_master/core/services/bundled_author_biography_service.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

String _localizedBookCategory(AppLocalizations l10n, String category) {
  switch (category) {
    case 'Chinese Epics':
      return l10n.chineseEpics;
    case 'Ancient Philosophy':
      return l10n.ancientPhilosophy;
    case 'Supernatural & Folklore':
      return l10n.supernaturalAndFolklore;
    case 'Modern Chinese':
      return l10n.modernChinese;
    case 'French Classics':
      return l10n.frenchClassics;
    case 'German Classics':
      return l10n.germanClassics;
    case 'Spanish & World':
      return l10n.spanishAndWorld;
    case 'English & World':
      return l10n.englishAndWorld;
    default:
      return category;
  }
}

String _localizedBookEra(AppLocalizations l10n, String era) {
  switch (era) {
    case 'American Literature':
      return l10n.americanLiterature;
    case 'Ancient China':
      return l10n.ancientChina;
    case 'British Literature':
      return l10n.britishLiterature;
    case 'French Literature':
      return l10n.frenchLiterature;
    case 'German Literature':
      return l10n.germanLiterature;
    case 'Italian Literature':
      return l10n.italianLiterature;
    case 'Jin Dynasty':
      return l10n.jinDynasty;
    case 'Ming Dynasty':
      return l10n.mingDynasty;
    case 'Pre-Qin':
      return l10n.preQinEra;
    case 'Qing Dynasty':
      return l10n.qingDynasty;
    case 'Republic of China':
      return l10n.republicOfChinaEra;
    case 'Russian Literature':
      return l10n.russianLiterature;
    case 'Spanish Literature':
      return l10n.spanishLiterature;
    case 'Spring & Autumn':
      return l10n.springAndAutumn;
    case 'Warring States':
      return l10n.warringStates;
    case 'Western Han':
      return l10n.westernHan;
    default:
      return era;
  }
}

// ─── Screen ─────────────────────────────────────────────────────────────────

class BookDetailScreen extends ConsumerStatefulWidget {
  final BookModel book;

  /// True when this screen is the trailing pane of the catalogue on an iPad
  /// (≥840dp): it is then not a pushed route, so it must render **no** back
  /// button — that button would pop the catalogue itself.
  /// See `docs/IPAD_ADAPTIVE_PLAN.md`, Phase 2.
  final bool embedded;

  /// How the reader dismisses the pane. Only meaningful with [embedded], which
  /// is exactly the case where this screen **cannot** pop itself (it owns no
  /// route), so its host must supply the way out.
  ///
  /// Without it the pane had no dismissal of any kind — no back button, no
  /// close target, no tap-outside — because the catalogue only ever *set*
  /// `_previewBook`, never cleared it. Reported 2026-09-29: "No way to close
  /// the right Thing".
  final VoidCallback? onClose;

  const BookDetailScreen({
    super.key,
    required this.book,
    this.embedded = false,
    this.onClose,
  });

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  String? _loadedLocale;
  Future<AuthorBiography?>? _biography;
  Future<String>? _synopsis;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadLocalizedDetailsIfNeeded();
  }

  @override
  void didUpdateWidget(covariant BookDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.book.id != widget.book.id ||
        oldWidget.book.author != widget.book.author) {
      _loadedLocale = null;
      _loadLocalizedDetailsIfNeeded();
    }
  }

  void _loadLocalizedDetailsIfNeeded() {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_loadedLocale == locale && _biography != null && _synopsis != null) {
      return;
    }
    _loadedLocale = locale;
    _biography = BundledAuthorBiographyService.instance.biographyFor(
      author: widget.book.author,
      localeCode: locale,
    );
    _synopsis = LocalizedCatalogService.getBookSynopsis(
      bookId: widget.book.id,
      localeCode: locale,
      // The book's own description is already in the reader's language where the
      // content ships localized (a poet's collection carries the poet's
      // translated biography there) — English is the last resort, not the first.
      fallback: widget.book.description,
      fallbackEn: widget.book.descriptionEn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).toLanguageTag();
    final localizedCategory = _localizedBookCategory(l10n, book.category);
    final localizedEra = _localizedBookEra(l10n, book.dynastyOrEra);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final accentColor =
        isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);

    final downloadState = ref.watch(bookDownloadProvider(book.id));
    final isDownloaded = downloadState.status == BookDownloadStatus.downloaded;
    final chaptersAsync = isDownloaded
        ? ref.watch(bookChaptersProvider(book.id))
        : const AsyncValue<List<BookChapter>>.data([]);
    final currentProgress = ref.watch(bookProgressProvider(book.id));

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        // The embedded pane has no route to pop, so its trailing corner is the
        // only place a dismissal can live. On a phone the leading back arrow
        // already is one, and the corner stays empty.
        actions: widget.embedded && widget.onClose != null
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.close, size: 22, color: primaryText),
                  // `MaterialLocalizations` already carries this string in all
                  // 14 shipped locales, so the affordance is labelled without
                  // adding an ARB key.
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: widget.onClose,
                ),
                const SizedBox(width: 4),
              ]
            : null,
        leading: widget.embedded
            ? null
            : IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    size: 20, color: primaryText),
                onPressed: () => Navigator.of(context).pop(),
              ),
      ),
      body: chaptersAsync.when(
        data: (chapters) {
          return ZenFadeIn(
              child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Book Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Calligraphic Book Cover (shared element with the catalog).
                      //
                      // Disabled while embedded: the catalogue's grid card for
                      // this very book is on screen at the same time and carries
                      // the same tag, so the cell and the pane put two `Hero`s
                      // with one tag inside the catalog route — which Flutter
                      // rejects the moment any page route is pushed from it
                      // (every micro-read and poem card, `book_reader_screen`'s
                      // bookmark sheet). There is no flight to make here anyway:
                      // the pane *is* the destination.
                      HeroTransition.wrap(
                        context: context,
                        tag: HeroTransition.heroTag('book_catalog', book.id),
                        enabled: !widget.embedded,
                        child: CalligraphicBookCover(
                          book: book,
                          width: 135,
                          height: 190,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.localizedTitle(localeCode),
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Tags Row
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          if (!book.category.contains('Poetry'))
                            _buildBadge(
                                l10n.audiobookIncluded,
                                isDark
                                    ? Colors.amber.shade400
                                    : const Color(0xFF8B0000)),
                          _buildBadge(
                              localizedCategory,
                              isDark
                                  ? Colors.blue.shade300
                                  : Colors.indigo.shade700),
                          _buildBadge(
                              localizedEra,
                              isDark
                                  ? Colors.green.shade300
                                  : Colors.teal.shade700),
                          _buildBadge(
                            book.category.contains('Poetry')
                                ? l10n.poemCount(chapters.length)
                                : l10n.chapters(book.totalChapters),
                            isDark
                                ? Colors.purple.shade300
                                : Colors.deepPurple.shade700,
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Action Button (Start / Continue Reading)
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: downloadState.status ==
                                      BookDownloadStatus.downloading ||
                                  downloadState.status ==
                                      BookDownloadStatus.checking
                              ? null
                              : () async {
                                  HapticsManager.heavy();
                                  if (!isDownloaded) {
                                    await ref
                                        .read(bookDownloadProvider(book.id)
                                            .notifier)
                                        .download();
                                    if (ref
                                            .read(bookDownloadProvider(book.id))
                                            .status ==
                                        BookDownloadStatus.downloaded) {
                                      ref.invalidate(
                                          bookChaptersProvider(book.id));
                                    }
                                    return;
                                  }
                                  final detailedProg = ref.read(
                                      bookDetailedProgressProvider(book.id));
                                  final initialIndex = (detailedProg != null
                                          ? detailedProg.chapterIndex - 1
                                          : currentProgress - 1)
                                      .clamp(0, chapters.length - 1);
                                  final initialSentenceIndex =
                                      detailedProg?.sentenceIndex ?? 0;
                                  Navigator.of(context).push(
                                    SwipeBackPageRoute(
                                      builder: (_) => BookReaderScreen(
                                        book: book,
                                        chapters: chapters,
                                        initialChapterIndex: initialIndex,
                                        initialSentenceIndex:
                                            initialSentenceIndex,
                                      ),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? Colors.amber.shade700
                                : const Color(0xFF1A1A1B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                downloadState.status ==
                                        BookDownloadStatus.checking
                                    ? Icons.hourglass_top_rounded
                                    : downloadState.status ==
                                            BookDownloadStatus.downloading
                                        ? Icons.downloading_rounded
                                        : !isDownloaded
                                            ? Icons.download_rounded
                                            : currentProgress > 1
                                                ? Icons.auto_stories
                                                : Icons.play_arrow_rounded,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              // The app's primary CTA, and its label is
                              // localized into all 13 languages. Without the
                              // `Flexible` this `Row` overflowed by 30dp on a
                              // 390dp phone — found by
                              // `book_catalog_preview_pane_test.dart`, the
                              // first test ever to render this screen.
                              Flexible(
                                child: Text(
                                  downloadState.status ==
                                          BookDownloadStatus.checking
                                      ? l10n.checkingDownload
                                      : downloadState.status ==
                                              BookDownloadStatus.downloading
                                          ? l10n.downloadingBook(
                                              (downloadState.progress * 100)
                                                  .round(),
                                            )
                                          : !isDownloaded
                                              ? (downloadState.status ==
                                                      BookDownloadStatus.error
                                                  ? l10n.retryDownload
                                                  : l10n.downloadBook)
                                              : currentProgress > 1
                                                  ? (book.category
                                                          .contains('Poetry')
                                                      ? l10n.continueReading
                                                      : l10n.continueChapter(
                                                          currentProgress))
                                                  : (book.category
                                                          .contains('Poetry')
                                                      ? l10n.readPoem
                                                      : l10n.startReading),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (downloadState.status ==
                          BookDownloadStatus.downloading) ...[
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: downloadState.progress > 0
                              ? downloadState.progress
                              : null,
                          color: accentColor,
                        ),
                      ],
                      if (downloadState.status == BookDownloadStatus.error) ...[
                        const SizedBox(height: 8),
                        Text(
                          l10n.downloadBookError,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ],
                      if (isDownloaded &&
                          !book.category.contains('Poetry')) ...[
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () async {
                            final shouldRemove = await showDialog<bool>(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)!
                                        .removeDownloadQuestion),
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .removeDownloadContent,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext, false),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .cancelAction),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext, true),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .removeDownloadAction),
                                      ),
                                    ],
                                  ),
                                ) ??
                                false;
                            if (!shouldRemove) return;
                            await ref
                                .read(bookDownloadProvider(book.id).notifier)
                                .remove();
                            ref.invalidate(bookChaptersProvider(book.id));
                          },
                          icon: const Icon(Icons.delete_outline),
                          label: Text(AppLocalizations.of(context)!
                              .removeDownloadButton),
                        ),
                      ],

                      if (chapters.isNotEmpty &&
                          !book.category.contains('Poetry')) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          // No fixed height: the localized label may wrap to a
                          // second line in German/Russian/Thai, so the button
                          // grows to fit instead of clipping.
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              HapticsManager.medium();
                              final detailedProg = ref
                                  .read(bookDetailedProgressProvider(book.id));
                              final initialChapterIndex = (detailedProg != null
                                      ? detailedProg.chapterIndex - 1
                                      : currentProgress - 1)
                                  .clamp(0, chapters.length - 1);
                              final initialSentenceIndex =
                                  detailedProg?.sentenceIndex ?? 0;
                              Navigator.of(context).push(
                                SwipeBackPageRoute(
                                  builder: (_) => AudiobookPlayerScreen(
                                    book: book,
                                    chapters: chapters,
                                    initialChapterIndex: initialChapterIndex,
                                    initialSentenceIndex: initialSentenceIndex,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.headphones,
                                size: 20, color: accentColor),
                            label: Text(
                              l10n.listenToAudiobook,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: accentColor, width: 1.3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),

                      // ── Author Card ─────────────────────────────────────
                      _buildCard(
                        isDark: isDark,
                        cardBg: cardBg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Author header row
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: accentColor.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.person_outline,
                                      size: 22, color: accentColor),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.localizedAuthor(localeCode),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: primaryText,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${book.author}  ·  $localizedEra  ·  $localizedCategory',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            FutureBuilder<AuthorBiography?>(
                              future: _biography,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const _LocalizedTextPlaceholder();
                                }
                                final text = snapshot.data?.text;
                                if (text == null || text.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.55,
                                    color: isDark
                                        ? Colors.white70
                                        : const Color(0xFF2C2C2E),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Synopsis Card ───────────────────────────────────
                      _buildCard(
                        isDark: isDark,
                        cardBg: cardBg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section header
                            Row(
                              children: [
                                Icon(Icons.auto_stories,
                                    size: 20, color: accentColor),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.synopsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Localized synopsis (default visible)
                            FutureBuilder<String>(
                              future: _synopsis,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const _LocalizedTextPlaceholder(
                                    lines: 4,
                                  );
                                }
                                return Text(
                                  snapshot.data ?? book.description,
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    height: 1.6,
                                    color: isDark
                                        ? Colors.white70
                                        : const Color(0xFF1A1A1B),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Table of Contents Header
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${AppLocalizations.of(context)?.tableOfContents ?? "Table of Contents"} (${isDownloaded ? chapters.length : book.totalChapters})',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (!isDownloaded)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            l10n.downloadBookOffline(book.totalChapters),
                            style: TextStyle(
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Chapter List
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ch = chapters[index];
                      final isCurrent = ch.chapterIndex == currentProgress;
                      final isDarkLocal =
                          Theme.of(context).brightness == Brightness.dark;
                      final cardBgLocal =
                          isDarkLocal ? const Color(0xFF1E1E22) : Colors.white;
                      final primaryTextLocal =
                          isDarkLocal ? Colors.white : const Color(0xFF1A1A1B);

                      return StaggeredListItem(
                        index: index,
                        delay: const Duration(milliseconds: 30),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? (isDarkLocal
                                    ? Colors.amber.withValues(alpha: 0.15)
                                    : const Color(0xFFF2ECE1))
                                : cardBgLocal,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isCurrent
                                  ? (isDarkLocal
                                      ? Colors.amber.shade500
                                      : const Color(0xFF8B0000))
                                  : (isDarkLocal
                                      ? Colors.white10
                                      : Colors.black.withValues(alpha: 0.05)),
                              width: isCurrent ? 1.5 : 1.0,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              HapticsManager.medium();
                              Navigator.of(context).push(
                                SwipeBackPageRoute(
                                  builder: (_) => BookReaderScreen(
                                    book: book,
                                    chapters: chapters,
                                    initialChapterIndex: index,
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              radius: 16,
                              backgroundColor: isCurrent
                                  ? (isDarkLocal
                                      ? Colors.amber.shade700
                                      : const Color(0xFF8B0000))
                                  : (isDarkLocal
                                      ? Colors.white12
                                      : Colors.black12),
                              child: Text(
                                '${ch.chapterIndex}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isCurrent
                                      ? Colors.white
                                      : (isDarkLocal
                                          ? Colors.white70
                                          : Colors.black87),
                                ),
                              ),
                            ),
                            title: FutureBuilder<String>(
                              future: LocalizedCatalogService.getChapterTitle(
                                chapterId: ch.id,
                                titleEn: ch.titleEn,
                                localizedTitles: ch.localizedTitles,
                                localeCode: Localizations.localeOf(context)
                                    .languageCode,
                              ),
                              builder: (context, snap) => Text(
                                snap.data ?? ch.titleEn,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryTextLocal,
                                ),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                ch.title,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: isDarkLocal
                                      ? Colors.amber.shade300
                                      : const Color(0xFF8B0000),
                                  fontStyle: FontStyle.italic,
                                  height: 1.3,
                                ),
                              ),
                            ),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 14),
                          ),
                        ),
                      );
                    },
                    childCount: chapters.length,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ));
        },
        loading: () => const Center(child: ZenLoader()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }

  // ── Shared card container ──────────────────────────────────────────────────
  Widget _buildCard(
      {required bool isDark, required Color cardBg, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
            color:
                isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
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

  // ── Badge ──────────────────────────────────────────────────────────────────
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
        style:
            TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}

/// Holds the layout while a bundled locale is loading, rather than briefly
/// rendering English and replacing it a frame later.
class _LocalizedTextPlaceholder extends StatelessWidget {
  const _LocalizedTextPlaceholder({this.lines = 3});

  final int lines;

  @override
  Widget build(BuildContext context) {
    final color =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: .08);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        lines,
        (index) => Container(
          height: 10,
          width: index == lines - 1 ? 180 : double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
