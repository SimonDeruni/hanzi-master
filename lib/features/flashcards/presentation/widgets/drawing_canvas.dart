import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hanzi_master/core/character_loader.dart';
import 'package:hanzi_master/features/flashcards/domain/services/stroke_grader.dart';

class DrawingCanvas extends StatefulWidget {
  final List<String> strokePaths; 
  final bool showAnimation; 
  final double animationSpeed; 
  final ValueNotifier<List<Offset?>>? userPointsNotifier; 
  final bool strokeByStrokeMode; 
  final int currentStrokeIndex; 
  final Function(int, Size)? onStrokeComplete; 
  final bool showControls; 
  final bool showGrade; 
  final List<Offset?>? initialUserPoints; 
  final List<List<Offset?>>? initialUserStrokes; 
  final bool readOnly; 
  final bool autoCenter; 
  final int? forcedActiveCharIndex; 

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
    this.forcedActiveCharIndex,
  });

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas>
    with TickerProviderStateMixin {
  final List<Offset?> _userPoints = [];
  final List<double> _userVelocities = []; // Store velocity for each point
  double? _gradingResult;
  DateTime? _lastPointTime;

  int _activeCharIndex = 0;
  Timer? _cycleTimer;

  late List<AnimationController> _characterControllers = [];
  late AnimationController _shakeController;

  bool _currentStrokeComplete = false;
  bool _showSnapStroke = false;

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
    _syncUserPointsWithNotifier();
    widget.userPointsNotifier?.addListener(_onExternalPointsChanged);
    _activeCharIndex = widget.forcedActiveCharIndex ?? _getCharacterIndexForStroke(widget.currentStrokeIndex);
    if (widget.showAnimation && _strokesByCharacter.length > 1 && widget.forcedActiveCharIndex == null) {
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
    if (widget.forcedActiveCharIndex != null) {
      _activeCharIndex = widget.forcedActiveCharIndex!;
    }
    final currentCharIndex = widget.forcedActiveCharIndex ?? _getCharacterIndexForStroke(widget.currentStrokeIndex);
    if (currentCharIndex != _activeCharIndex && !widget.showAnimation) {
      _activeCharIndex = currentCharIndex;
      setState(() {
        _userPoints.clear();
        _syncUserPointsWithNotifier();
        _currentStrokeComplete = false;
        _showSnapStroke = false;
      });
    } else if (widget.currentStrokeIndex != oldWidget.currentStrokeIndex) {
      setState(() {
        _currentStrokeComplete = false;
        _showSnapStroke = false;
      });
    }
  }

  void _syncUserPointsWithNotifier() {
    if (widget.userPointsNotifier != null) {
      widget.userPointsNotifier!.value = List.from(_userPoints);
    }
  }

  void _onExternalPointsChanged() {
    if (widget.userPointsNotifier != null) {
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
    if (currentGroup.isNotEmpty) groups.add(currentGroup);
    return groups.isEmpty ? [widget.strokePaths] : groups;
  }

  int _getCharacterIndexForStroke(int strokeIndex) {
    final charGroups = _strokesByCharacter;
    int count = 0;
    for (int i = 0; i < charGroups.length; i++) {
      count += charGroups[i].length;
      if (strokeIndex < count) return i;
    }
    return 0;
  }

  int _getStrokeOffsetForCharacter(int charIndex) {
    final charGroups = _strokesByCharacter;
    int offset = 0;
    for (int i = 0; i < charIndex; i++) {
      offset += charGroups[i].length;
    }
    return offset;
  }

  List<String> get _validStrokeStrings {
    return widget.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').toList();
  }

  List<Path> get _parsedPaths {
    return CharacterLoader.parseStrokes(_validStrokeStrings, normalize: true, autoCenter: false);
  }

  List<Path> _getParsedPathsForCharacter(List<String> strokes) {
    return CharacterLoader.parseStrokes(strokes, normalize: true, autoCenter: false);
  }

  void _gradeCurrentStroke() {
    if (!widget.strokeByStrokeMode) return;
    if (widget.currentStrokeIndex >= _parsedPaths.length) return;
    List<Offset> currentStroke = [];
    for (int i = _userPoints.length - 2; i >= 0; i--) {
      if (_userPoints[i] == null) break;
      currentStroke.insert(0, _userPoints[i]!);
    }
    if (currentStroke.length < 2) return;
    final score = StrokeGrader.gradeStrokes(
      referencePaths: [_parsedPaths[widget.currentStrokeIndex]],
      userPoints: currentStroke.cast<Offset?>(),
      canvasSize: const Size(1000, 1000),
    );
    setState(() {
      _gradingResult = score;
    });
    if (score > 60) {
      setState(() {
        _currentStrokeComplete = true;
        _showSnapStroke = true;
      });
      Future.delayed(const Duration(milliseconds: 50), () {
        if (widget.onStrokeComplete != null && mounted) {
          widget.onStrokeComplete!(widget.currentStrokeIndex, context.size ?? Size.zero);
        }
      });
    } else {
      _shakeController.forward(from: 0);
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

  Offset _getCenteringShift(List<Path> paths) {
    if (paths.isEmpty) return Offset.zero;
    Rect totalBounds = Rect.zero;
    bool first = true;
    for (final p in paths) {
      final b = p.getBounds();
      if (b.isEmpty) continue;
      if (first) { totalBounds = b; first = false; }
      else { totalBounds = totalBounds.expandToInclude(b); }
    }
    if (totalBounds.isEmpty) return Offset.zero;
    return Offset(500.0 - totalBounds.center.dx, 435.0 - totalBounds.center.dy);
  }

  List<Offset?> _applySmoothing(List<Offset?> points) {
    if (points.length < 5) return points;
    List<Offset?> smoothed = [];
    for (int i = 0; i < points.length; i++) {
      if (points[i] == null) {
        smoothed.add(null);
        continue;
      }
      double totalWeight = 0;
      double sumX = 0;
      double sumY = 0;
      for (int j = -2; j <= 2; j++) {
        int idx = i + j;
        if (idx >= 0 && idx < points.length && points[idx] != null) {
          double weight = (j == 0) ? 3.0 : (j.abs() == 1 ? 2.0 : 1.0);
          sumX += points[idx]!.dx * weight;
          sumY += points[idx]!.dy * weight;
          totalWeight += weight;
        }
      }
      smoothed.add(Offset(sumX / totalWeight, sumY / totalWeight));
    }
    return smoothed;
  }

  @override
  Widget build(BuildContext context) {
    final charGroups = _strokesByCharacter;
    final currentCharIndex = _activeCharIndex;
    final strokeOffset = _getStrokeOffsetForCharacter(currentCharIndex);
    final localCurrentIndex = widget.currentStrokeIndex - strokeOffset;
    final currentCharPaths = _getParsedPathsForCharacter(charGroups[currentCharIndex]);
    final centeringShift = _getCenteringShift(currentCharPaths);

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
        return Transform.translate(offset: Offset(shakeOffset, 0), child: child);
      },
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: widget.strokeByStrokeMode ? Colors.blue.shade300 : Colors.grey.withValues(alpha: 0.3),
              width: widget.strokeByStrokeMode ? 3.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              if (widget.showAnimation)
                IgnorePointer(
                  child: _DelayedAnimationWidget(
                    key: ValueKey('anim_$_activeCharIndex'),
                    delay: Duration.zero,
                    duration: Duration(milliseconds: (500 + currentCharPaths.length * 800).toInt()),
                    paths: currentCharPaths,
                    animationSpeed: widget.animationSpeed,
                    centeringShift: centeringShift,
                  ),
                ),
              if (widget.strokeByStrokeMode && localCurrentIndex < currentCharPaths.length)
                Positioned.fill(
                  child: IgnorePointer(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          key: ValueKey('guide_$_activeCharIndex'),
                          children: [
                            CustomPaint(
                              painter: _CompletedStrokesPainter(
                                paths: currentCharPaths.sublist(0, _currentStrokeComplete ? localCurrentIndex + 1 : localCurrentIndex),
                                centeringShift: centeringShift,
                              ),
                              size: constraints.biggest,
                            ),
                            if (!_currentStrokeComplete)
                              CustomPaint(
                                painter: _ReferenceStrokePainter(
                                  referencePath: currentCharPaths[localCurrentIndex],
                                  canvasSize: constraints.biggest,
                                  centeringShift: centeringShift,
                                ),
                                size: constraints.biggest,
                              ),
                          ],
                        );
                      }
                    ),
                  ),
                ),
              if (_showSnapStroke)
                IgnorePointer(
                  child: CustomPaint(
                    painter: _SnapStrokePainter(currentCharPaths[localCurrentIndex], centeringShift: centeringShift),
                    size: Size.infinite,
                  ),
                ),
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
                          color: _gradingResult == null ? Colors.black : (_gradingResult! > 40 ? Colors.green : Colors.red),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: widget.readOnly,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final size = constraints.biggest;
                      final scaleX = 1000.0 / size.width;
                      final scaleY = 1000.0 / size.height;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onPanStart: (details) {
                          if (widget.readOnly) return;
                          setState(() {
                            final normalizedPoint = Offset(
                              (details.localPosition.dx * scaleX) - centeringShift.dx,
                              (details.localPosition.dy * scaleY) - centeringShift.dy,
                            );
                            _userPoints.add(normalizedPoint);
                            _userVelocities.add(0.0); // Start with zero velocity
                            _lastPointTime = DateTime.now();

                            _syncUserPointsWithNotifier();
                            _gradingResult = null;
                            _showSnapStroke = false;
                            _currentStrokeComplete = false;
                          });
                        },
                        onPanUpdate: (details) {
                          if (widget.readOnly) return;
                          setState(() {
                            final now = DateTime.now();
                            final rawPoint = Offset(
                              (details.localPosition.dx * scaleX) - centeringShift.dx,
                              (details.localPosition.dy * scaleY) - centeringShift.dy,
                            );

                            // Calculate velocity (distance / time)
                            double velocity = 0;
                            if (_userPoints.isNotEmpty && _userPoints.last != null && _lastPointTime != null) {
                              double dist = (rawPoint - _userPoints.last!).distance;
                              int elapsed = now.difference(_lastPointTime!).inMilliseconds;
                              if (elapsed > 0) {
                                velocity = dist / elapsed;
                              }
                            }

                            _userPoints.add(rawPoint);
                            // Apply low-pass filter to velocity for smoothness
                            double lastVelocity = _userVelocities.isNotEmpty ? _userVelocities.last : 0.0;
                            _userVelocities.add(lastVelocity * 0.7 + velocity * 0.3);
                            _lastPointTime = now;

                            if (_userPoints.length > 3) {
                              final lastIdx = _userPoints.length - 1;
                              if (_userPoints[lastIdx] != null && _userPoints[lastIdx-1] != null && _userPoints[lastIdx-2] != null) {
                                _userPoints[lastIdx-1] = Offset(
                                  (_userPoints[lastIdx-2]!.dx + _userPoints[lastIdx-1]!.dx + _userPoints[lastIdx]!.dx) / 3,
                                  (_userPoints[lastIdx-2]!.dy + _userPoints[lastIdx-1]!.dy + _userPoints[lastIdx]!.dy) / 3,
                                );
                              }
                            }
                            _syncUserPointsWithNotifier();
                          });
                        },
                        onPanEnd: (details) {
                          if (widget.readOnly) return;
                          if (_userPoints.isNotEmpty) {
                            final smoothed = _applySmoothing(_userPoints);
                            _userPoints.clear();
                            _userPoints.addAll(smoothed);
                          }
                          setState(() {
                            _userPoints.add(null);
                            _userVelocities.add(0.0);
                            _syncUserPointsWithNotifier();
                          });
                          _gradeCurrentStroke();
                        },
                        child: CustomPaint(
                          painter: _UserDrawingPainter(
                            activeCharacterUserPoints, 
                            _gradingResult, 
                            centeringShift: centeringShift,
                            velocities: widget.initialUserStrokes != null ? null : _userVelocities,
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
      ),
    );
  }
}

class _UserDrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final List<double>? velocities;
  final double? gradingResult;
  final Offset centeringShift;
  _UserDrawingPainter(this.points, this.gradingResult, {required this.centeringShift, this.velocities});

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;
    final double baseWidth = scaleX * 28.0;

    final paint = Paint()
      ..color = gradingResult == null ? Colors.black87 : (gradingResult! > 40 ? Colors.green : Colors.red)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    if (points.isEmpty) return;

    List<List<int>> strokeIndices = [];
    List<int> currentStroke = [];

    for (int i = 0; i < points.length; i++) {
      if (points[i] == null) {
        if (currentStroke.isNotEmpty) {
          strokeIndices.add(List.from(currentStroke));
          currentStroke.clear();
        }
      } else {
        currentStroke.add(i);
      }
    }
    if (currentStroke.isNotEmpty) strokeIndices.add(currentStroke);

    for (final indices in strokeIndices) {
      if (indices.length < 2) continue;

      for (int i = 1; i < indices.length; i++) {
        final p1Idx = indices[i - 1];
        final p2Idx = indices[i];
        final p1 = points[p1Idx]!;
        final p2 = points[p2Idx]!;

        final pos1 = Offset((p1.dx + centeringShift.dx) * scaleX, (p1.dy + centeringShift.dy) * scaleY);
        final pos2 = Offset((p2.dx + centeringShift.dx) * scaleX, (p2.dy + centeringShift.dy) * scaleY);

        // Calculate dynamic width based on velocity if available
        double width = baseWidth;
        if (velocities != null && p2Idx < velocities!.length) {
          double v = velocities![p2Idx];
          // Slow = thicker (1.2x), Fast = thinner (0.6x)
          // Thresholds: 0.5 (slow) to 3.0 (fast)
          double factor = 1.0;
          if (v < 0.5) factor = 1.2;
          else if (v > 3.0) factor = 0.6;
          else {
            // Linear interpolation between 0.5 and 3.0
            factor = 1.2 - ((v - 0.5) / 2.5) * 0.6;
          }
          width = baseWidth * factor;
        }

        // Apply tapering at the very start and end of the stroke
        if (i < 5) width *= (0.4 + (i / 5.0) * 0.6);
        if (i > indices.length - 5) width *= (0.4 + (indices.length - i) / 5.0 * 0.6);

        paint.strokeWidth = width;
        canvas.drawLine(pos1, pos2, paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant _UserDrawingPainter oldDelegate) => true;
}

class _SnapStrokePainter extends CustomPainter {
  final Path strokePath;
  final Offset centeringShift;
  _SnapStrokePainter(this.strokePath, {required this.centeringShift});
  @override
  void paint(Canvas canvas, Size size) {
    if (strokePath.getBounds().isEmpty) return;
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);
    canvas.translate(centeringShift.dx, centeringShift.dy);
    final paint = Paint()
      ..color = Colors.green.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0)
      ..isAntiAlias = true;
    canvas.drawPath(strokePath, paint);
    canvas.restore();
  }
  @override
  bool shouldRepaint(covariant _SnapStrokePainter oldDelegate) => oldDelegate.strokePath != strokePath;
}

class _DelayedAnimationWidget extends StatefulWidget {
  final Duration delay;
  final Duration duration;
  final List<Path> paths;
  final double animationSpeed;
  final Offset centeringShift;
  const _DelayedAnimationWidget({super.key, required this.delay, required this.duration, required this.paths, required this.animationSpeed, required this.centeringShift});
  @override
  State<_DelayedAnimationWidget> createState() => _DelayedAnimationWidgetState();
}

class _DelayedAnimationWidgetState extends State<_DelayedAnimationWidget> {
  late bool _shouldShowAnimation = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () { if (mounted) setState(() => _shouldShowAnimation = true); });
  }
  @override
  Widget build(BuildContext context) {
    if (!_shouldShowAnimation) return const SizedBox.expand();
    return Opacity(opacity: 0.4, child: _CustomFilledStrokeAnimation(paths: widget.paths, duration: widget.duration, centeringShift: widget.centeringShift));
  }
}

class _CustomFilledStrokeAnimation extends StatefulWidget {
  final List<Path> paths;
  final Duration duration;
  final Offset centeringShift;
  const _CustomFilledStrokeAnimation({required this.paths, required this.duration, required this.centeringShift});
  @override
  State<_CustomFilledStrokeAnimation> createState() => _CustomFilledStrokeAnimationState();
}

class _CustomFilledStrokeAnimationState extends State<_CustomFilledStrokeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..forward();
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox.expand(child: CustomPaint(painter: _SequentialFilledStrokePainter(paths: widget.paths, progress: _controller.value, centeringShift: widget.centeringShift)));
      },
    );
  }
}

class _SequentialFilledStrokePainter extends CustomPainter {
  final List<Path> paths;
  final double progress;
  final Offset centeringShift;
  _SequentialFilledStrokePainter({required this.paths, required this.progress, required this.centeringShift});
  @override
  void paint(Canvas canvas, Size size) {
    if (paths.isEmpty || size.width == 0 || size.height == 0) return;
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);
    canvas.translate(centeringShift.dx, centeringShift.dy);
    final paint = Paint()..style = PaintingStyle.fill..color = Colors.grey.shade600..isAntiAlias = true;
    final totalStrokes = paths.length;
    final currentStrokeFloat = progress * totalStrokes;
    final completedStrokes = currentStrokeFloat.floor();
    final currentStrokeProgress = currentStrokeFloat - completedStrokes;
    for (int i = 0; i < completedStrokes && i < paths.length; i++) canvas.drawPath(paths[i], paint);
    if (completedStrokes < paths.length && currentStrokeProgress > 0) {
      final currentPath = paths[completedStrokes];
      final metrics = currentPath.computeMetrics().toList();
      if (metrics.isNotEmpty) {
        final partialPath = Path();
        for (final metric in metrics) {
          final extracted = metric.extractPath(0, metric.length * currentStrokeProgress);
          partialPath.addPath(extracted, Offset.zero);
        }
        final strokePaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 40.0..color = Colors.grey.shade600..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round..isAntiAlias = true;
        canvas.drawPath(partialPath, strokePaint);
      }
    }
    canvas.restore();
  }
  @override
  bool shouldRepaint(_SequentialFilledStrokePainter oldDelegate) => oldDelegate.progress != progress;
}

class _ReferenceStrokePainter extends CustomPainter {
  final Path referencePath;
  final Size canvasSize;
  final bool hideDots;
  final Offset centeringShift;
  _ReferenceStrokePainter({required this.referencePath, required this.canvasSize, required this.centeringShift, this.hideDots = false});
  @override
  void paint(Canvas canvas, Size size) {
    if (referencePath.getBounds().isEmpty) return;
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);
    canvas.translate(centeringShift.dx, centeringShift.dy);
    final strokePaint = Paint()..style = PaintingStyle.fill..color = Colors.blue.withValues(alpha: 0.3)..isAntiAlias = true;
    canvas.drawPath(referencePath, strokePaint);
    final highlightPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2.0..color = Colors.lightBlue.withValues(alpha: 0.6)..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round..isAntiAlias = true;
    canvas.drawPath(referencePath, highlightPaint);
    if (!hideDots) {
      final metrics = referencePath.computeMetrics().toList();
      if (metrics.isNotEmpty) {
        final metric = metrics.first;
        List<Offset> samples = [];
        for (double i = 0; i <= 1.0; i += 0.01) samples.add(metric.getTangentForOffset(metric.length * i)!.position);
        double maxDistSq = -1;
        Offset tipA = samples.first;
        Offset tipB = samples.last;
        for (int i = 0; i < samples.length; i++) {
          for (int j = i + 1; j < samples.length; j++) {
            double d = (samples[i] - samples[j]).distanceSquared;
            if (d > maxDistSq) { maxDistSq = d; tipA = samples[i]; tipB = samples[j]; }
          }
        }
        Offset startTip, endTip;
        double scoreA = (tipA.dy * 1.5) + tipA.dx;
        double scoreB = (tipB.dy * 1.5) + tipB.dx;
        if (scoreA < scoreB) { startTip = tipA; endTip = tipB; } else { startTip = tipB; endTip = tipA; }
        Offset startPos = Offset.zero;
        Offset endPos = Offset.zero;
        int sCount = 0, eCount = 0;
        for (final p in samples) {
          if ((p - startTip).distance < 50.0) { startPos += p; sCount++; }
          if ((p - endTip).distance < 50.0) { endPos += p; eCount++; }
        }
        startPos = sCount > 0 ? startPos / sCount.toDouble() : startTip;
        endPos = eCount > 0 ? endPos / eCount.toDouble() : endTip;
        canvas.drawCircle(startPos, 22.0, Paint()..color = Colors.green.withValues(alpha: 0.4)..style = PaintingStyle.fill);
        canvas.drawCircle(startPos, 8.0, Paint()..color = Colors.green..style = PaintingStyle.fill);
        canvas.drawCircle(endPos, 22.0, Paint()..color = Colors.red.withValues(alpha: 0.2)..style = PaintingStyle.fill);
        canvas.drawCircle(endPos, 8.0, Paint()..color = Colors.red..style = PaintingStyle.fill);
      }
    }
    canvas.restore();
  }
  @override
  bool shouldRepaint(_ReferenceStrokePainter oldDelegate) => oldDelegate.referencePath != referencePath;
}

class _CompletedStrokesPainter extends CustomPainter {
  final List<Path> paths;
  final Offset centeringShift;
  _CompletedStrokesPainter({required this.paths, required this.centeringShift});
  @override
  void paint(Canvas canvas, Size size) {
    if (paths.isEmpty) return;
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);
    canvas.translate(centeringShift.dx, centeringShift.dy);
    final bloomPaint = Paint()..color = Colors.black.withValues(alpha: 0.15)..style = PaintingStyle.stroke..strokeWidth = 2.0..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0)..isAntiAlias = true;
    final inkPaint = Paint()..color = Colors.black87..style = PaintingStyle.fill..isAntiAlias = true;
    for (final path in paths) { canvas.drawPath(path, bloomPaint); canvas.drawPath(path, inkPaint); }
    canvas.restore();
  }
  @override
  bool shouldRepaint(_CompletedStrokesPainter oldDelegate) => oldDelegate.paths.length != paths.length || oldDelegate.centeringShift != centeringShift;
}