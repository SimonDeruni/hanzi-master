import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_mini_lesson_screen.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/notification_permission_screen.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
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
  double _calibrationProgress = 0.0;
  bool _calibrationComplete = false;
  Timer? _calibrationTimer;
  Timer? _autoAdvanceTimer;

  void _nextPage() {
    HapticsManager.light();
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: 400.ms,
        curve: Curves.easeInOutQuart,
      );
    } else if (_currentPage == 3) {
      _pageController.nextPage(
        duration: 400.ms,
        curve: Curves.easeInOutQuart,
      );
      _runCalibration();
    }
  }

  void _runCalibration() {
    _calibrationTimer?.cancel();
    setState(() {
      _calibrationProgress = 0.0;
      _calibrationComplete = false;
    });

    _persistUserPreferences();

    const totalSteps = 30;
    const interval = Duration(milliseconds: 50);
    int currentStep = 0;

    _calibrationTimer = Timer.periodic(interval, (timer) {
      currentStep++;
      final progress = (currentStep / totalSteps).clamp(0.0, 1.0);

      if ((progress >= 0.35 && _calibrationProgress < 0.35) ||
          (progress >= 0.70 && _calibrationProgress < 0.70) ||
          (progress >= 0.99 && _calibrationProgress < 0.99)) {
        HapticsManager.light();
      }

      if (mounted) {
        setState(() {
          _calibrationProgress = progress;
          if (progress >= 1.0) {
            _calibrationComplete = true;
            HapticsManager.success();
            timer.cancel();
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _persistUserPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_mastery_level', _selectedMastery);
      await prefs.setInt('user_drive', _selectedDrive);
      final minutes = _selectedRitual == 0
          ? 5
          : (_selectedRitual == 1 ? 10 : (_selectedRitual == 2 ? 20 : 30));
      await prefs.setInt('daily_ritual_minutes', minutes);
      final targetHsk = _selectedMastery == 0
          ? 1
          : (_selectedMastery == 1 ? 2 : (_selectedMastery == 2 ? 3 : 5));
      await prefs.setInt('target_hsk_level', targetHsk);

      // Pre-seed the appropriate HSK tier and thematic deck based on user choices
      await ref.read(flashcardControllerProvider.notifier).preseedOnboardingDecks(
            masteryLevel: _selectedMastery >= 0 ? _selectedMastery : 0,
            drive: _selectedDrive >= 0 ? _selectedDrive : 0,
          );
    } catch (e) {
      debugPrint('Failed to persist onboarding choices: $e');
    }
  }

  void _autoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer(const Duration(milliseconds: 260), () {
      if (mounted) _nextPage();
    });
  }

  void _launchMiniLesson() {
    HapticsManager.medium();
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            OnboardingMiniLessonScreen(
          onComplete: _completeOnboarding,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final entrance = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return FadeTransition(
            opacity: entrance,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(entrance),
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _skipToLibrary() async {
    HapticsManager.light();
    _completeOnboarding();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (context) => const NotificationPermissionScreen(),
        ),
        (route) => false,
      );
    }
  }

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _calibrationTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? OnboardingDesign.backgroundDark
          : OnboardingDesign.backgroundLight,
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
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
                : isDark
                    ? Colors.white24
                    : Colors.black12,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  Widget _buildWelcomePage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxHeight < 600;
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: isCompact ? 16.0 : 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      decoration: isDark
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD4AF37)
                                      .withValues(alpha: 0.18),
                                  blurRadius: 36,
                                  spreadRadius: 8,
                                ),
                              ],
                            )
                          : null,
                      child: Image.asset(
                        'assets/images/mascot.png',
                        height: isCompact ? 140 : 190,
                        fit: BoxFit.contain,
                      ),
                    ).animate().scale(duration: 400.ms).fadeIn(),
                    SizedBox(height: isCompact ? 16 : 36),
                    Text(
                      l10n.yourPathTonchineseFluency,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                        fontSize: isCompact ? 28 : 36,
                        fontFamily: 'Serif',
                        height: 1.3,
                      ),
                    ).animate().fadeIn(delay: 300.ms).slideY(),
                    SizedBox(height: isCompact ? 12 : 24),
                    Text(
                      l10n.answer3QuickQuestionsSoOurAiCanCraf,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54,
                        fontSize: isCompact ? 14 : 16,
                        height: 1.5,
                      ),
                    ).animate().fadeIn(delay: 600.ms),
                    const Spacer(),
                    _buildPrimaryButton(l10n.letsBegin, _nextPage),
                    const SizedBox(height: 8),
                    TextButton(
                      key: const Key('onboarding_already_have_account_button'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                const AuthScreen(requireSubscription: true),
                          ),
                        );
                      },
                      child: Text(
                        l10n.alreadyHaveAccountSignIn,
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMasteryPage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final options = [
      {
        "title": l10n.brandNew,
        "subtitle": l10n.iveNeverStudiedChineseBefore,
        "icon": Icons.child_care_outlined
      },
      {
        "title": l10n.elementary,
        "subtitle": l10n.iKnowBasicCharactersAndPhrases,
        "icon": Icons.auto_stories_outlined
      },
      {
        "title": l10n.intermediate,
        "subtitle": l10n.iCanHoldConversationsAndRead,
        "icon": Icons.school_outlined
      },
      {
        "title": l10n.advanced,
        "subtitle": l10n.iWantToRefineAndPerfectMySkills,
        "icon": Icons.psychology_outlined
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.whatIsYourLevelnwithChinese,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: OnboardingDesign.titleFontSize,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          const SizedBox(height: 8),
          Text(
            l10n.chooseThePathThatFitsYourDepth,
            style: TextStyle(
                color: isDark ? Colors.white54 : Colors.black54, fontSize: 16),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
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
                    _autoAdvance();
                  },
                )
                    .animate()
                    .fadeIn(delay: Duration(milliseconds: 300 + (100 * index)))
                    .slideX();
              },
            ),
          ),
          _buildPrimaryButton(
            l10n.confirmSelection,
            _selectedMastery != -1 ? _nextPage : null,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDrivePage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final options = [
      {"title": l10n.businessCareer, "icon": Icons.work_outline},
      {
        "title": l10n.travelSurvival,
        "icon": Icons.location_on_outlined
      },
      {
        "title": l10n.hskCertification,
        "icon": Icons.workspace_premium_outlined
      },
      {
        "title": l10n.culturalAppreciation,
        "icon": Icons.palette_outlined
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.whatDrivesYourStudy,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: OnboardingDesign.titleFontSize,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          const SizedBox(height: 8),
          Text(
            l10n.purposeFuelsTheBrushsMotion,
            style: TextStyle(
                color: isDark ? Colors.white54 : Colors.black54, fontSize: 16),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: options.length,
              separatorBuilder: (c, i) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                bool isSelected = _selectedDrive == index;
                return _buildSelectionCard(
                  title: options[index]["title"] as String,
                  icon: options[index]["icon"] as IconData,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedDrive = index;
                    });
                    _autoAdvance();
                  },
                )
                    .animate()
                    .fadeIn(delay: Duration(milliseconds: 300 + (100 * index)))
                    .slideX();
              },
            ),
          ),
          _buildPrimaryButton(
            l10n.next,
            _selectedDrive != -1 ? _nextPage : null,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildRitualPage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final options = [
      {"title": "5", "subtitle": l10n.minutesDay},
      {"title": "10", "subtitle": l10n.minutesDay},
      {"title": "20", "subtitle": l10n.minutesDay},
      {"title": "30", "subtitle": l10n.minutesDay},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.setYourDailyRitual,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: OnboardingDesign.titleFontSize,
              fontFamily: 'Serif',
              height: 1.2,
            ),
          ).animate().fadeIn().slideY(),
          const SizedBox(height: 8),
          Text(
            l10n.consistencyIsTheInkThat,
            style: TextStyle(
                color: isDark ? Colors.white54 : Colors.black54,
                fontSize: 16,
                fontStyle: FontStyle.italic),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
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
                    _autoAdvance();
                  },
                )
                    .animate()
                    .fadeIn(delay: Duration(milliseconds: 300 + (100 * index)))
                    .slideX();
              },
            ),
          ),
          Column(
            children: [
              Icon(Icons.hourglass_empty, color: Colors.red[700]),
              const SizedBox(height: 8),
              Text(
                l10n.youCanAdjustYourRitualAnyTime,
                style: TextStyle(
                    color: isDark ? Colors.white38 : Colors.black38,
                    fontSize: 12),
              ),
              const SizedBox(height: 16),
              _buildPrimaryButton(
                l10n.buildMyPath,
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
    final l10n = AppLocalizations.of(context)!;

    String masteryText = l10n.brandNew;
    if (_selectedMastery == 1) masteryText = l10n.elementary;
    if (_selectedMastery == 2) masteryText = l10n.intermediate;
    if (_selectedMastery == 3) masteryText = l10n.advanced;

    String driveText = l10n.businessCareer;
    if (_selectedDrive == 1) driveText = l10n.travelSurvival;
    if (_selectedDrive == 2) driveText = l10n.hskCertification;
    if (_selectedDrive == 3) driveText = l10n.culturalAppreciation;

    String ritualText = l10n.label05MinDay;
    if (_selectedRitual == 1) ritualText = l10n.label10MinDay;
    if (_selectedRitual == 2) ritualText = l10n.label20MinDay;
    if (_selectedRitual == 3) ritualText = l10n.label30MinDay;

    final percentInt = (_calibrationProgress * 100).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _calibrationComplete
                ? l10n.yourPlanIsReady
                : l10n.craftingYourCurriculum,
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
                ? l10n.personalizedPathInitialized
                : l10n.calibratingAiNeuralMasters,
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
              border: Border.all(
                  color: (isDark ? Colors.white : Colors.black)
                      .withValues(alpha: 0.05)),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? Colors.white : Colors.black)
                      .withValues(alpha: 0.02),
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
                      _calibrationComplete
                          ? l10n.calibrationComplete
                          : l10n.synthesizingModules,
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
                  title: l10n.masteryLevel,
                  value: masteryText,
                  isDone: _calibrationProgress >= 0.35,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                _buildCalibrationStep(
                  icon: Icons.flag_outlined,
                  title: l10n.targetObjective,
                  value: driveText,
                  isDone: _calibrationProgress >= 0.70,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                _buildCalibrationStep(
                  icon: Icons.access_time,
                  title: l10n.dailyPractice,
                  value: ritualText,
                  isDone: _calibrationProgress >= 0.99,
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                _buildCalibrationStep(
                  icon: Icons.auto_awesome,
                  title: l10n.aiSpacedRepetition,
                  value: l10n.dynamicDecksStrokeAnalysis,
                  isDone: _calibrationComplete,
                  isDark: isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_calibrationComplete) ...[
            _buildPrimaryButton(
              l10n.beginFirstLesson,
              _launchMiniLesson,
            ).animate().fadeIn(duration: 300.ms),
            const SizedBox(height: 8),
            TextButton(
              key: const Key('onboarding_skip_lesson_button'),
              onPressed: _skipToLibrary,
              style: TextButton.styleFrom(
                foregroundColor: isDark ? Colors.white54 : Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text(
                'Explore Library Directly',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ).animate().fadeIn(delay: 200.ms),
          ],
          const SizedBox(height: 12),
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
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutQuart,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDone
            ? (isDark ? const Color(0xFF2A2A2B) : Colors.white)
            : (isDark ? const Color(0xFF222223) : const Color(0xFFF5F4E8)),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDone
              ? (isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.08))
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          AnimatedScale(
            scale: isDone ? 1.0 : 0.75,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            child: Icon(
              icon,
              color: isDone
                  ? Colors.red[700]
                  : (isDark ? Colors.white24 : Colors.black26),
              size: 22,
            ),
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
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0, 0.35),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ));
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(position: slide, child: child),
                    );
                  },
                  child: Text(
                    value,
                    key: ValueKey('$title-$isDone'),
                    style: TextStyle(
                      color: isDone
                          ? (isDark ? Colors.white : const Color(0xFF1A1A1B))
                          : (isDark ? Colors.white38 : Colors.black38),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: isDone
                ? Icon(Icons.check_circle,
                    color: Colors.green[600],
                    size: 20,
                    key: const ValueKey('done'))
                : SizedBox(
                    width: 16,
                    height: 16,
                    key: const ValueKey('loading'),
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

    final selectedBg =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final selectedText =
        isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: isSelected
                ? selectedBg
                : (isDark ? const Color(0xFF2A2A2B) : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? selectedBg
                  : (isDark ? Colors.white : Colors.black)
                      .withValues(alpha: 0.05),
              width: 1.5,
            ),
            boxShadow: [
              if (!isSelected)
                BoxShadow(
                  color: (isDark ? Colors.white : Colors.black)
                      .withValues(alpha: 0.02),
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
                  color: isSelected
                      ? selectedText
                      : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                  fontSize: 24,
                  fontFamily: 'Serif',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: isSelected
                        ? selectedText
                        : (isDark ? Colors.white54 : Colors.black54),
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
      ),
    );
  }

  Widget _buildSelectionCard({
    required String title,
    String? subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedBg =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final selectedText =
        isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? selectedBg
                : (isDark ? const Color(0xFF2A2A2B) : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? selectedBg
                  : (isDark ? Colors.white : Colors.black)
                      .withValues(alpha: 0.05),
              width: 1.5,
            ),
            boxShadow: [
              if (!isSelected)
                BoxShadow(
                  color: (isDark ? Colors.white : Colors.black)
                      .withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? selectedText.withValues(alpha: 0.12)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : const Color(0xFF1A1A1B).withValues(alpha: 0.05)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? selectedText
                      : (isDark ? Colors.white70 : const Color(0xFF1A1A1B)),
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isSelected
                            ? selectedText
                            : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (subtitle != null && subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: isSelected
                              ? selectedText
                              : (isDark ? Colors.white54 : Colors.black54),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: isDark ? const Color(0xFFD4AF37) : selectedText,
                  size: 22,
                )
              else
                Icon(
                  Icons.chevron_right,
                  color: isDark ? Colors.white24 : Colors.black26,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback? onPressed) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = onPressed == null;

    final activeBgColor =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final activeTextColor =
        isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return SizedBox(
      width: double.infinity,
      height: OnboardingDesign.primaryButtonHeight,
      child: BouncingButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: isDisabled
                ? activeBgColor.withValues(alpha: 0.3)
                : activeBgColor,
            borderRadius:
                BorderRadius.circular(OnboardingDesign.primaryButtonRadius),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isDisabled
                    ? activeTextColor.withValues(alpha: 0.5)
                    : activeTextColor,
                fontSize: OnboardingDesign.bodyFontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
