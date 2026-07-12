import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/echo_hall/presentation/screens/scenario_selection_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_library_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';

import 'package:hanzi_master/features/media/presentation/screens/media_hub_screen.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';



import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/profile_screen.dart';

import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/features/premium/presentation/screens/paywall_sheet.dart';

class AiHubScreen extends ConsumerWidget {
  const AiHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: CalligraphyBackground(
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              // Custom Header replacing GlobalSliverAppBar
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                                        Text(
                      l10n?.aiHubTitle ?? "AI Hub",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Serif',
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: 0.5,
                        fontSize: 28,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            SwipeBackPageRoute(
                              builder: (_) => const ProfileScreen(),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_outline,
                              color: isDark ? Colors.white : Colors.black87,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Hero Carousel: Featured AI Tools
              const SizedBox(
                height: 380,
                child: _FeaturedCarousel(),
              ),

              const SizedBox(height: 32),

              // Square Tiles List of Features
              Row(
                children: [
                  Expanded(
                    child: _buildListActionCard(
                      context: context,
                      title: "Reading Room",
                      subtitle: "Classic literature",
                      icon: Icons.auto_stories,
                      gradientColors: const [Color(0xFF8B5E3C), Color(0xFFC4863A)],
                      onTap: () {
                        HapticsManager.medium();
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            SwipeBackPageRoute(builder: (_) => const StoryLibraryScreen()),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildListActionCard(
                      context: context,
                      title: "Shadowing",
                      subtitle: "Perfect pronunciation",
                      icon: Icons.mic,
                      gradientColors: const [Color(0xFF1A4A4A), Color(0xFF2A7070)],
                      onTap: () {
                        HapticsManager.medium();
                        Navigator.push(
                          context,
                          SwipeBackPageRoute(builder: (_) => const ShadowingStudioScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    bool isNew = false,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // NEW badge
            if (isNew)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE27C5A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(icon, size: 36, color: Colors.white.withValues(alpha: 0.9)),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
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
    String? imageAsset,
    bool isNew = false,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  if (isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE27C5A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "NEW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
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
}

class _FeaturedCarousel extends StatefulWidget {
  const _FeaturedCarousel();

  @override
  State<_FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<_FeaturedCarousel> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        if (nextPage > 1) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
              // Reset timer when user manually swipes
              _startAutoScroll();
            },
            physics: const BouncingScrollPhysics(),
            children: [
              // Card 1: Roleplay Scenarios
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _CarouselCard(
                  title: "Roleplay Scenarios",
                  subtitle: "Immersive roleplay with AI avatars",
                  category: "AI-Powered Conversations",
                  imageAsset: 'assets/images/ai_hub_ink_mountains.png',
                  icon: Icons.auto_awesome,
                  onTap: () {
                    HapticsManager.medium();
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        SwipeBackPageRoute(
                            builder: (_) => const ScenarioSelectionScreen()),
                      );
                    }
                  },
                ),
              ),
              // Card 2: Web Explorer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _CarouselCard(
                  title: "Read The Web",
                  subtitle: "Turn any webpage into a learning experience",
                  category: "Web Explorer",
                  imageAsset: 'assets/images/user_web_explorer.png',
                  icon: Icons.language,
                  overlayColor: Colors.black38,
                  onTap: () {
                    HapticsManager.medium();
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        SwipeBackPageRoute(builder: (_) => const MediaHubScreen()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 6.0,
              width: _currentPage == index ? 24.0 : 6.0,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87)
                    : (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white24
                        : Colors.black26),
                borderRadius: BorderRadius.circular(3.0),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String category;
  final String imageAsset;
  final IconData icon;
  final VoidCallback onTap;
  final Color overlayColor;

  const _CarouselCard({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.imageAsset,
    required this.icon,
    required this.onTap,
    this.overlayColor = Colors.black26,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF131A29),
          image: DecorationImage(
            image: imageAsset.startsWith('http') 
                ? NetworkImage(imageAsset) as ImageProvider
                : AssetImage(imageAsset),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(overlayColor, BlendMode.srcOver),
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF131A29).withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                category,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
