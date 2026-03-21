import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/streak_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/flashcards/domain/services/stroke_grader.dart';
import '../../domain/entities/flashcard.dart';
import '../widgets/drawing_canvas.dart';
import '../utils/tts_manager.dart';
import '../widgets/rice_grid_painter.dart';
import '../providers/settings_controller.dart';
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
  final TtsManager _tts = TtsManager();
  late Flashcard _currentCard;
  final ValueNotifier<List<ui.Offset?>> _userPointsNotifier = ValueNotifier([]);
  
  ReviewState _state = ReviewState.practice;
  double _score = 0.0;
  
  bool _strokeByStrokeMode = true; 
  int _currentStrokeIndex = 0;
  final List<List<ui.Offset?>> _completedStrokes = []; 
  
  int _solutionKey = 0;
  Size? _lastCanvasSize;

  @override
  void initState() {
    super.initState();
    _tts.init();
    _currentCard = widget.card;
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final updatedCard = await ref.read(flashcardControllerProvider.notifier).loadStrokesFor(widget.card);
      if (updatedCard != null) {
        setState(() {
          _currentCard = updatedCard;
        });
      }
      _tts.speak(_currentCard.hanzi);
    });
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  void _submitDrawing(List<ui.Offset?> userPoints, {Size? canvasSize}) {
    if (userPoints.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please draw something first')),
      );
      return;
    }
    
    final refPaths = CharacterLoader.parseStrokes(
      _currentCard.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').toList(),
      normalize: true,
    );

    final score = StrokeGrader.gradeStrokes(
      referencePaths: refPaths,
      userPoints: userPoints,
      canvasSize: canvasSize ?? _lastCanvasSize,
    );
        
    if (score >= 80) {
      HapticsManager.success();
    } else {
      HapticsManager.heavy();
    }
    
    setState(() {
      _score = score;
      _state = ReviewState.feedback;
    });
  }

  void _onStrokeComplete(int strokeIndex, Size size) {
    _lastCanvasSize = size;
    if (strokeIndex != _currentStrokeIndex) return;
    
    // NORMALIZE points before storing so they are centered in previews
    final rawPoints = List<ui.Offset?>.from(_userPointsNotifier.value);
    final normalizedPoints = rawPoints.map((p) {
      if (p == null) return null;
      return ui.Offset(p.dx * (1000.0 / size.width), p.dy * (1000.0 / size.height));
    }).toList();

    setState(() {
      _completedStrokes.add(normalizedPoints);
    });

    HapticsManager.light();
    
    final totalValidStrokes = _currentCard.strokePaths
        .where((s) => s != '__CHAR_SEPARATOR__')
        .length;
    
    if (_currentStrokeIndex + 1 < totalValidStrokes) {
      int validFound = 0;
      bool isEndOfChar = false;
      for (int i = 0; i < _currentCard.strokePaths.length; i++) {
        if (_currentCard.strokePaths[i] != '__CHAR_SEPARATOR__') {
          if (validFound == _currentStrokeIndex) {
            if (i + 1 < _currentCard.strokePaths.length && 
                _currentCard.strokePaths[i+1] == '__CHAR_SEPARATOR__') {
              isEndOfChar = true;
            }
            break;
          }
          validFound++;
        }
      }

      final delay = isEndOfChar ? 1200 : 100;

      Future.delayed(Duration(milliseconds: delay), () {
        if (mounted) {
          setState(() {
            _currentStrokeIndex++;
            _userPointsNotifier.value = [];
          });
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
          // Note: Since allPoints are already normalized, we pass a 1000x1000 size to the grader
          _submitDrawing(allPoints, canvasSize: const ui.Size(1000, 1000));
        }
      });
    }
  }

  void _continueToNext() {
    int rating;
    if (_score < 60) rating = 1;
    else if (_score < 80) rating = 2;
    else if (_score < 95) rating = 3;
    else rating = 4;

    final updatedCard = _currentCard.copyWith(
      lastScore: _score,
      attempts: _currentCard.attempts + 1,
      lastAttemptDate: DateTime.now(),
      successCount: _score >= 80 ? _currentCard.successCount + 1 : _currentCard.successCount,
    );
    
    ref.read(flashcardControllerProvider.notifier).reviewFlashcard(updatedCard, rating);
    ref.read(streakProvider.notifier).incrementStreak();
    Navigator.pop(context, _score);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(_currentCard.hanzi)),
      body: _state == ReviewState.practice
          ? _buildPracticeScreen(settings)
          : _buildFeedbackScreen(settings),
    );
  }

  Widget _buildPracticeScreen(dynamic settings) {
    final totalStrokes = _currentCard.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').length;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade600, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
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
                            Text(_currentCard.hanzi, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))])),
                            const SizedBox(width: 8),
                            IconButton(icon: const Icon(Icons.volume_up, color: Colors.white70), onPressed: () => _tts.speak(_currentCard.hanzi), tooltip: 'Listen to pronunciation'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(_currentCard.pinyin, style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text(_currentCard.definition, style: const TextStyle(fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Text('Learning Mode', style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))]),
                        child: SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(value: true, label: Text('Guided'), icon: Icon(Icons.school, size: 18)),
                            ButtonSegment(value: false, label: Text('Free'), icon: Icon(Icons.draw, size: 18)),
                          ],
                          selected: {_strokeByStrokeMode},
                          onSelectionChanged: (Set<bool> newSelection) {
                            setState(() {
                              _strokeByStrokeMode = newSelection.first;
                              _currentStrokeIndex = 0;
                              _completedStrokes.clear();
                              _userPointsNotifier.value = [];
                            });
                          },
                        ),
                      ),
                    ],
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
                      Expanded(child: Text('Follow the blue guide to draw stroke ${_currentStrokeIndex + 1} of $totalStrokes', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Text('${_currentStrokeIndex + 1}/$totalStrokes', style: TextStyle(color: Colors.blue.shade700, fontSize: 16, fontWeight: FontWeight.bold))),
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
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 16, offset: const Offset(0, 4))]),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned.fill(child: CustomPaint(painter: RiceGridPainter())),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          _lastCanvasSize = constraints.biggest;
                          return DrawingCanvas(
                            key: const ValueKey('practiceCanvas'),
                            strokePaths: _currentCard.strokePaths,
                            showAnimation: false,
                            animationSpeed: settings.animationSpeed,
                            userPointsNotifier: _userPointsNotifier,
                            strokeByStrokeMode: _strokeByStrokeMode,
                            currentStrokeIndex: _currentStrokeIndex,
                            onStrokeComplete: _onStrokeComplete,
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: _strokeByStrokeMode 
              ? OutlinedButton.icon(
                  icon: const Icon(Icons.skip_next),
                  label: const Text('Skip Current Stroke'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.orange.shade700, side: BorderSide(color: Colors.orange.shade700), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () => _onStrokeComplete(_currentStrokeIndex, _lastCanvasSize ?? ui.Size.zero),
                )
              : ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle, size: 24),
                  label: const Text('Submit Drawing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600, foregroundColor: Colors.white, elevation: 4, shadowColor: Colors.green.withValues(alpha: 0.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () => _submitDrawing(_userPointsNotifier.value),
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackScreen(dynamic settings) {
    final feedback = StrokeGrader.getFeedback(_score);
    final isSuccess = _score >= 80;
    final themeColor = isSuccess ? Colors.green : Colors.orange;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          height: constraints.maxHeight,
          color: Colors.grey.shade50,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [themeColor.shade400, themeColor.shade600], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                  boxShadow: [BoxShadow(color: themeColor.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: Column(
                  children: [
                    Text(isSuccess ? '🎉 EXCELLENT!' : '💪 KEEP GOING!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.2)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90, height: 90,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Text(_score.toStringAsFixed(0), style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: themeColor.shade700)),
                            Text('pts', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: themeColor.shade300)),
                          ])),
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStarRating(_score, size: 28, color: Colors.white),
                            const SizedBox(height: 8),
                            SizedBox(width: 150, child: Text(feedback, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500))),
                          ],
                        ),
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
                      // WORD SUMMARY CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.indigo.shade100)),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: Text(_currentCard.hanzi, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(_currentCard.pinyin, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo.shade900)),
                              Text(_currentCard.definition, style: TextStyle(fontSize: 14, color: Colors.indigo.shade700)),
                            ])),
                            IconButton(icon: const Icon(Icons.volume_up, color: Colors.indigo), onPressed: () => _tts.speak(_currentCard.hanzi)),
                          ],
                        ),
                      ),

                      // COMPARISON ROW
                      Expanded(
                        child: Row(
                          children: [
                            // YOUR WORK (40% width)
                            Expanded(
                              flex: 2,
                              child: Column(children: [
                                const Text('YOUR WORK', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
                                const SizedBox(height: 8),
                                Expanded(child: Container(
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(children: [
                                    Positioned.fill(child: CustomPaint(painter: RiceGridPainter())),
                                  DrawingCanvas(
                                    key: ValueKey('preview_$_solutionKey'),
                                    strokePaths: _currentCard.strokePaths,
                                    showAnimation: false, // Don't show solution animation here
                                    readOnly: true, showGrade: false,
                                    autoCenter: true, 
                                    initialUserStrokes: _completedStrokes,
                                  ),
                                  ]),
                                )),
                              ]),
                            ),
                            const SizedBox(width: 16),
                            // IDEAL SOLUTION (60% width)
                            Expanded(
                              flex: 3,
                              child: Column(children: [
                                const Text('IDEAL SOLUTION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
                                const SizedBox(height: 8),
                                Expanded(child: Container(
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.indigo.shade100, width: 2), boxShadow: [BoxShadow(color: Colors.indigo.withValues(alpha: 0.1), blurRadius: 15)]),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(children: [
                                    Positioned.fill(child: CustomPaint(painter: RiceGridPainter())),
                                    DrawingCanvas(
                                      key: ValueKey(_solutionKey),
                                      strokePaths: _currentCard.strokePaths,
                                      showAnimation: true, animationSpeed: settings.animationSpeed,
                                      showControls: false, showGrade: false, readOnly: true,
                                      autoCenter: true, // Center the preview
                                    ),
                                    Positioned(top: 8, right: 8, child: IconButton(icon: const Icon(Icons.replay, size: 20, color: Colors.indigo), onPressed: () => setState(() => _solutionKey++))),
                                  ]),
                                )),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      Row(children: [
                        Expanded(child: _buildMiniStat('ATTEMPTS', '${_currentCard.attempts + 1}')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildMiniStat('SUCCESS', '${((_currentCard.successCount / (_currentCard.attempts + 1)) * 100).toStringAsFixed(0)}%')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildMiniStat('SCORE', '${_score.toStringAsFixed(0)}%')),
                      ]),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: SizedBox(
                  width: double.infinity, height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, elevation: 8, shadowColor: Colors.indigo.withValues(alpha: 0.4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    onPressed: _continueToNext,
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('CONTINUE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                      SizedBox(width: 12), Icon(Icons.arrow_forward_ios, size: 18),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 5)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo)),
      ]),
    );
  }

  Widget _buildStarRating(double score, {double size = 40, Color? color}) {
    int stars = 0;
    if (score >= 95) stars = 5;
    else if (score >= 85) stars = 4;
    else if (score >= 70) stars = 3;
    else if (score >= 50) stars = 2;
    else if (score >= 30) stars = 1;
    final starColor = color ?? Colors.amber.shade600;
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: List.generate(5, (index) {
      return Padding(padding: const EdgeInsets.symmetric(horizontal: 2), child: Icon(index < stars ? Icons.star : Icons.star_border, size: size, color: starColor, shadows: [Shadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 2, offset: const Offset(0, 1))]));
    }));
  }
}
