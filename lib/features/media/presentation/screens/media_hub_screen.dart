import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_search_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
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
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Carousel: Video & News of the day
            const SliverToBoxAdapter(
              child: _DailyDiscoveryCarousel(),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Core Tools Side-by-Side
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildSquareActionCard(
                        context: context,
                        title: "YOUTUBE DESK",
                        subtitle: "Interactive transcripts",
                        icon: Icons.smart_display,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const MediaSearchScreen()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSquareActionCard(
                        context: context,
                        title: "WEB EXPLORER",
                        subtitle: "Live dictionary overlay",
                        icon: Icons.language,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const WebBrowserScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Quick Bookmarks Section Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(
                  "Quick Bookmarks",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Grid of Bookmarks
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.05,
                children: [
                  _buildGridCard(
                    context: context,
                    title: "BBC Zhongwen",
                    subtitle: "World News",
                    icon: Icons.article,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WebBrowserScreen(initialUrl: 'https://www.bbc.com/zhongwen/simp'),
                        ),
                      );
                    },
                  ),
                  _buildGridCard(
                    context: context,
                    title: "Wikipedia",
                    subtitle: "Current Events",
                    icon: Icons.travel_explore,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WebBrowserScreen(initialUrl: 'https://zh.wikipedia.org/wiki/Portal:%E6%96%B0%E9%97%BB%E5%8A%A8%E6%80%81'),
                        ),
                      );
                    },
                  ),
                  _buildGridCard(
                    context: context,
                    title: "Global Voices",
                    subtitle: "Independent Media",
                    icon: Icons.public,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WebBrowserScreen(initialUrl: 'https://zh.globalvoices.org/'),
                        ),
                      );
                    },
                  ),
                  _buildGridCard(
                    context: context,
                    title: "Baidu",
                    subtitle: "Search Engine",
                    icon: Icons.search,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WebBrowserScreen(initialUrl: 'https://www.baidu.com'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Saved Articles Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
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
                valueListenable: Hive.box<SavedArticle>('saved_articles').listenable(),
                builder: (context, box, _) {
                  if (box.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Text("No saved articles yet.", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.bookmark, color: theme.colorScheme.primary),
                          ),
                          title: Text(article.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(article.url, maxLines: 1, overflow: TextOverflow.ellipsis),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                onPressed: () => box.deleteAt(index),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WebBrowserScreen(initialUrl: article.url),
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

  Widget _buildSquareActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return BouncingButton(
      scaleFactor: 0.97,
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'NotoSerifSC',
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  height: 1.2,
                  fontSize: 11,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.02)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon, 
                    color: theme.colorScheme.primary,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios, 
                  size: 14, 
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyDiscoveryCarousel extends StatefulWidget {
  const _DailyDiscoveryCarousel();

  @override
  State<_DailyDiscoveryCarousel> createState() => _DailyDiscoveryCarouselState();
}

class _DailyDiscoveryCarouselState extends State<_DailyDiscoveryCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildDiscoveryCard(
            context,
            tag: "VIDEO OF THE DAY",
            title: "CCTV-4 International Live",
            subtitle: "Chinese National Television",
            imageAsset: 'assets/images/reading_room_bg.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WebBrowserScreen(initialUrl: 'https://www.youtube.com/watch?v=kYc5F3D172M'),
                ),
              );
            },
          ),
          _buildDiscoveryCard(
            context,
            tag: "ARTICLE OF THE DAY",
            title: "BBC 中文网 (World News)",
            subtitle: "Current Events in Simplified Chinese",
            imageAsset: 'assets/images/shadowing_bg.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WebBrowserScreen(initialUrl: 'https://www.bbc.com/zhongwen/simp'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryCard(
    BuildContext context, {
    required String tag,
    required String title,
    required String subtitle,
    required String imageAsset,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                title,
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
                  Icon(Icons.play_circle_fill, color: Colors.white.withValues(alpha: 0.8), size: 16),
                  const SizedBox(width: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
