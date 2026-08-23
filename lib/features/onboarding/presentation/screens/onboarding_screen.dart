import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  double _calibrationProgress = 0.0;
  bool _calibrationComplete = false;

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: 400.ms, 
        curve: Curves.easeInOutQuart,
      );
    } else {
      _startCalibration();
    }
  }

  void _startCalibration() {
    setState(() {
      _currentPage = 4;
      _calibrationProgress = 0.0;
      _calibrationComplete = false;
      _pageController.animateToPage(
        4, 
        duration: 400.ms, 
        curve: Curves.easeInOutQuart,
      );
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _calibrationProgress = 0.35);
      HapticFeedback.lightImpact();
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() => _calibrationProgress = 0.70);
      HapticFeedback.lightImpact();
    });

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      setState(() => _calibrationProgress = 1.0);
      HapticFeedback.mediumImpact();
    });

    Future.delayed(const Duration(milliseconds: 2300), () {
      if (!mounted) return;
      setState(() => _calibrationComplete = true);
      HapticFeedback.heavyImpact();
    });
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
                  _buildCalibrationPage(),
                ],
              ),
            ),
            if (_currentPage < 4) ...[
              _buildProgressIndicator(),
              const SizedBox(height: 12),
            ],
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

  Widget _buildCalibrationPage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    String masteryText = "Brand New";
    if (_selectedMastery == 1) masteryText = "Elementary";
    if (_selectedMastery == 2) masteryText = "Intermediate";
    if (_selectedMastery == 3) masteryText = "Advanced";

    String driveText = "Business & Career";
    if (_selectedDrive == 1) driveText = "Travel & Survival";
    if (_selectedDrive == 2) driveText = "HSK Certification";
    if (_selectedDrive == 3) driveText = "Cultural Appreciation";

    String ritualText = "05 Min / Day";
    if (_selectedRitual == 1) ritualText = "10 Min / Day";
    if (_selectedRitual == 2) ritualText = "20 Min / Day";
    if (_selectedRitual == 3) ritualText = "30 Min / Day";

    final percentInt = (_calibrationProgress * 100).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            _calibrationComplete ? "Your Plan is Ready" : "Crafting Your Curriculum",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: 28,
              fontFamily: 'Serif',
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ).animate().fadeIn(),
          
          const SizedBox(height: 8),
          
          Text(
            _calibrationComplete 
                ? "PERSONALIZED PATH INITIALIZED" 
                : "CALIBRATING AI NEURAL MASTERS...",
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.black54, 
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 24),

          // Live Progress Bar & Percentage
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05)),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _calibrationComplete ? "Calibration Complete" : "Synthesizing Modules...",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black87,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "$percentInt%",
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _calibrationProgress,
                    minHeight: 8,
                    backgroundColor: isDark ? Colors.white12 : Colors.black12,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red[700]!),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Interactive Checklist of Milestones
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCalibrationStep(
                  icon: Icons.person_outline,
                  title: "Mastery Level",
                  value: masteryText,
                  isDone: _calibrationProgress >= 0.35,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                _buildCalibrationStep(
                  icon: Icons.flag_outlined,
                  title: "Target Objective",
                  value: driveText,
                  isDone: _calibrationProgress >= 0.70,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                _buildCalibrationStep(
                  icon: Icons.access_time,
                  title: "Daily Practice",
                  value: ritualText,
                  isDone: _calibrationProgress >= 0.99,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                _buildCalibrationStep(
                  icon: Icons.auto_awesome,
                  title: "AI Spaced Repetition",
                  value: "Dynamic Decks & Stroke Analysis",
                  isDone: _calibrationComplete,
                  isDark: isDark,
                ),
              ],
            ),
          ),

          if (_calibrationComplete) ...[
            _buildPrimaryButton(
              "View My Personalized Plan",
              _completeOnboarding,
            ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95)),
            const SizedBox(height: 12),
          ] else ...[
            const SizedBox(height: 68),
          ],
        ],
      ),
    );
  }

  Widget _buildCalibrationStep({
    required IconData icon,
    required String title,
    required String value,
    required bool isDone,
    required bool isDark,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDone 
            ? (isDark ? const Color(0xFF2A2A2B) : Colors.white)
            : (isDark ? const Color(0xFF222223) : const Color(0xFFF5F4E8)),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDone 
              ? (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08))
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon, 
            color: isDone ? Colors.red[700] : (isDark ? Colors.white24 : Colors.black26), 
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: isDone 
                        ? (isDark ? Colors.white : const Color(0xFF1A1A1B))
                        : (isDark ? Colors.white38 : Colors.black38),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isDone
                ? Icon(Icons.check_circle, color: Colors.green[600], size: 20, key: const ValueKey("done"))
                : SizedBox(
                    width: 16,
                    height: 16,
                    key: const ValueKey("loading"),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: isDark ? Colors.white24 : Colors.black26,
                    ),
                  ),
          ),
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