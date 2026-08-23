import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/notification_permission_screen.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedMastery = -1;
  int _selectedDrive = -1;
  int _selectedRitual = -1;

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: 400.ms, 
        curve: Curves.easeInOutQuart,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NotificationPermissionScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _buildWelcomePage(),
                  _buildMasteryPage(),
                  _buildDrivePage(),
                  _buildRitualPage(),
                ],
              ),
            ),
            _buildProgressIndicator(),
            const SizedBox(height: 12),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: 300.ms,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: isActive ? 24 : 6,
          decoration: BoxDecoration(
            color: isActive 
                ? Colors.red[700] 
                : isDark ? Colors.white24 : Colors.black12,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  Widget _buildWelcomePage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/icon/icon.png',
            height: 160,
          ).animate().scale(duration: 400.ms).fadeIn(),
          const SizedBox(height: 48),
          Text(
            "Your Path to\nChinese Fluency",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: 36,
              fontFamily: 'Serif',
              height: 1.3,
            ),
          ).animate().fadeIn(delay: 300.ms).slideY(),
          const SizedBox(height: 24),
          Text(
            "Answer 3 quick questions so our AI can craft\na curriculum that fits your life.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 16,
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 600.ms),
          const Spacer(),
          _buildPrimaryButton("Let's Begin", _nextPage),
        ],
      ),
    );
  }

  Widget _buildMasteryPage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final options = [
      {"title": "Brand New", "subtitle": "I've never studied Chinese before.", "icon": Icons.child_care_outlined},
      {"title": "Elementary", "subtitle": "I know basic characters and phrases.", "icon": Icons.auto_stories_outlined},
      {"title": "Intermediate", "subtitle": "I can hold conversations and read.", "icon": Icons.school_outlined},
      {"title": "Advanced", "subtitle": "I want to refine and perfect my skills.", "icon": Icons.psychology_outlined},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            "What is your level\nwith Chinese?",
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: 32,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          
          const SizedBox(height: 8),
          
          Text(
            "Choose the path that fits your depth.",
            style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 16),
          ).animate().fadeIn(delay: 200.ms),
          
          const SizedBox(height: 24),
          
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              bool isSelected = _selectedMastery == index;
              return _buildSelectionCard(
                title: options[index]["title"] as String,
                subtitle: options[index]["subtitle"] as String,
                icon: options[index]["icon"] as IconData,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedMastery = index;
                  });
                },
              ).animate().fadeIn(delay: Duration(milliseconds: 300 + (100 * index))).slideX();
            },
          ),
          
          const Spacer(),
          
          _buildPrimaryButton(
            "Confirm Selection",
            _selectedMastery != -1 ? _nextPage : null,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDrivePage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final options = [
      {"title": "Business &\nCareer", "icon": Icons.work_outline},
      {"title": "Travel &\nSurvival", "icon": Icons.location_on_outlined},
      {"title": "HSK\nCertification", "icon": Icons.workspace_premium_outlined},
      {"title": "Cultural\nAppreciation", "icon": Icons.palette_outlined},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            "What drives your study?",
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: 32,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          
          const SizedBox(height: 8),
          
          Text(
            "Purpose fuels the brush's motion.",
            style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 16),
          ).animate().fadeIn(delay: 200.ms),
          
          const SizedBox(height: 24),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.95,
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              bool isSelected = _selectedDrive == index;
              return _buildGridSelectionCard(
                title: options[index]["title"] as String,
                icon: options[index]["icon"] as IconData,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedDrive = index;
                  });
                },
              ).animate().fadeIn(delay: Duration(milliseconds: 300 + (100 * index))).scale();
            },
          ),
          
          const Spacer(),
          
          _buildPrimaryButton(
            "Next",
            _selectedDrive != -1 ? _nextPage : null,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildRitualPage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final options = [
      {"title": "05", "subtitle": "Minutes / Day"},
      {"title": "10", "subtitle": "Minutes / Day"},
      {"title": "20", "subtitle": "Minutes / Day"},
      {"title": "30", "subtitle": "Minutes / Day"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            "Set your daily ritual.",
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: 32,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          
          const SizedBox(height: 8),
          
          Text(
            "\"Consistency is the ink that builds the character.\"",
            style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 16, fontStyle: FontStyle.italic),
          ).animate().fadeIn(delay: 200.ms),
          
          const SizedBox(height: 24),
          
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              bool isSelected = _selectedRitual == index;
              return _buildRitualCard(
                title: options[index]["title"] as String,
                subtitle: options[index]["subtitle"] as String,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedRitual = index;
                  });
                },
              ).animate().fadeIn(delay: Duration(milliseconds: 300 + (100 * index))).slideX();
            },
          ),
          
          const Spacer(),
          
          Column(
            children: [
              Icon(Icons.hourglass_empty, color: Colors.red[700]),
              const SizedBox(height: 8),
              Text(
                "You can adjust your ritual any time.",
                style: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 12),
              ),
              const SizedBox(height: 16),
              _buildPrimaryButton(
                "Build My Path",
                _selectedRitual != -1 ? _nextPage : null,
              ),
            ],
          ).animate().fadeIn(delay: 800.ms),
          const SizedBox(height: 12),
        ],
      ),
    );
  }



  Widget _buildRitualCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final selectedBg = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final selectedText = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : (isDark ? const Color(0xFF2A2A2B) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? selectedBg : (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? selectedText : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                fontSize: 24,
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                subtitle,
                style: TextStyle(
                  color: isSelected ? selectedText : (isDark ? Colors.white54 : Colors.black54),
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_outline, color: selectedText),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.red[700],
              fontSize: 24,
              fontFamily: 'Serif',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedBg = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final selectedText = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : (isDark ? const Color(0xFF2A2A2B) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? selectedBg : (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? selectedText : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isSelected ? selectedText : (isDark ? Colors.white54 : Colors.black54),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: isSelected ? selectedText : (isDark ? Colors.white38 : Colors.black38),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridSelectionCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedBg = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final selectedText = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : (isDark ? const Color(0xFF2A2A2B) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? selectedBg : (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? selectedText : (isDark ? Colors.white38 : Colors.black38),
              size: 32,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? selectedText : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback? onPressed) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = onPressed == null;
    
    final activeBgColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final activeTextColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: BouncingButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: isDisabled ? activeBgColor.withValues(alpha: 0.3) : activeBgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isDisabled ? activeTextColor.withValues(alpha: 0.5) : activeTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}