import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';

class TutorialLessonScreen extends ConsumerStatefulWidget {
  const TutorialLessonScreen({super.key});

  @override
  ConsumerState<TutorialLessonScreen> createState() => _TutorialLessonScreenState();
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
      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      setState(() => _currentStep++);
    } else {
      ref.read(settingsProvider.notifier).completeTutorial();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _cardOne == null || _cardWater == null) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.indigo),
              SizedBox(height: 16),
              Text("Opening the Origin Scroll...", style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
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
            _buildDrawingStep(
              "THE HORIZONTAL STROKE", 
              "This is ONE (Yī). Always draw from Left to Right.", 
              _cardOne!
            ),
            _buildRadicalExplanationStep(),
            _buildConstellationExplanationStep(),
            _buildDrawingStep(
              "THE RADICAL", 
              "This is the full character WATER (Shuǐ).\n\nWhen used as a left-side component, it shapeshifts into '氵' (Three Drops)!", 
              _cardWater!
            ),
            _buildFinaleStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildConstellationExplanationStep() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_awesome, size: 80, color: Colors.amber),
          const SizedBox(height: 32),
          const Text(
            "INDEPENDENT STARS",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber, letterSpacing: 2),
          ),
          const SizedBox(height: 48),
          const Text(
            "Not every character has a parent Radical. Some are unique pictographs or stand alone.",
            style: TextStyle(fontSize: 18, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            "On the map, we group these independent characters into CONSTELLATIONS (✨).",
            style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: const Text("I UNDERSTAND"),
          ),
        ],
      ),
    );
  }

  Widget _buildRadicalExplanationStep() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "WHAT ARE RADICALS?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo, letterSpacing: 2),
          ),
          const SizedBox(height: 48),
          // Visual Decomposition
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildComponentBox("氵", "Water", Colors.cyan),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("+", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ),
              _buildComponentBox("工", "Work", Colors.grey),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("=", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ),
              _buildComponentBox("江", "River", Colors.indigo),
            ],
          ),
          const SizedBox(height: 48),
          const Text(
            "Hanzi are built from building blocks called RADICALS.\n\nThey give the character its core meaning or theme.",
            style: TextStyle(fontSize: 18, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: const Text("CONTINUE"),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentBox(String hanzi, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 70, height: 70,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(hanzi, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildIntroStep() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_stories, size: 80, color: Colors.amber),
          const SizedBox(height: 32),
          const Text("THE SCROLL OF ORIGIN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber, letterSpacing: 2)),
          const SizedBox(height: 24),
          const Text(
            "Hanzi are not just letters. They are pictures frozen in time.\n\nTo master them, you must learn to trace their flow.",
            style: TextStyle(fontSize: 18, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: const Text("I AM READY"),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawingStep(String title, String subtitle, Flashcard card) {
    return Column(
      children: [
        const SizedBox(height: 100),
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Text(subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, 
                  color: Colors.grey.shade700,
                  height: 1.4)),
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              width: 300, height: 300,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 80, color: Colors.green),
          const SizedBox(height: 32),
          const Text("YOU ARE A SCHOLAR",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  letterSpacing: 2)),
          const SizedBox(height: 24),
          const Text(
            "The Galaxy Map awaits.\nMaster the Suns (Radicals) to unlock the Planets (Characters).",
            style: TextStyle(fontSize: 18, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: const Text("ENTER THE SCROLL"),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20)],
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
          
          final validStrokes = widget.card.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').toList();
          
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
