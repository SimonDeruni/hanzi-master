import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/notification_permission_screen.dart';
import 'package:hanzi_master/features/premium/presentation/screens/paywall_sheet.dart';
import 'package:hanzi_master/features/auth/presentation/screens/auth_screen.dart';
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
  
  bool _calibrationComplete = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 5) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuart,
      );
      if (_currentPage + 1 == 5) {
        _startCalibration();
      }
    } else {
      _completeOnboarding();
    }
  }

  void _startCalibration() async {
    setState(() {
      _calibrationComplete = false;
    });
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _calibrationComplete = true;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuart,
      );
    }
  }

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    await prefs.setInt('user_mastery_level', _selectedMastery);
    await prefs.setInt('user_drive', _selectedDrive);
    await prefs.setInt('user_ritual', _selectedRitual);
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => NotificationPermissionScreen(
            onComplete: () async {
              final success = await PaywallSheet.show(context, isHardPaywall: !kDebugMode);
              if (mounted && (success || kDebugMode)) {
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
            },
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0), // Warm Xuan Paper background
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            if (_currentPage < 5)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 20),
                        onPressed: _previousPage,
                      )
                    else
                      const SizedBox(width: 48), // Placeholder to keep center alignment
                    
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // Total of 5 steps (Welcome -> DidYouKnow -> Mastery -> Drive -> Ritual). Calibration is step 6.
                            double progress = (_currentPage + 1) / 5.0;
                            if (progress > 1.0) progress = 1.0;
                            
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOutQuart,
                                height: 4,
                                width: constraints.maxWidth * progress,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            
            // Main Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Force buttons to navigate
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildWelcomePage(),
                  _buildDidYouKnowPage(),
                  _buildMasteryPage(),
                  _buildDrivePage(),
                  _buildRitualPage(),
                  _buildCalibrationPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hanzi\nMaster",
                          style: TextStyle(
                            color: Color(0xFF1A1A1B),
                            fontSize: 48,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Serif',
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "AI-POWERED WISDOM",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Text(
                          "汉\n字\n大\n师",
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 40,
                          color: Colors.red[900],
                          margin: const EdgeInsets.only(top: 8),
                        )
                      ],
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: -0.2),
                  ],
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1),
                
                const SizedBox(height: 64),
                
                // Mascot Image
                Image.asset(
                  'assets/icon/icon.png',
                  height: 180,
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                 .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOut),
              ],
            ),
          ),
          
          Column(
            children: [
              _buildPrimaryButton("Start Journey", _nextPage),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: BouncingButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthScreen()),
                    );
                  },
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1A1A1B),
                      side: const BorderSide(color: Color(0xFF1A1A1B), width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: null, // Let BouncingButton handle it
                    child: const Text(
                      "Log In / Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 1000.ms),
        ],
      ),
    );
  }

  Widget _buildDidYouKnowPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 2, color: Colors.red[700]),
              const SizedBox(width: 12),
              Text(
                "DID YOU KNOW?",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ).animate().fadeIn().slideX(),
          
          const SizedBox(height: 24),
          
          const Text(
            "Characters are not just letters; they are concepts.",
            style: TextStyle(
              color: Color(0xFF1A1A1B),
              fontSize: 32,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn(delay: 200.ms).slideX(),
          
          const SizedBox(height: 48),
          
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.05), Colors.black.withOpacity(0.02)],
              ),
            ),
            child: const Center(
              child: Text(
                "明",
                style: TextStyle(
                  fontSize: 100,
                  fontFamily: 'Serif',
                  color: Colors.black54,
                  height: 1.0,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).scale(),
          
          const SizedBox(height: 32),
          
          Row(
            children: [
              Expanded(
                child: _buildInfoCard("5,000+", "Years of continuous written history."),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard("Only", "Living logographic writing system."),
              ),
            ],
          ).animate().fadeIn(delay: 600.ms).slideY(),
          
          const SizedBox(height: 32),
          
          Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.red[700]!, width: 2)),
            ),
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text(
              "\"Chinese characters are the only living logographic system, where a single stroke can carry centuries of meaning.\"",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ).animate().fadeIn(delay: 800.ms),
          
          const Spacer(),
          _buildPrimaryButton("Continue", _nextPage).animate().fadeIn(delay: 1000.ms),
        ],
      ),
    );
  }

  Widget _buildMasteryPage() {
    final options = [
      {"title": "Beginner", "subtitle": "Starting from zero (0-500 words)", "icon": Icons.eco_outlined},
      {"title": "Elementary", "subtitle": "Basic communication (HSK 1-2)", "icon": Icons.spa_outlined},
      {"title": "Intermediate", "subtitle": "Fluent reading (HSK 3-4)", "icon": Icons.park_outlined},
      {"title": "Advanced", "subtitle": "Professional mastery (HSK 5-6)", "icon": Icons.landscape_outlined},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What is your current mastery?",
            style: TextStyle(
              color: Color(0xFF1A1A1B),
              fontSize: 32,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          
          const SizedBox(height: 8),
          
          const Text(
            "Choose the path that fits your depth.",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ).animate().fadeIn(delay: 200.ms),
          
          const SizedBox(height: 32),
          
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: options.length,
              separatorBuilder: (c, i) => const SizedBox(height: 16),
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
          ),
          
          _buildPrimaryButton(
            "Confirm Selection",
            _selectedMastery != -1 ? _nextPage : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDrivePage() {
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
          const Text(
            "What drives your study?",
            style: TextStyle(
              color: Color(0xFF1A1A1B),
              fontSize: 32,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          
          const SizedBox(height: 8),
          
          const Text(
            "Purpose fuels the brush's motion.",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ).animate().fadeIn(delay: 200.ms),
          
          const SizedBox(height: 32),
          
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
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
          ),
          
          _buildPrimaryButton(
            "Next",
            _selectedDrive != -1 ? _nextPage : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRitualPage() {
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
          const Text(
            "Set your daily ritual.",
            style: TextStyle(
              color: Color(0xFF1A1A1B),
              fontSize: 32,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          
          const SizedBox(height: 8),
          
          const Text(
            "\"Consistency is the ink that builds the character.\"",
            style: TextStyle(color: Colors.black54, fontSize: 16, fontStyle: FontStyle.italic),
          ).animate().fadeIn(delay: 200.ms),
          
          const SizedBox(height: 32),
          
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: options.length,
              separatorBuilder: (c, i) => const SizedBox(height: 16),
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
          ),
          
          Column(
            children: [
              Icon(Icons.hourglass_empty, color: Colors.red[700]),
              const SizedBox(height: 8),
              const Text(
                "You can adjust your ritual any time.",
                style: TextStyle(color: Colors.black38, fontSize: 12),
              ),
              const SizedBox(height: 24),
              _buildPrimaryButton(
                "Build My Path",
                _selectedRitual != -1 ? _nextPage : null,
              ),
            ],
          ).animate().fadeIn(delay: 800.ms),
        ],
      ),
    );
  }

  Widget _buildCalibrationPage() {
    String masteryText = "Beginner";
    if (_selectedMastery == 1) masteryText = "Elementary";
    if (_selectedMastery == 2) masteryText = "Intermediate";
    if (_selectedMastery == 3) masteryText = "Advanced";

    String driveText = "Business Focus";
    if (_selectedDrive == 1) driveText = "Travel Focus";
    if (_selectedDrive == 2) driveText = "HSK Focus";
    if (_selectedDrive == 3) driveText = "Culture Focus";

    String ritualText = "05 Minutes";
    if (_selectedRitual == 1) ritualText = "10 Minutes";
    if (_selectedRitual == 2) ritualText = "20 Minutes";
    if (_selectedRitual == 3) ritualText = "30 Minutes";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _calibrationComplete ? "Curriculum Forged" : "Forging Your Path",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1A1A1B),
              fontSize: 32,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          
          const SizedBox(height: 8),
          
          Text(
            _calibrationComplete ? "YOUR JOURNEY AWAITS" : "CALIBRATING AI MASTERS...",
            style: const TextStyle(
              color: Colors.black54, 
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(delay: 200.ms),
          
          const Spacer(),
          
          if (!_calibrationComplete)
            Image.asset(
              'assets/icon/icon.png',
              height: 140,
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOut),
             
          if (_calibrationComplete)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.red[700], size: 32),
                  const SizedBox(height: 16),
                  Text(
                    "With $ritualText a day starting from a $masteryText level, building a strong foundation for $driveText will take patience and consistency. Our AI will guide you every step of the way.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(),
          
          const Spacer(),
          
          if (!_calibrationComplete) ...[
            _buildSummaryRow("Current Level", masteryText).animate().fadeIn(delay: 400.ms),
            const Divider(color: Colors.black12, height: 32),
            _buildSummaryRow("Primary Goal", driveText).animate().fadeIn(delay: 600.ms),
            const Divider(color: Colors.black12, height: 32),
            _buildSummaryRow("Daily Ritual", ritualText).animate().fadeIn(delay: 800.ms),
            const Divider(color: Colors.black12, height: 32),
            
            const SizedBox(height: 48),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ALIGNING CURRICULUM",
                      style: TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _calibrationComplete ? "100%" : "0%",
                      style: const TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(2)),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      curve: Curves.easeOutQuart,
                      height: 4,
                      width: _calibrationComplete ? MediaQuery.of(context).size.width - 64 : 0,
                      decoration: BoxDecoration(color: Colors.red[700], borderRadius: BorderRadius.circular(2)),
                    ),
                  ],
                ),
              ],
            ).animate().fadeIn(delay: 1000.ms),
          ],
          
          const SizedBox(height: 32),
          
          if (_calibrationComplete)
            _buildPrimaryButton(
              "Start 7-Day Free Trial",
              _nextPage,
            ).animate().fadeIn(duration: 500.ms).slideY(),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(color: Color(0xFF1A1A1B), fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildRitualCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A1A1B) : Colors.black.withOpacity(0.05),
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
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
                color: isSelected ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B),
                fontSize: 24,
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                subtitle,
                style: TextStyle(
                  color: isSelected ? const Color(0xFFFDFCF0) : Colors.black54,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_outline, color: Color(0xFFFDFCF0)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
            style: const TextStyle(
              color: Colors.black87,
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.red[700]! : Colors.black.withOpacity(0.05),
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
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
                    style: const TextStyle(
                      color: Color(0xFF1A1A1B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: isSelected ? Colors.red[700] : Colors.black38,
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.red[700]! : Colors.black.withOpacity(0.05),
            width: 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
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
              color: isSelected ? Colors.red[700] : Colors.black38,
              size: 32,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF1A1A1B),
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
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: BouncingButton(
        onPressed: onPressed,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A1A1B),
            foregroundColor: const Color(0xFFFDFCF0),
            disabledBackgroundColor: const Color(0xFF1A1A1B).withOpacity(0.3),
            disabledForegroundColor: const Color(0xFFFDFCF0).withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          onPressed: null, // Let BouncingButton handle it
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
