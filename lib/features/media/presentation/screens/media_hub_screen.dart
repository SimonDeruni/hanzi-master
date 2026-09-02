import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/presentation/providers/daily_discovery_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_search_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/cultural_context_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hanzi_master/features/media/domain/models/saved_article.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/core/config/app_features.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class MediaHubScreen extends ConsumerWidget {
  final bool showBackButton;

  const MediaHubScreen({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CalligraphyBackground(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. WEB EXPLORER - Prominent Hero Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: _buildWebExplorerHeroCard(context),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // 2. Quick Bookmarks
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.quickBookmarks,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Horizontal List of Bookmarks
            SliverToBoxAdapter(
              child: SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildBookmarkChip(
                      context: context,
                      title: AppLocalizations.of(context)!.bbc,
                      icon: Icons.article,
                      brandColor: const Color(0xFFBB1919),
                      url: 'https://www.bbc.com/zhongwen/simp',
                    ),
                    _buildBookmarkChip(
                      context: context,
                      title: AppLocalizations.of(context)!.wikipedia,
                      icon: Icons.travel_explore,
                      brandColor: const Color(0xFF555555),
                      url:
                          'https://zh.wikipedia.org/zh-cn/Portal:%E6%96%B0%E9%97%BB%E5%8A%A8%E6%80%81',
                    ),
                    _buildBookmarkChip(
                      context: context,
                      title: "Baidu",
                      icon: Icons.search,
                      brandColor: const Color(0xFF2932E1),
                      url: 'https://www.baidu.com',
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // 3. Daily Discovery Carousel (Article of the Day)
            const SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverToBoxAdapter(
                child: _DailyDiscoveryCarousel(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Additional Core Tools
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    if (AppFeatures.youtubeMedia) ...[
                      _buildThematicCard(
                        context: context,
                        title: AppLocalizations.of(context)?.youtubeDesk ??
                            "YOUTUBE DESK",
                        subtitle: AppLocalizations.of(context)
                                ?.interactiveTranscriptsShadowing ??
                            "Interactive transcripts & shadowing",
                        icon: Icons.smart_display,
                        brandColor: const Color(0xFFFF0000),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MediaSearchScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Saved Articles Section
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.savedArticles,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ValueListenableBuilder<Box<SavedArticle>>(
                valueListenable:
                    Hive.box<SavedArticle>('saved_articles').listenable(),
                builder: (context, box, _) {
                  if (box.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16.0),
                      child: Text(
                          AppLocalizations.of(context)!.noSavedArticlesYet,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey)),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final article = box.getAt(index);
                      if (article == null) return const SizedBox.shrink();

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.bookmark,
                                color: theme.colorScheme.primary),
                          ),
                          title: Text(article.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(article.url,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.redAccent),
                                onPressed: () => box.deleteAt(index),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    WebBrowserScreen(initialUrl: article.url),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildWebExplorerHeroCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BouncingButton(
      scaleFactor: 0.98,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WebBrowserScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [Color(0xFF26262B), Color(0xFF141416)]
                : const [Color(0xFF24252A), Color(0xFF16171A)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color:
                const Color(0xFFFFD54F).withValues(alpha: isDark ? 0.22 : 0.28),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.25),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Subtle background calligraphic Hanzi watermark
              const Positioned(
                right: -12,
                bottom: -28,
                child: Opacity(
                  opacity: 0.06,
                  child: Text(
                    'ç½‘',
                    style: TextStyle(
                      fontSize: 160,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSerifSC',
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ),

              // Ambient Gold Glow
              Positioned(
                top: -40,
                right: -20,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFFB300).withValues(alpha: 0.18),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Content Layout
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top Row: Icon Badge & Live Overlay Pill
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFFFB300).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFFB300)
                                  .withValues(alpha: 0.35),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.language_rounded,
                            color: Color(0xFFFFD54F),
                            size: 22,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFFFB300).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFFFB300)
                                  .withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.auto_awesome,
                                  color: Color(0xFFFFD54F), size: 12),
                              SizedBox(width: 5),
                              Text(
                                "LIVE OVERLAY",
                                style: TextStyle(
                                  color: Color(0xFFFFE082),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Headline & source
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text(
                          'WEB EXPLORER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'ç½‘é¡µæŽ¢ç´¢',
                          style: TextStyle(
                            color:
                                const Color(0xFFFFD54F).withValues(alpha: 0.8),
                            fontSize: 14,
                            fontFamily: 'NotoSerifSC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Browse any Chinese website with real-time tap dictionary, pinyin annotations & instant translations.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.78),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Refined CTA Button
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFFFB300).withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFFB300)
                                  .withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'START EXPLORING',
                                style: TextStyle(
                                  color: Color(0xFFFFE082),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Color(0xFFFFE082),
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThematicCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color brandColor,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return BouncingButton(
      scaleFactor: 0.98,
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: brandColor.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Colored accent bar on the left
            Container(
              width: 6,
              height: 100,
              decoration: BoxDecoration(
                color: brandColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: brandColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: brandColor, size: 28),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontFamily: 'NotoSerifSC',
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        size: 16,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkChip({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color brandColor,
    required String url,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: BouncingButton(
        scaleFactor: 0.95,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WebBrowserScreen(initialUrl: url),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                color: isDark
                    ? Colors.white12
                    : Colors.black.withValues(alpha: 0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: brandColor, size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyDiscoveryCarousel extends ConsumerStatefulWidget {
  const _DailyDiscoveryCarousel();

  @override
  ConsumerState<_DailyDiscoveryCarousel> createState() =>
      _DailyDiscoveryCarouselState();
}

class _DailyDiscoveryCarouselState
    extends ConsumerState<_DailyDiscoveryCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dailyState = ref.watch(dailyDiscoveryProvider);
    final completedItems = ref.watch(completedDailyMediaProvider);

    return SizedBox(
      height: 240,
      child: dailyState.when(
        data: (items) {
          final visibleItems = AppFeatures.youtubeMedia
              ? items
              : items.where((i) => i.tag != 'VIDEO OF THE DAY').toList();
          return PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: visibleItems.length,
            itemBuilder: (context, index) {
              final item = visibleItems[index];
              final isCompleted = completedItems.contains(item.url);
              return _buildDiscoveryCard(
                context,
                item: item,
                isCompleted: isCompleted,
                onTap: () {
                  ref
                      .read(completedDailyMediaProvider.notifier)
                      .markCompleted(item.url);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CulturalContextScreen(mediaItem: item),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(AppLocalizations.of(context)!.failedToLoadDailyContent),
        ),
      ),
    );
  }

  Widget _buildDiscoveryCard(
    BuildContext context, {
    required DailyMediaItem item,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.black87,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (item.imageUrl.isNotEmpty)
                Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return _buildCardPlaceholder(item);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return _buildCardPlaceholder(item);
                  },
                )
              else
                _buildCardPlaceholder(item),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.25),
                        Colors.black.withValues(alpha: 0.75),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isCompleted ? "âœ“ COMPLETED" : item.tag,
                        style: TextStyle(
                          color:
                              isCompleted ? Colors.greenAccent : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.tag == 'VIDEO OF THE DAY'
                          ? item.subtitle
                          : item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                            item.tag == "VIDEO OF THE DAY"
                                ? Icons.play_circle_fill
                                : Icons.article,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(
                              item.tag == 'VIDEO OF THE DAY'
                                  ? item.title
                                  : item.subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardPlaceholder(DailyMediaItem item) {
    // Elegant warm dark slate gradient with soft icon backdrop matching Zen & Ink aesthetic
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E3440),
            Color(0xFF1E222A),
            Color(0xFF181A20),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Subtle decorative background icon
          Opacity(
            opacity: 0.12,
            child: Icon(
              item.tag.contains('VIDEO')
                  ? Icons.ondemand_video_rounded
                  : Icons.auto_stories_rounded,
              size: 110,
              color: Colors.white,
            ),
          ),
          // Center watermark badge
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1.5,
              ),
            ),
            child: Icon(
              item.tag.contains('VIDEO')
                  ? Icons.play_arrow_rounded
                  : Icons.article_rounded,
              color: Colors.white.withValues(alpha: 0.8),
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
