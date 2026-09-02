import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class TutorialLessonScreen extends ConsumerStatefulWidget {
  const TutorialLessonScreen({super.key});

  @override
  ConsumerState<TutorialLessonScreen> createState() =>
      _TutorialLessonScreenState();
}

class _TutorialLessonScreenState extends ConsumerState<TutorialLessonScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  Flashcard? _cardOne;
  Flashcard? _cardWater;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRealDataFromRepository();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Fetches real HSK1 cards from the library to ensure tutorial accuracy
  Future<void> _loadRealDataFromRepository() async {
    try {
      final controller = ref.read(flashcardControllerProvider.notifier);
      final allCards = await ref.read(flashcardControllerProvider.future);

      // 1. Find the real HSK1 cards for 'One' and 'Water'
      final one = allCards.firstWhere((c) => c.hanzi == '一');
      final water = allCards.firstWhere((c) => c.hanzi == '水');

      // 2. Hydrate them with vector stroke data (Skeletons/Outlines)
      _cardOne = await controller.loadStrokesFor(one);
      _cardWater = await controller.loadStrokesFor(water);

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _nextPage() {
    if (_currentStep < 5) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      setState(() => _currentStep++);
    } else {
      ref.read(settingsProvider.notifier).completeTutorial();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inkColor = theme.colorScheme.onSurface;

    if (_isLoading || _cardOne == null || _cardWater == null) {
      return Scaffold(
        backgroundColor:
            isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        body: CalligraphyBackground(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: theme.colorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.openingTheOriginScroll,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: inkColor.withValues(alpha: 0.65)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CalligraphyBackground(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildIntroStep(),
            _buildDrawingStep("THE HORIZONTAL STROKE",
                "This is ONE (Yī). Always draw from Left to Right.", _cardOne!),
            _buildRadicalExplanationStep(),
            _buildConstellationExplanationStep(),
            _buildDrawingStep(
                "THE RADICAL",
                "This is the full character WATER (Shuǐ).\n\nWhen used as a left-side component, it shapeshifts into '氵' (Three Drops)!",
                _cardWater!),
            _buildFinaleStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildConstellationExplanationStep() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inkColor = theme.colorScheme.onSurface;
    final buttonColor = isDark ? Colors.amber.shade300 : Colors.amber.shade800;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_awesome, size: 80, color: Colors.amber),
          const SizedBox(height: 32),
          const Text(
            "INDEPENDENT STARS",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                letterSpacing: 2),
          ),
          const SizedBox(height: 48),
          Text(
            "Not every character has a parent Radical. Some are unique pictographs or stand alone.",
            style: TextStyle(fontSize: 18, height: 1.5, color: inkColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            "On the map, we group these independent characters into CONSTELLATIONS (✨).",
            style: TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.bold,
              color: inkColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor:
                    isDark ? const Color(0xFF1A1A1B) : Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: Text(AppLocalizations.of(context)!.iUnderstand),
          ),
        ],
      ),
    );
  }

  Widget _buildRadicalExplanationStep() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inkColor = theme.colorScheme.onSurface;
    final primaryColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "WHAT ARE RADICALS?",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                letterSpacing: 2),
          ),
          const SizedBox(height: 48),
          // Visual Decomposition
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildComponentBox("氵", "Water", Colors.cyan),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("+",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ),
              _buildComponentBox("工", "Work", Colors.grey),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("=",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ),
              _buildComponentBox("江", "River", Colors.indigo),
            ],
          ),
          const SizedBox(height: 48),
          Text(
            "Hanzi are built from building blocks called RADICALS.\n\nThey give the character its core meaning or theme.",
            style: TextStyle(fontSize: 18, height: 1.5, color: inkColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor:
                    isDark ? const Color(0xFF1A1A1B) : Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: Text(AppLocalizations.of(context)!.continueText),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentBox(String hanzi, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(hanzi,
                style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold, color: color)),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildIntroStep() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inkColor = theme.colorScheme.onSurface;
    final primaryColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_stories, size: 80, color: Colors.amber),
          const SizedBox(height: 32),
          Text(AppLocalizations.of(context)!.theScrollOfOrigin,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  letterSpacing: 2)),
          const SizedBox(height: 24),
          Text(
            "Hanzi are not just letters. They are pictures frozen in time.\n\nTo master them, you must learn to trace their flow.",
            style: TextStyle(fontSize: 18, height: 1.5, color: inkColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor:
                    isDark ? const Color(0xFF1A1A1B) : Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: Text(AppLocalizations.of(context)!.iAmReady),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawingStep(String title, String subtitle, Flashcard card) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 100),
        Text(title,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Text(subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.4,
              )),
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: _TutorialCanvasWrapper(
                card: card,
                onComplete: _nextPage,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildFinaleStep() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inkColor = theme.colorScheme.onSurface;
    final successColor = isDark ? Colors.green.shade300 : Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 80, color: successColor),
          const SizedBox(height: 32),
          Text(AppLocalizations.of(context)!.youAreAScholar,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                  letterSpacing: 2)),
          const SizedBox(height: 24),
          Text(
            "The Galaxy Map awaits.\nMaster the Suns (Radicals) to unlock the Planets (Characters).",
            style: TextStyle(fontSize: 18, height: 1.5, color: inkColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
                backgroundColor: successColor,
                foregroundColor:
                    isDark ? const Color(0xFF1A1A1B) : Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: Text(AppLocalizations.of(context)!.enterTheScroll),
          ),
        ],
      ),
    );
  }
}

class _TutorialCanvasWrapper extends StatefulWidget {
  final Flashcard card;
  final VoidCallback onComplete;
  const _TutorialCanvasWrapper({required this.card, required this.onComplete});

  @override
  State<_TutorialCanvasWrapper> createState() => _TutorialCanvasWrapperState();
}

class _TutorialCanvasWrapperState extends State<_TutorialCanvasWrapper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2A2A2B)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black)
              .withValues(alpha: isDark ? 0.10 : 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.12),
            blurRadius: 20,
          ),
        ],
      ),
      child: DrawingCanvas(
        key: ValueKey(widget.card.id),
        strokePaths: widget.card.strokePaths,
        medianPaths: widget.card.medianPaths,
        isFlipped: widget.card.isFlipped,
        masteryLevel: 0.0,
        showAnimation: false,
        showReference: true,
        showGuideLines: true,
        strokeByStrokeMode: true,
        currentStrokeIndex: _currentIndex,
        showGrade: false,
        autoActiveChar: false,
        showControls: false,
        onStrokeComplete: (idx, size) {
          HapticsManager.light();

          final validStrokes = widget.card.strokePaths
              .where((s) => s != '__CHAR_SEPARATOR__')
              .toList();

          if (_currentIndex < validStrokes.length - 1) {
            setState(() => _currentIndex++);
          } else {
            HapticsManager.success();
            Future.delayed(const Duration(seconds: 1), widget.onComplete);
          }
        },
      ),
    );
  }
}
