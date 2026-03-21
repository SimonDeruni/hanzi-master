import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hanzi_master/core/character_loader.dart';
import 'package:hanzi_master/features/flashcards/domain/services/stroke_grader.dart';
import 'package:path_drawing/path_drawing.dart'; // To parse the data


class DrawingCanvas extends StatefulWidget {
  final List<String> strokePaths; // Data from the internet
  final bool showAnimation; // Do you want to see the guide?
  final double animationSpeed; // Multiplier for animation speed (1.0 = normal)
  final ValueNotifier<List<Offset?>>? userPointsNotifier; // Optional notifier to sync user points
  final bool strokeByStrokeMode; // Enable stroke-by-stroke learning mode
  final int currentStrokeIndex; // Which stroke should the user draw (0-indexed)
  final Function(int, Size)? onStrokeComplete; // Callback when a stroke is completed
  final bool showControls; // Show replay and clear buttons
  final bool showGrade; // Show the grade text at the bottom
  final List<Offset?>? initialUserPoints; // To show a static version (Deprecated)
  final List<List<Offset?>>? initialUserStrokes; // Strokes grouped by character
  final bool readOnly; // Disable all interaction
  final bool autoCenter; // Force character to center of canvas

  const DrawingCanvas({
    super.key,
    required this.strokePaths,
    this.showAnimation = true,
    this.animationSpeed = 1.0,
    this.userPointsNotifier,
    this.strokeByStrokeMode = false,
    this.currentStrokeIndex = 0,
    this.onStrokeComplete,
    this.showControls = true,
    this.showGrade = true,
    this.initialUserPoints,
    this.initialUserStrokes,
    this.readOnly = false,
    this.autoCenter = false,
  });

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas>
    with TickerProviderStateMixin {
  // 🖍️ STUDENT DATA: Points drawn by the user
  final List<Offset?> _userPoints = [];
  double? _gradingResult;

  // Track which character we are currently on
  int _activeCharIndex = 0;
  Timer? _cycleTimer;

  // Animation controllers for sequential character animation
  late List<AnimationController> _characterControllers = [];
  late AnimationController _shakeController;

    // Stroke-by-stroke mode tracking
    bool _currentStrokeComplete = false;
    bool _showSnapStroke = false;
  
    // Getter to access user points
    List<Offset?> get userPoints => _userPoints;
  
    @override
    void initState() {
      super.initState();
      if (widget.initialUserPoints != null) {
        _userPoints.addAll(widget.initialUserPoints!);
      }
      _setupCharacterAnimations();
      _shakeController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      // Sync user points with notifier if provided
      _syncUserPointsWithNotifier();
      // Listen to external changes to the notifier
      widget.userPointsNotifier?.addListener(_onExternalPointsChanged);
      
      _activeCharIndex = _getCharacterIndexForStroke(widget.currentStrokeIndex);

      // Start cycling timer if in solution/animation mode for multi-char words
      if (widget.showAnimation && _strokesByCharacter.length > 1) {
        _startCycling();
      }
    }

    void _startCycling() {
      _cycleTimer?.cancel();
      _cycleTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
        if (!mounted) return;
        setState(() {
          _activeCharIndex = (_activeCharIndex + 1) % _strokesByCharacter.length;
        });
      });
    }

    @override
    void didUpdateWidget(DrawingCanvas oldWidget) {
      super.didUpdateWidget(oldWidget);
      final currentCharIndex = _getCharacterIndexForStroke(widget.currentStrokeIndex);
      
      // If character changed, clear everything
      if (currentCharIndex != _activeCharIndex && !widget.showAnimation) {
        _activeCharIndex = currentCharIndex;
        setState(() {
          _userPoints.clear();
          _syncUserPointsWithNotifier();
          _currentStrokeComplete = false;
          _showSnapStroke = false;
          // Keep _gradingResult so user can see their last score
        });
      } 
      // CRITICAL: If just the stroke index changed, reset the snap flags!
      else if (widget.currentStrokeIndex != oldWidget.currentStrokeIndex) {
        setState(() {
          _currentStrokeComplete = false;
          _showSnapStroke = false;
          // Keep _gradingResult so user can see their last score
        });
      }
    }
  
    void _syncUserPointsWithNotifier() {
  
          if (widget.userPointsNotifier != null) {
  
            widget.userPointsNotifier!.value = _userPoints;
  
          }
  
        }
  
    void _onExternalPointsChanged() {
      if (widget.userPointsNotifier != null) {
        // If the external notifier was cleared, clear our internal points too
        if (widget.userPointsNotifier!.value.isEmpty && _userPoints.isNotEmpty) {
          setState(() {
            _userPoints.clear();
            _currentStrokeComplete = false;
            _showSnapStroke = false;
          });
        }
      }
    }
  
    @override
    void dispose() {
      _cycleTimer?.cancel();
      for (final controller in _characterControllers) {
        controller.dispose();
      }
      _shakeController.dispose();
      widget.userPointsNotifier?.removeListener(_onExternalPointsChanged);
      super.dispose();
    }
  
    void _setupCharacterAnimations() {
      final charGroups = _strokesByCharacter;
      _characterControllers = List.generate(charGroups.length, (index) {
        return AnimationController(vsync: this);
      });
    }
  
    // Split strokes by character separator
    List<List<String>> get _strokesByCharacter {
      final groups = <List<String>>[];
      var currentGroup = <String>[];
  
      for (final stroke in widget.strokePaths) {
        if (stroke == '__CHAR_SEPARATOR__') {
          if (currentGroup.isNotEmpty) {
            groups.add(currentGroup);
            currentGroup = [];
          }
        } else {
          currentGroup.add(stroke);
        }
      }
  
      if (currentGroup.isNotEmpty) {
        groups.add(currentGroup);
      }
  
      return groups.isEmpty ? [widget.strokePaths] : groups;
    }

    // Helper to find which character a global stroke index belongs to
    int _getCharacterIndexForStroke(int strokeIndex) {
      final charGroups = _strokesByCharacter;
      int count = 0;
      for (int i = 0; i < charGroups.length; i++) {
        count += charGroups[i].length;
        if (strokeIndex < count) return i;
      }
      return 0;
    }

    // Helper to get the start index of a character in the global stroke list
    int _getStrokeOffsetForCharacter(int charIndex) {
      final charGroups = _strokesByCharacter;
      int offset = 0;
      for (int i = 0; i < charIndex; i++) {
        offset += charGroups[i].length;
      }
      return offset;
    }
  
    // Helper to get only valid drawable paths (filtering out separators)
    List<String> get _validStrokeStrings {
      return widget.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').toList();
    }

    // 🤖 TEACHER DATA: Converted SVG paths
    List<Path> get _parsedPaths {
      return CharacterLoader.parseStrokes(_validStrokeStrings, normalize: true, autoCenter: widget.autoCenter);
    }
  
    // Get parsed paths for a specific character group
    List<Path> _getParsedPathsForCharacter(List<String> strokes) {
      return CharacterLoader.parseStrokes(strokes, normalize: true, autoCenter: widget.autoCenter);
    }
  
    // Method to replay the animation
    void _replayAnimation() {
      _setupCharacterAnimations(); // Re-init controllers
      for (final controller in _characterControllers) {
        controller.forward(from: 0);
      }
      setState(() {});
    }
  
    // Check if current stroke is complete (in stroke-by-stroke mode)
    void _gradeCurrentStroke() {
      if (!widget.strokeByStrokeMode) return;
      
      final validStrings = _validStrokeStrings;
      if (widget.currentStrokeIndex >= validStrings.length) return;
  
      // Get current user stroke (points since last pen lift)
      List<Offset> currentStroke = [];
      // Last point is null, so start from length - 2
      for (int i = _userPoints.length - 2; i >= 0; i--) {
        if (_userPoints[i] == null) break;
        currentStroke.insert(0, _userPoints[i]!);
      }
  
      if (currentStroke.length < 2) return; // Need at least 2 points to form a line
  
      final score = StrokeGrader.gradeStrokes(
        referencePaths: [_parsedPaths[widget.currentStrokeIndex]],
        userPoints: currentStroke.cast<Offset?>(),
        canvasSize: const Size(1000, 1000), // Points are already normalized
      );
  
      setState(() {
        _gradingResult = score;
      });
  
      // Lenient threshold for guided mode
      if (score > 40) {
        setState(() {
          _currentStrokeComplete = true;
          _showSnapStroke = true;
        });
  
        // Trigger callback after a delay for visual feedback
        Future.delayed(const Duration(milliseconds: 50), () {
          if (widget.onStrokeComplete != null && mounted) {
            widget.onStrokeComplete!(widget.currentStrokeIndex, context.size ?? Size.zero);
          }
        });
      } else {
        _shakeController.forward(from: 0);
        // Automatically clear failed stroke after a brief delay so user can try again
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && !_currentStrokeComplete) {
            setState(() {
              _userPoints.clear();
              _syncUserPointsWithNotifier();
              _gradingResult = null;
            });
          }
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    final charGroups = _strokesByCharacter;
    final currentCharIndex = _activeCharIndex;
    final strokeOffset = _getStrokeOffsetForCharacter(currentCharIndex);
    final localCurrentIndex = widget.currentStrokeIndex - strokeOffset;
    final currentCharPaths = _getParsedPathsForCharacter(charGroups[currentCharIndex]);

    // Extract strokes for the CURRENT active character if in historical mode
    List<Offset?> activeCharacterUserPoints = List.from(_userPoints);
    if (widget.initialUserStrokes != null) {
      final offset = _getStrokeOffsetForCharacter(currentCharIndex);
      final count = charGroups[currentCharIndex].length;
      
      activeCharacterUserPoints = widget.initialUserStrokes!
          .skip(offset)
          .take(count)
          .expand((s) => [...s, null])
          .toList();
    }

    return AnimatedBuilder(
        animation: _shakeController,
        builder: (context, child) {
          final shakeOffset = sin(pi * 4 * _shakeController.value) * 10;
          return Transform.translate(
            offset: Offset(shakeOffset, 0),
            child: child,
          );
        },
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: widget.strokeByStrokeMode
                    ? Colors.blue.shade300
                    : Colors.grey.withValues(alpha: 0.3),
                width: widget.strokeByStrokeMode ? 3.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                // LAYER 1: THE TEACHER (Ghost Animation)
                if (widget.showAnimation)
                  IgnorePointer(
                    child: _DelayedAnimationWidget(
                      key: ValueKey('anim_$_activeCharIndex'), // Force restart on cycle
                      delay: Duration.zero,
                      duration: Duration(milliseconds: (300 + currentCharPaths.length * 400).toInt()),
                      paths: currentCharPaths,
                      animationSpeed: widget.animationSpeed,
                    ),
                  ),

                // LAYER 2: GUIDANCE & PERSISTENCE (Local to current character)
                if (widget.strokeByStrokeMode && localCurrentIndex < currentCharPaths.length)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            key: ValueKey('guide_$_activeCharIndex'), // Force reset on cycle
                            children: [
                              // Draw completed strokes for the ACTIVE character
                              CustomPaint(
                                painter: _CompletedStrokesPainter(
                                  paths: currentCharPaths.sublist(0, 
                                    _currentStrokeComplete ? localCurrentIndex + 1 : localCurrentIndex
                                  ),
                                ),
                                size: constraints.biggest,
                              ),
                              // Draw CURRENT guide if not successfully drawn
                              if (!_currentStrokeComplete)
                                CustomPaint(
                                  painter: _ReferenceStrokePainter(
                                    referencePath: currentCharPaths[localCurrentIndex],
                                    canvasSize: constraints.biggest,
                                  ),
                                  size: constraints.biggest,
                                ),
                            ],
                          );
                        }
                      ),
                    ),
                  ),

                // LAYER 4: SNAPPED STROKE
                if (_showSnapStroke)
                  IgnorePointer(
                    child: CustomPaint(
                      painter: _SnapStrokePainter(
                        currentCharPaths[localCurrentIndex],
                      ),
                      size: Size.infinite,
                    ),
                  ),

                // LAYER 5: UI & FALLBACKS (Moved below drawing layer)
                if (widget.showGrade)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Grade: ${_gradingResult?.toStringAsFixed(2) ?? "N/A"}',
                          style: TextStyle(
                            color: _gradingResult == null
                                ? Colors.black
                                : (_gradingResult! > 40 ? Colors.green : Colors.red),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                // LAYER 3: STUDENT DRAWING (ABSOLUTE TOP for guaranteed touch)
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: widget.readOnly,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final size = constraints.biggest;
                        final scaleX = 1000.0 / size.width;
                        final scaleY = 1000.0 / size.height;

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque, // Ensure it catches all hits
                          onPanStart: (details) {
                            if (widget.readOnly) return;
                            setState(() {
                              final normalizedPoint = Offset(
                                details.localPosition.dx * scaleX,
                                details.localPosition.dy * scaleY,
                              );
                              _userPoints.add(normalizedPoint);
                              _syncUserPointsWithNotifier();
                              _gradingResult = null;
                              _showSnapStroke = false;
                              _currentStrokeComplete = false;
                            });
                          },
                          onPanUpdate: (details) {
                            if (widget.readOnly) return;
                            setState(() {
                              final normalizedPoint = Offset(
                                details.localPosition.dx * scaleX,
                                details.localPosition.dy * scaleY,
                              );
                              _userPoints.add(normalizedPoint);
                              _syncUserPointsWithNotifier();
                            });
                          },
                          onPanEnd: (details) {
                            if (widget.readOnly) return;
                            setState(() {
                              _userPoints.add(null);
                              _syncUserPointsWithNotifier();
                            });
                            _gradeCurrentStroke();
                          },
                          child: CustomPaint(
                            painter: _UserDrawingPainter(
                              activeCharacterUserPoints,
                              _gradingResult,
                              autoCenter: widget.autoCenter,
                            ),
                            size: Size.infinite,
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // Helper to build a single character's canvas with sequential animation
  Widget _buildCharacterCanvas(
      List<List<String>> allCharGroups, int charIndex, int totalChars) {
    final charStrokes = allCharGroups[charIndex];
    final parsedPaths = _getParsedPathsForCharacter(charStrokes);

    // Calculate which strokes belong to this specific character
    int strokeOffset = 0;
    for (int i = 0; i < charIndex; i++) {
      strokeOffset += allCharGroups[i].length;
    }
    
    final int localCurrentIndex = widget.currentStrokeIndex - strokeOffset;
    final bool isActiveChar = localCurrentIndex >= 0 && localCurrentIndex < parsedPaths.length;

    // Calculate duration for this character based on its stroke count
    final animationDuration =
        (300 + parsedPaths.length * 400) / widget.animationSpeed;

    // Calculate delay: sum of all previous character durations
    int cumulativeDelay = 0;
    for (int i = 0; i < charIndex; i++) {
      final prevPaths = _getParsedPathsForCharacter(allCharGroups[i]);
      final prevDuration =
          (300 + prevPaths.length * 400) / widget.animationSpeed;
      cumulativeDelay += prevDuration.toInt();
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: charStrokes != _strokesByCharacter.last
              ? BorderSide(color: Colors.grey.shade300)
              : BorderSide.none,
        ),
      ),
      child: IgnorePointer(
        child: Stack(
          children: [
            if (charStrokes.isNotEmpty && widget.showAnimation)
              _DelayedAnimationWidget(
                key: ValueKey('char_anim_$charIndex'),
                delay: Duration(milliseconds: cumulativeDelay),
                duration: Duration(milliseconds: animationDuration.toInt()),
                paths: parsedPaths,
                animationSpeed: widget.animationSpeed,
              ),
            
            // Guided Mode Visuals for this character box
            if (widget.strokeByStrokeMode) ...[
              // 1. Draw completed strokes for this character
              // If current stroke is complete, include it in the black strokes
              CustomPaint(
                painter: _CompletedStrokesPainter(
                  paths: parsedPaths.sublist(0, 
                    _currentStrokeComplete && isActiveChar 
                      ? localCurrentIndex + 1 
                      : (isActiveChar ? localCurrentIndex : (widget.currentStrokeIndex > strokeOffset ? parsedPaths.length : 0))
                  ),
                ),
                size: Size.infinite,
              ),

              // 2. Draw current guide if it's in this character and not yet successfully drawn
              if (isActiveChar && !_currentStrokeComplete)
                CustomPaint(
                  painter: _ReferenceStrokePainter(
                    referencePath: parsedPaths[localCurrentIndex],
                    canvasSize: Size.infinite,
                  ),
                  size: Size.infinite,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

// 🎨 PAINTER FOR USER INPUT
class _UserDrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final double? gradingResult;
  final bool autoCenter;
  
  _UserDrawingPainter(this.points, this.gradingResult, {this.autoCenter = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gradingResult == null
          ? Colors.black87
          : (gradingResult! > 40 ? Colors.green : Colors.red)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 12.0
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    if (points.isEmpty) return;

    // 1. Calculate Bounding Box if centering is needed
    Offset shift = Offset.zero;
    if (autoCenter) {
      Rect bounds = Rect.zero;
      bool first = true;
      for (final p in points) {
        if (p == null) continue;
        if (first) { 
          bounds = Rect.fromPoints(p, p); 
          first = false; 
        } else { 
          bounds = bounds.expandToInclude(Rect.fromPoints(p, p)); 
        }
      }
      if (!bounds.isEmpty) {
        shift = Offset(500.0 - bounds.center.dx, 400.0 - bounds.center.dy);
      }
    }

    // 2. Scale and Translate
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;

    final path = Path();
    bool needsMove = true;

    for (final point in points) {
      if (point == null) {
        needsMove = true;
        continue;
      }
      
      // Apply shift (if autoCenter) and then scale
      final processedPoint = Offset(
        (point.dx + shift.dx) * scaleX,
        (point.dy + shift.dy) * scaleY,
      );

      if (needsMove) {
        path.moveTo(processedPoint.dx, processedPoint.dy);
        final dotPaint = Paint()
          ..color = paint.color
          ..style = PaintingStyle.fill;
        canvas.drawCircle(processedPoint, paint.strokeWidth / 2, dotPaint);
        needsMove = false;
      } else {
        path.lineTo(processedPoint.dx, processedPoint.dy);
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _UserDrawingPainter oldDelegate) {
    return true;
  }
}

class _SnapStrokePainter extends CustomPainter {
  final Path strokePath;

  _SnapStrokePainter(this.strokePath);

  @override
  void paint(Canvas canvas, Size size) {
    if (strokePath.getBounds().isEmpty) return;

    // Scale from 1000x1000 normalized space to actual canvas size
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    final paint = Paint()
      ..color = Colors.green.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawPath(strokePath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SnapStrokePainter oldDelegate) {
    return oldDelegate.strokePath != strokePath;
  }
}
                       
// Helper widget to handle sequential animations with delays
class _DelayedAnimationWidget extends StatefulWidget {
  final Duration delay;
  final Duration duration;
  final List<Path> paths;
  final double animationSpeed;

  const _DelayedAnimationWidget({
    super.key,
    required this.delay,
    required this.duration,
    required this.paths,
    required this.animationSpeed,
  });

  @override
  State<_DelayedAnimationWidget> createState() => _DelayedAnimationWidgetState();
}
class _DelayedAnimationWidgetState extends State<_DelayedAnimationWidget> {
  late bool _shouldShowAnimation = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _shouldShowAnimation = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShowAnimation) {
      return const SizedBox.expand();
    }

    return Opacity(
      opacity: 0.4,
      child: _CustomFilledStrokeAnimation(
        paths: widget.paths,
        duration: widget.duration,
      ),
    );
  }
}

// Custom animation widget that fades in filled strokes sequentially
class _CustomFilledStrokeAnimation extends StatefulWidget {
  final List<Path> paths;
  final Duration duration;

  const _CustomFilledStrokeAnimation({
    required this.paths,
    required this.duration,
  });

  @override
  State<_CustomFilledStrokeAnimation> createState() => _CustomFilledStrokeAnimationState();
}

class _CustomFilledStrokeAnimationState extends State<_CustomFilledStrokeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox.expand(
          child: CustomPaint(
            painter: _SequentialFilledStrokePainter(
              paths: widget.paths,
              progress: _controller.value,
            ),
          ),
        );
      },
    );
  }
}

// Painter that draws filled strokes sequentially
class _SequentialFilledStrokePainter extends CustomPainter {
  final List<Path> paths;
  final double progress; // 0.0 to 1.0

  _SequentialFilledStrokePainter({
    required this.paths,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (paths.isEmpty || size.width == 0 || size.height == 0) return;

    // Scale from 1000x1000 normalized space to actual canvas size
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey.shade600
      ..isAntiAlias = true;

    // Calculate progress
    final totalStrokes = paths.length;
    final currentStrokeFloat = progress * totalStrokes;
    final completedStrokes = currentStrokeFloat.floor();
    final currentStrokeProgress = currentStrokeFloat - completedStrokes;

    // Draw completed strokes
    for (int i = 0; i < completedStrokes && i < paths.length; i++) {
      canvas.drawPath(paths[i], paint);
    }

    // Draw current stroke
    if (completedStrokes < paths.length && currentStrokeProgress > 0) {
      final currentPath = paths[completedStrokes];
      final metrics = currentPath.computeMetrics().toList();
      
      if (metrics.isNotEmpty) {
        final partialPath = Path();
        for (final metric in metrics) {
          final extracted = metric.extractPath(0, metric.length * currentStrokeProgress);
          partialPath.addPath(extracted, Offset.zero);
        }
        
        final strokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 40.0 // Thick stroke for 'filled' look
          ..color = Colors.grey.shade600
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..isAntiAlias = true;
        canvas.drawPath(partialPath, strokePaint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_SequentialFilledStrokePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Painter to show the reference stroke in stroke-by-stroke mode
class _ReferenceStrokePainter extends CustomPainter {
  final Path referencePath;
  final Size canvasSize;
  final bool hideDots;

  _ReferenceStrokePainter({
    required this.referencePath,
    required this.canvasSize,
    this.hideDots = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (referencePath.getBounds().isEmpty) return;

    // Scale from 1000x1000 normalized space to actual canvas size
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    // Draw filled guide
    final strokePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue.withValues(alpha: 0.3)
      ..isAntiAlias = true;
    canvas.drawPath(referencePath, strokePaint);

    // Add inner highlight
    final highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.lightBlue.withValues(alpha: 0.6)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    canvas.drawPath(referencePath, highlightPaint);

    // Draw Start and End hints for Guided Mode
    if (!hideDots) {
      final metrics = referencePath.computeMetrics().toList();
      if (metrics.isNotEmpty) {
        final metric = metrics.first;
        
        // 1. Sample perimeter points
        List<Offset> samples = [];
        for (double i = 0; i <= 1.0; i += 0.01) {
          samples.add(metric.getTangentForOffset(metric.length * i)!.position);
        }

        // 2. Find the two physical tips (furthest apart)
        double maxDistSq = -1;
        Offset tipA = samples.first;
        Offset tipB = samples.last;
        for (int i = 0; i < samples.length; i++) {
          for (int j = i + 1; j < samples.length; j++) {
            double d = (samples[i] - samples[j]).distanceSquared;
            if (d > maxDistSq) {
              maxDistSq = d;
              tipA = samples[i];
              tipB = samples[j];
            }
          }
        }

        // 3. CALLIGRAPHY SCORE ORIENTATION
        // Formula: (Y * 1.5) + X. Lower score = closer to Top-Left (Standard Start).
        Offset startTip, endTip;
        
        double scoreA = (tipA.dy * 1.5) + tipA.dx;
        double scoreB = (tipB.dy * 1.5) + tipB.dx;

        if (scoreA < scoreB) {
          startTip = tipA; endTip = tipB;
        } else {
          startTip = tipB; endTip = tipA;
        }

        // 4. Centroid Refinement (Move dots to center of caps)
        Offset startPos = Offset.zero, endPos = Offset.zero;
        int sCount = 0, eCount = 0;
        for (final p in samples) {
          if ((p - startTip).distance < 50.0) { startPos += p; sCount++; }
          if ((p - endTip).distance < 50.0) { endPos += p; eCount++; }
        }
        startPos = sCount > 0 ? startPos / sCount.toDouble() : startTip;
        endPos = eCount > 0 ? endPos / eCount.toDouble() : endTip;

        // 5. Draw the guidance dots
        canvas.drawCircle(startPos, 22.0, Paint()..color = Colors.green.withValues(alpha: 0.4)..style = PaintingStyle.fill);
        canvas.drawCircle(startPos, 8.0, Paint()..color = Colors.green..style = PaintingStyle.fill);
        
        canvas.drawCircle(endPos, 22.0, Paint()..color = Colors.red.withValues(alpha: 0.2)..style = PaintingStyle.fill);
        canvas.drawCircle(endPos, 8.0, Paint()..color = Colors.red..style = PaintingStyle.fill);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_ReferenceStrokePainter oldDelegate) {
    return oldDelegate.referencePath != referencePath;
  }
}

// Painter to show all finished strokes in black
class _CompletedStrokesPainter extends CustomPainter {
  final List<Path> paths;

  _CompletedStrokesPainter({required this.paths});

  @override
  void paint(Canvas canvas, Size size) {
    if (paths.isEmpty) return;

    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    final paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (final path in paths) {
      canvas.drawPath(path, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CompletedStrokesPainter oldDelegate) {
    return oldDelegate.paths.length != paths.length;
  }
}