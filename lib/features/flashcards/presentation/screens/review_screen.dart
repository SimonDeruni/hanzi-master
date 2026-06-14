import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/streak_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/stroke_matcher.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'dart:ui' as ui;


enum ReviewState { practice, feedback, complete }

class ReviewScreen extends ConsumerStatefulWidget {
  final Flashcard card;
  final int reviewedCount;
  final int correctCount;
  final int dueCount;
  final int newCount;
  final int learningCount;

  const ReviewScreen({
    super.key, 
    required this.card,
    this.reviewedCount = 0,
    this.correctCount = 0,
    this.dueCount = 0,
    this.newCount = 0,
    this.learningCount = 0,
  });

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  late Flashcard _currentCard;
  final ValueNotifier<List<ui.Offset?>> _userPointsNotifier = ValueNotifier([]);
  
  ReviewState _state = ReviewState.practice;
  double _score = 0.0;
  
  bool _strokeByStrokeMode = true; 
  int _currentStrokeIndex = 0;
  final List<List<ui.Offset?>> _completedStrokes = []; 
  
  Size? _lastCanvasSize;
  
  int _currentCycleIndex = 0;
  Timer? _globalCycleTimer;

  final List<double> _strokeScores = [];
  String? _aiFeedback;
  bool _isAiLoading = false;
  bool _showHeatmap = true;

  @override
  void initState() {
    super.initState();
    _currentCard = widget.card;
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final updatedCard = await ref.read(flashcardControllerProvider.notifier).loadStrokesFor(widget.card);
      if (updatedCard != null) {
        if (mounted) {
          setState(() => _currentCard = updatedCard);
        }
      }
      ref.read(audioServiceProvider).playCharacter(_currentCard.hanzi);
    });
    _startGlobalCycle();
  }

  void _generateAiFeedback(List<double> strokeScores, double totalScore) async {
    setState(() { _isAiLoading = true; _aiFeedback = null; });
    try {
      final gemini = ref.read(geminiServiceProvider);
      
      List<int> poorStrokes = [];
      for (int i = 0; i < strokeScores.length; i++) {
        if (strokeScores[i] < 70) poorStrokes.add(i + 1);
      }
      
      String prompt = 'The user drew the Chinese character ${_currentCard.hanzi} and scored ${totalScore.toStringAsFixed(0)}/100.';
      if (poorStrokes.isNotEmpty) {
        prompt += ' Their worst strokes were strokes: ${poorStrokes.join(", ")}.';
      }
      prompt += ' Give a single, short, practical tip on how to improve the shape, position, or length of the poorly drawn strokes. Be direct and helpful, do not be overly poetic or metaphorical. Do not use markdown.';
      
      final response = await gemini.generateText(prompt);
      if (mounted) {
        setState(() {
          _aiFeedback = response;
          _isAiLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() { _isAiLoading = false; });
    }
  }

  void _startGlobalCycle() {
    _globalCycleTimer?.cancel();
    setState(() => _currentCycleIndex = 0);
    _runGlobalCycleLoop();
  }

  Future<void> _runGlobalCycleLoop() async {
    if (!mounted || _state != ReviewState.feedback) return;

    // 1. Robust Grouping (Identical to DrawingCanvas)
    final groups = <List<String>>[];
    var currentGroup = <String>[];
    for (final stroke in _currentCard.strokePaths) {
      if (stroke == '__CHAR_SEPARATOR__') {
        if (currentGroup.isNotEmpty) {
          groups.add(currentGroup);
          currentGroup = [];
        }
      } else {
        currentGroup.add(stroke);
      }
    }
    if (currentGroup.isNotEmpty) groups.add(currentGroup);
    
    // 2. Safety Checks
    if (groups.length <= 1) return; // No cycling needed for single chars
    if (_currentCycleIndex >= groups.length) _currentCycleIndex = 0;

    // 3. Calculate Wait Time
    final currentStrokes = groups[_currentCycleIndex].length;
    // Time = (Animation Duration) + (Pause)
    // Animation = 200ms base + 500ms per stroke (approx matching DrawingCanvas)
    // We add extra buffer for the user to admire the result
    final waitMs = (200 + currentStrokes * 500) + 1500;

    // 4. Schedule Next Cycle
    _globalCycleTimer = Timer(Duration(milliseconds: waitMs), () {
      if (mounted && _state == ReviewState.feedback) {
        setState(() => _currentCycleIndex = (_currentCycleIndex + 1) % groups.length);
        _runGlobalCycleLoop();
      }
    });
  }



  @override
  void dispose() {
    _globalCycleTimer?.cancel();
    super.dispose();
  }

  Future<void> _submitDrawing(List<ui.Offset?> userPoints, {Size? canvasSize}) async {
    if (userPoints.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please draw something first')));
      return;
    }
    final userStrokes = _splitIntoStrokes(userPoints);
    _completedStrokes.clear();
    _completedStrokes.addAll(userStrokes);
    final medians = _currentCard.medianPaths;
    if (userStrokes.isEmpty || medians.isEmpty) {
      setState(() { _score = 0.0; _state = ReviewState.feedback; });
      return;
    }

    final double mastery = _currentCard.masteryLevel(StudyMode.calligraphy);
    final List<Future<StrokeMatchResult>> futures = [];
    
    for (int i = 0; i < medians.length; i++) {
      if (i < userStrokes.length) {
        final refMedian = medians[i];
        futures.add(StrokeMatcher.matchStrokeAsync(userStrokes[i], refMedian, masteryLevel: mastery));
      }
    }

    final results = await Future.wait(futures);

    double totalScore = 0.0;
    int evaluated = 0;
    final List<double> newStrokeScores = [];
    
    for (final result in results) {
      newStrokeScores.add(result.score * 100.0);
      totalScore += result.score;
      evaluated++;
    }

    final finalScore = (evaluated > 0 ? (totalScore / medians.length) : 0.0) * 100.0;
    
    if (!mounted) return;

    if (finalScore >= 80) {
      HapticsManager.success();
    } else {
      HapticsManager.heavy();
    }
    
    setState(() {
      _strokeScores.clear();
      _strokeScores.addAll(newStrokeScores);
      _score = finalScore;
      _state = ReviewState.feedback;
    });

    if (_strokeByStrokeMode && finalScore < 95) {
      _generateAiFeedback(newStrokeScores, finalScore);
    }
    _startGlobalCycle();
  }

  List<List<ui.Offset>> _splitIntoStrokes(List<ui.Offset?> points) {
    List<List<ui.Offset>> strokes = [];
    List<ui.Offset> current = [];
    for (final p in points) {
      if (p == null) {
        if (current.isNotEmpty) {
          strokes.add(List.from(current));
          current.clear();
        }
      } else {
        current.add(p);
      }
    }
    if (current.isNotEmpty) {
      strokes.add(current);
    }
    return strokes;
  }

  void _onStrokeComplete(int strokeIndex, Size size) {
    _lastCanvasSize = size;
    if (strokeIndex != _currentStrokeIndex) {
      return;
    }
    final normalizedPoints = List<ui.Offset?>.from(_userPointsNotifier.value);
    setState(() => _completedStrokes.add(normalizedPoints));
    HapticsManager.light();
    final totalValidStrokes = _currentCard.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').length;
    if (_currentStrokeIndex + 1 < totalValidStrokes) {
      int validFound = 0;
      bool isEndOfChar = false;
      for (int i = 0; i < _currentCard.strokePaths.length; i++) {
        if (_currentCard.strokePaths[i] != '__CHAR_SEPARATOR__') {
          if (validFound == _currentStrokeIndex) {
            if (i + 1 < _currentCard.strokePaths.length && _currentCard.strokePaths[i+1] == '__CHAR_SEPARATOR__') {
              isEndOfChar = true;
            }
            break;
          }
          validFound++;
        }
      }
      Future.delayed(Duration(milliseconds: isEndOfChar ? 1200 : 100), () {
        if (mounted) {
          setState(() { _currentStrokeIndex++; _userPointsNotifier.value = []; });
        }
      });
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          List<ui.Offset?> allPoints = [];
          for (final stroke in _completedStrokes) {
            allPoints.addAll(stroke);
            allPoints.add(null);
          }
          _submitDrawing(allPoints, canvasSize: const ui.Size(1000, 1000));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: StudySessionAppBar(
        title: _currentCard.hanzi,
        dueCount: widget.dueCount,
        newCount: widget.newCount,
        learningCount: widget.learningCount,
      ),
      body: _state == ReviewState.practice ? _buildPracticeScreen(settings) : _buildFeedbackScreen(settings),
    );
  }

  Widget _buildPracticeScreen(dynamic settings) {
    final totalStrokes = _currentCard.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').length;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue.shade600, Colors.blue.shade400], begin: Alignment.topLeft, end: Alignment.bottomRight),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Draw this character:', style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(_currentCard.hanzi, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
                            IconButton(icon: const Icon(Icons.volume_up, color: Colors.white70), onPressed: () => ref.read(audioServiceProvider).playCharacter(_currentCard.hanzi)),
                          ],
                        ),
                        PinyinText(text: _currentCard.pinyin, style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                        Text(_currentCard.definition, style: const TextStyle(fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              if (_strokeByStrokeMode) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Follow the blue guide to draw stroke ${_currentStrokeIndex + 1} of $totalStrokes', style: const TextStyle(color: Colors.white, fontSize: 14))),
                      Text('${_currentStrokeIndex + 1}/$totalStrokes', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 16, offset: const Offset(0, 4))]),
                  clipBehavior: Clip.antiAlias,
                  child: CalligraphyBackground(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        _lastCanvasSize = constraints.biggest;
                        return DrawingCanvas(
                          key: const ValueKey('practiceCanvas'),
                          strokePaths: _currentCard.strokePaths,
                          medianPaths: _currentCard.medianPaths,
                          showAnimation: false,
                          animationSpeed: settings.animationSpeed,
                          userPointsNotifier: _userPointsNotifier,
                          strokeByStrokeMode: _strokeByStrokeMode,
                          currentStrokeIndex: _currentStrokeIndex,
                          onStrokeComplete: _onStrokeComplete,
                          masteryLevel: (_currentCard.masteryLevel(StudyMode.calligraphy)),
                          isFlipped: _currentCard.isFlipped,
                          showReference: _currentCard.getStatsForMode(StudyMode.calligraphy).streak < settings.guideDisappearanceStreak, // Hide blue guide based on settings
                        );
                      }
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity, height: 56,
            child: _strokeByStrokeMode 
              ? OutlinedButton.icon(
                  icon: const Icon(Icons.skip_next), label: const Text('Skip Current Stroke'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.orange.shade700, side: BorderSide(color: Colors.orange.shade700)),
                  onPressed: () => _onStrokeComplete(_currentStrokeIndex, _lastCanvasSize ?? ui.Size.zero),
                )
              : ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle, size: 24), label: const Text('Submit Drawing'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600, foregroundColor: Colors.white),
                  onPressed: () => _submitDrawing(_userPointsNotifier.value),
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackScreen(dynamic settings) {
    final isSuccess = _score >= 80;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final cardColor = isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white;
    final themeColor = isSuccess ? Colors.green : Colors.orange;
    
    return Container(
      color: bgColor,
      child: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [themeColor.shade400, themeColor.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: themeColor.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
                ]
              ),
              child: Column(
                children: [
                  Text(
                    _strokeByStrokeMode ? (isSuccess ? 'Excellent work!' : 'Keep practicing!') : 'Drawing Submitted',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5),
                  ),
                  if (_strokeByStrokeMode) ...[
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80, height: 80,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]),
                          child: Center(
                            child: Text(
                              _score.toStringAsFixed(0),
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: themeColor.shade700),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStarRating(_score, size: 24, color: Colors.white),
                            const SizedBox(height: 6),
                            Text(_getFeedback(_score), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14)),
                          ]
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Character Info Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2))],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: themeColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                            child: Text(_currentCard.hanzi, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: themeColor.shade700)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PinyinText(text: _currentCard.pinyin, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                                const SizedBox(height: 4),
                                Text(_currentCard.definition, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // AI Teacher Note
                    if (_strokeByStrokeMode && (_isAiLoading || _aiFeedback != null))
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.indigo.withValues(alpha: 0.1) : Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.auto_awesome, color: Colors.indigo, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _isAiLoading 
                                ? const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)))
                                : Text(_aiFeedback ?? '', style: TextStyle(color: isDark ? Colors.white70 : Colors.indigo.shade900, fontSize: 14, height: 1.4)),
                            ),
                          ],
                        ),
                      )
                    else 
                      const SizedBox(height: 8),
                    
                    // Canvases
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Your Drawing", style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 8),
                                    if (_strokeByStrokeMode)
                                      GestureDetector(
                                        onTap: () => setState(() => _showHeatmap = !_showHeatmap),
                                        child: Icon(
                                          _showHeatmap ? Icons.palette : Icons.format_color_text, 
                                          size: 16, 
                                          color: _showHeatmap ? themeColor : Colors.grey
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: DrawingCanvas(
                                      strokePaths: _currentCard.strokePaths,
                                      medianPaths: _currentCard.medianPaths,
                                      showAnimation: false,
                                      readOnly: true,
                                      autoCenter: true,
                                      initialUserStrokes: _completedStrokes,
                                      forcedActiveCharIndex: _currentCycleIndex,
                                      isFlipped: _currentCard.isFlipped,
                                      showGrade: false,
                                      showReference: false,
                                      strokeScores: _strokeScores,
                                      showHeatmap: _showHeatmap,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text("Reference", style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: DrawingCanvas(
                                      strokePaths: _currentCard.strokePaths,
                                      medianPaths: _currentCard.medianPaths,
                                      showAnimation: true,
                                      readOnly: true,
                                      autoCenter: true,
                                      forcedActiveCharIndex: _currentCycleIndex,
                                      isFlipped: _currentCard.isFlipped,
                                      showGrade: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            
            // Grading Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Text("Rate your recall", style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGradeButton('Again', 0, Colors.red, 'Failed to recall', isDark),
                      _buildGradeButton('Hard', 2, Colors.orange, 'Recalled with effort', isDark),
                      _buildGradeButton('Good', 4, Colors.green, 'Recalled well', isDark),
                      _buildGradeButton('Easy', 5, Colors.blue, 'Perfect recall', isDark),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeButton(String label, int grade, MaterialColor color, String tooltip, bool isDark) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Tooltip(
          message: tooltip,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, grade);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? color.withValues(alpha: 0.15) : color.shade50,
              foregroundColor: isDark ? color.shade300 : color.shade700,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: isDark ? color.withValues(alpha: 0.3) : color.shade200, width: 1),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }

  String _getFeedback(double s) => s >= 90 ? "Perfect!" : (s >= 70 ? "Great!" : (s >= 50 ? "Good attempt" : "Keep practicing"));

  Widget _buildStarRating(double score, {double size = 40, Color? color}) {
    int stars = score >= 95 ? 5 : (score >= 85 ? 4 : (score >= 70 ? 3 : (score >= 50 ? 2 : (score >= 30 ? 1 : 0))));
    return Row(children: List.generate(5, (index) => Icon(index < stars ? Icons.star : Icons.star_border, size: size, color: color ?? Colors.amber)));
  }
}
