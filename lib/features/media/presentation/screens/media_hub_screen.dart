import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/presentation/providers/daily_discovery_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/shared/widgets/info_bulb.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_search_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/cultural_context_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/show_catalog_screen.dart';
import 'package:hanzi_master/features/media/data/repositories/show_repository.dart';
import 'package:hanzi_master/features/media/presentation/screens/show_detail_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hanzi_master/features/media/domain/models/saved_article.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

class MediaHubScreen extends ConsumerWidget {
  const MediaHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CalligraphyBackground(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const GlobalSliverAppBar(
              title: "Media Hub",
              actions: [
                InfoBulb(
                    id: "media_hub",
                    title: "Media Hub",
                    message:
                        "Browse Chinese YouTube channels, music, and videos. Use media to immerse yourself in the language naturally.")
              ],
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Carousel: Video & News of the day
            const SliverSafeArea(
              bottom: false,
              sliver: SliverToBoxAdapter(
                child: _DailyDiscoveryCarousel(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Core Tools Layout
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    _buildThematicCard(
                      context: context,
                      title: "YOUTUBE DESK",
                      subtitle: "Interactive transcripts & shadowing",
                      icon: Icons.smart_display,
                      brandColor: const Color(0xFFFF0000), // YouTube Red
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MediaSearchScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildThematicCard(
                      context: context,
                      title: "WEB EXPLORER",
                      subtitle: "Live dictionary translation overlay",
                      icon: Icons.language,
                      brandColor: const Color(0xFF1E88E5), // Web Blue
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WebBrowserScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildThematicCard(
                      context: context,
                      title: "SHOWS & DRAMAS",
                      subtitle: "Chinese TV series with interactive subtitles",
                      icon: Icons.live_tv,
                      brandColor: const Color(0xFFFFA000),
                      onTap: () {
                        Navigator.push(
                          context,
                          SwipeBackPageRoute(
                            builder: (_) => const ShowCatalogScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Quick Bookmarks Section Title
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(
                  "Quick Bookmarks",
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
                      title: "BBC 中文",
                      icon: Icons.article,
                      brandColor: const Color(0xFFBB1919),
                      url: 'https://www.bbc.com/zhongwen/simp',
                    ),
                    _buildBookmarkChip(
                      context: context,
                      title: "Wikipedia",
                      icon: Icons.travel_explore,
                      brandColor: const Color(0xFF555555),
                      url:
                          'https://zh.wikipedia.org/wiki/Portal:%E6%96%B0%E9%97%BB%E5%8A%A8%E6%80%81',
                    ),
                    _buildBookmarkChip(
                      context: context,
                      title: "Global Voices",
                      icon: Icons.public,
                      brandColor: const Color(0xFFE65100),
                      url: 'https://zh.globalvoices.org/',
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

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Saved Articles Section
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(
                  "Saved Articles",
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
                      child: Text("No saved articles yet.",
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
    final showOfTheDay = ref.watch(dailyShowProvider);

    return SizedBox(
      height: 240,
      child: dailyState.when(
        data: (items) {
          // Calculate total page count: daily items + optional show of the day
          final showItem = showOfTheDay.valueOrNull;
          final totalItems = items.length + (showItem != null ? 1 : 0);

          return PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: totalItems,
            itemBuilder: (context, index) {
              // Show of the day is always the last page
              if (showItem != null && index == items.length) {
                return _buildDailyShowCard(context, showItem);
              }

              final item = items[index];
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
        loading: () {
          // Show show of the day even while daily items are loading
          final showItem = showOfTheDay.valueOrNull;
          if (showItem != null) {
            return _buildDailyShowCard(context, showItem);
          }
          return const Center(child: CircularProgressIndicator());
        },
        error: (err, stack) {
          // Show show of the day even when daily items fail
          final showItem = showOfTheDay.valueOrNull;
          if (showItem != null) {
            return _buildDailyShowCard(context, showItem);
          }
          return Center(child: Text('Failed to load daily content'));
        },
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
              Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                      color: theme.colorScheme.surfaceContainerHighest);
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Icon(Icons.broken_image,
                          color: theme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.5),
                          size: 40),
                    ),
                  );
                },
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.5)),
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
                        isCompleted ? "✓ COMPLETED" : item.tag,
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
                      item.title,
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
                            item.subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 13,
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

  Widget _buildDailyShowCard(BuildContext context, Show show) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SwipeBackPageRoute(
            builder: (_) => ShowDetailScreen(show: show),
          ),
        );
      },
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
              Image.network(
                show.thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                      color: theme.colorScheme.surfaceContainerHighest);
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Icon(Icons.broken_image,
                          color: theme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.5),
                          size: 40),
                    ),
                  );
                },
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.5)),
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
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '\u{1f3ac} SHOW OF THE DAY',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      show.title,
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
                        const Icon(Icons.live_tv,
                            color: Colors.white70, size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${show.episodeCount} episodes · ${show.channelTitle}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 13,
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
}
