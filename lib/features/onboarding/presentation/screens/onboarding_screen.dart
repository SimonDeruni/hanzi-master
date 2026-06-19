import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/bouncing_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Master Chinese with Zen & Ink",
      "description": "Welcome to Hanzi Master. The ultimate tool to master Chinese language learning.",
      "image": "assets/images/onboarding/slide_1.png",
    },
    {
      "title": "The Scholar's Library",
      "description": "Curate your vocabulary and track spaced repetition effectively.",
      "image": "assets/images/onboarding/slide_2.png",
    },
    {
      "title": "Live Translate",
      "description": "Real-time AI translation for any scenario, breaking down language barriers instantly.",
      "image": "assets/images/onboarding/slide_3.png",
    },
    {
      "title": "AI Personas",
      "description": "Immersive, real-time conversations with specialized AI characters.",
      "image": "assets/images/onboarding/slide_4.png",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool('has_seen_onboarding', true);
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainNavigationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top Action Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_currentPage < _onboardingData.length - 1)
                      TextButton(
                        onPressed: _completeOnboarding,
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ).animate().fadeIn(duration: 400.ms),
                  ],
                ),
              ),

              // PageView content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return _buildPage(context, _onboardingData[index], index);
                  },
                ),
              ),

              // Bottom navigation and indicator
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    // Dot Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: _currentPage == index ? 24.0 : 8.0,
                          decoration: BoxDecoration(
                            color: _currentPage == index 
                                ? theme.colorScheme.primary 
                                : theme.colorScheme.onSurface.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Main Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: BouncingButton(
                        onPressed: () {
                          if (_currentPage == _onboardingData.length - 1) {
                            _completeOnboarding();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutQuart,
                            );
                          }
                        },
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          onPressed: null, // BouncingButton handles tap
                          child: Text(
                            _currentPage == _onboardingData.length - 1 ? "Get Started" : "Next",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ).animate(target: _currentPage == _onboardingData.length - 1 ? 1 : 0).shimmer(duration: 1200.ms, delay: 400.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, Map<String, String> data, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image Placeholder Container
          Expanded(
            flex: 5,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300, maxHeight: 450),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    data["image"]!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image_not_supported, size: 64, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
                            const SizedBox(height: 16),
                            Text(
                              "Screenshot Placeholder\n(${data["image"]})",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack).fadeIn(),
            ),
          ),
          
          const SizedBox(height: 48),
          
          // Text Content
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  data["title"]!,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 500.ms, curve: Curves.easeOutCubic).fadeIn(),
                
                const SizedBox(height: 16),
                
                Text(
                  data["description"]!,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().slideY(begin: 0.2, end: 0, delay: 500.ms, duration: 500.ms, curve: Curves.easeOutCubic).fadeIn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
