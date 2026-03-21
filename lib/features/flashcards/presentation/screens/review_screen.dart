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
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'dart:ui' as ui;
import 'package:hanzi_master/core/character_loader.dart';

enum ReviewState { practice, feedback, complete }

class ReviewScreen extends ConsumerStatefulWidget {
  final Flashcard card;
  final int reviewedCount;
  final int correctCount;

  const ReviewScreen({
    super.key, 
    required this.card,
    this.reviewedCount = 0,
    this.correctCount = 0,
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
    final medians = _currentCard.medianPaths;
    if (userStrokes.isEmpty || medians.isEmpty) {
      setState(() { _score = 0.0; _state = ReviewState.feedback; });
      return;
    }

    final double mastery = (_currentCard.streak / 5.0).clamp(0.0, 1.0);
    final List<Future<StrokeMatchResult>> futures = [];
    
    for (int i = 0; i < medians.length; i++) {
      if (i < userStrokes.length) {
        final refMedian = medians[i].map((p) => CharacterLoader.transformPoint(p)).toList();
        futures.add(StrokeMatcher.matchStrokeAsync(userStrokes[i], refMedian, masteryLevel: mastery));
      }
    }

    final results = await Future.wait(futures);

    double totalScore = 0.0;
    int evaluated = 0;
    for (final result in results) {
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
    setState(() { _score = finalScore; _state = ReviewState.feedback; });
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

  void _continueToNext() {
    int rating = _score < 60 ? 1 : (_score < 80 ? 2 : (_score < 95 ? 3 : 4));
    
    // 🚀 FIX: Update performance tracking fields on the card entity
    final updatedCard = _currentCard.copyWith(
      attempts: _currentCard.attempts + 1,
      successCount: _score >= 80 ? _currentCard.successCount + 1 : _currentCard.successCount,
      lastScore: _score,
      lastAttemptDate: DateTime.now(),
    );

    // Pass the already-updated card to the SRS logic
    ref.read(flashcardControllerProvider.notifier).reviewFlashcard(updatedCard, rating);
    ref.read(streakProvider.notifier).incrementStreak();
    Navigator.pop(context, _score);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(_currentCard.hanzi)),
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
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(value: true, label: Text('Guided'), icon: Icon(Icons.school, size: 18)),
                        ButtonSegment(value: false, label: Text('Free'), icon: Icon(Icons.draw, size: 18)),
                      ],
                      selected: {_strokeByStrokeMode},
                      onSelectionChanged: (Set<bool> s) => setState(() { _strokeByStrokeMode = s.first; _currentStrokeIndex = 0; _completedStrokes.clear(); _userPointsNotifier.value = []; }),
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
                          masteryLevel: (_currentCard.streak / 5.0).clamp(0.0, 1.0),
                          isFlipped: _currentCard.isFlipped,
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
    final themeColor = isSuccess ? Colors.green : Colors.orange;
    return Container(
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Container(
            width: double.infinity, padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [themeColor.shade400, themeColor.shade600])),
            child: Column(
              children: [
                Text(isSuccess ? '🎉 EXCELLENT!' : '💪 KEEP GOING!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 90, height: 90, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Center(child: Text(_score.toStringAsFixed(0), style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: themeColor.shade700)))),
                    const SizedBox(width: 24),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      _buildStarRating(_score, size: 28, color: Colors.white),
                      const SizedBox(height: 8),
                      Text(_getFeedback(_score), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: double.infinity, padding: const EdgeInsets.all(16), margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      Text(_currentCard.hanzi, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo)),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        PinyinText(text: _currentCard.pinyin, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(_currentCard.definition),
                      ])),
                    ]),
                  ),
                  Expanded(child: Row(children: [
                    Expanded(flex: 2, child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: DrawingCanvas(strokePaths: _currentCard.strokePaths, medianPaths: _currentCard.medianPaths, showAnimation: false, readOnly: true, autoCenter: true, initialUserStrokes: _completedStrokes, forcedActiveCharIndex: _currentCycleIndex, isFlipped: _currentCard.isFlipped, showGrade: false, showReference: false))),
                    const SizedBox(width: 16),
                    Expanded(flex: 3, child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: DrawingCanvas(strokePaths: _currentCard.strokePaths, medianPaths: _currentCard.medianPaths, showAnimation: true, readOnly: true, autoCenter: true, forcedActiveCharIndex: _currentCycleIndex, isFlipped: _currentCard.isFlipped, showGrade: false))),
                  ])),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: ElevatedButton(onPressed: _continueToNext, style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 60)), child: const Text('CONTINUE')),
          ),
        ],
      ),
    );
  }

  String _getFeedback(double s) => s >= 90 ? "Perfect!" : (s >= 70 ? "Great!" : (s >= 50 ? "Good attempt" : "Keep practicing"));

  Widget _buildStarRating(double score, {double size = 40, Color? color}) {
    int stars = score >= 95 ? 5 : (score >= 85 ? 4 : (score >= 70 ? 3 : (score >= 50 ? 2 : (score >= 30 ? 1 : 0))));
    return Row(children: List.generate(5, (index) => Icon(index < stars ? Icons.star : Icons.star_border, size: size, color: color ?? Colors.amber)));
  }
}
