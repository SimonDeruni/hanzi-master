import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/character_loader.dart';
import 'package:hanzi_master/core/stroke_matcher.dart';

class DrawingCanvas extends StatefulWidget {
  final List<String> strokePaths;
  final List<List<Offset>> medianPaths;
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
  final double masteryLevel;
  final int? strokeLimit;
  final bool autoActiveChar;
  final bool isFlipped;
  final bool showReference;
  final bool showGuideLines;
  final Color referenceColor;
  final bool strictGrading;

  const DrawingCanvas({
    super.key,
    required this.strokePaths,
    this.medianPaths = const [],
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
    this.masteryLevel = 0.0,
    this.strokeLimit,
    this.autoActiveChar = false,
    this.isFlipped = false,
    this.showReference = true,
    this.showGuideLines = true,
    this.referenceColor = Colors.blue,
    this.strictGrading = true,
  });

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> with TickerProviderStateMixin {
  final List<Offset?> _userPoints = [];
  double? _gradingResult;
  int _activeCharIndex = 0;
  Timer? _cycleTimer;
  late AnimationController _shakeController;
  bool _currentStrokeComplete = false;
  bool _showSnapStroke = false;
  List<List<String>> _cachedCharGroups = [];
  List<Path> _cachedParsedPaths = [];

  bool _isHintAnimating = false;
  late AnimationController _hintController;

  @override
  void initState() {
    super.initState();
    if (widget.initialUserPoints != null) _userPoints.addAll(widget.initialUserPoints!);
    _shakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _hintController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _syncUserPointsWithNotifier();
    widget.userPointsNotifier?.addListener(_onExternalPointsChanged);
    _refreshData();
    if (widget.showAnimation && _cachedCharGroups.length > 1 && widget.forcedActiveCharIndex == null) {
      _startCycling();
    }
  }

  void _refreshData() {
    _cachedCharGroups = _groupStrokes(widget.strokePaths);
    if (widget.forcedActiveCharIndex != null) {
      _activeCharIndex = widget.forcedActiveCharIndex!;
    } else if (widget.autoActiveChar && widget.strokeLimit != null) {
      _activeCharIndex = _getCharacterIndexForStroke(widget.strokeLimit! - 1);
    } else {
      _activeCharIndex = widget.forcedActiveCharIndex ?? _getCharacterIndexForStroke(widget.currentStrokeIndex);
    }
    if (_activeCharIndex < _cachedCharGroups.length) {
      _cachedParsedPaths = CharacterLoader.parseStrokes(_cachedCharGroups[_activeCharIndex], normalize: true, isFlipped: widget.isFlipped);
    }
  }

  List<List<String>> _groupStrokes(List<String> paths) {
    final groups = <List<String>>[];
    var currentGroup = <String>[];
    for (final stroke in paths) {
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
    return groups.isEmpty ? [paths] : groups;
  }

  int _getCharacterIndexForStroke(int strokeIndex) {
    int count = 0;
    for (int i = 0; i < _cachedCharGroups.length; i++) {
      count += _cachedCharGroups[i].length;
      if (strokeIndex < count) {
        return i;
      }
    }
    return 0;
  }

  int _getStrokeOffsetForCharacter(int charIndex) {
    int offset = 0;
    for (int i = 0; i < charIndex; i++) {
      // Each character group is followed by a separator in widget.medianPaths
      offset += _cachedCharGroups[i].length + 1;
    }
    return offset;
  }

  void _startCycling() {
    _cycleTimer?.cancel();
    _runCycleLoop();
  }

  Future<void> _runCycleLoop() async {
    if (!mounted || !widget.showAnimation || _cachedCharGroups.length <= 1 || widget.forcedActiveCharIndex != null) {
      return;
    }
    final currentStrokes = _cachedCharGroups[_activeCharIndex].length;
    await Future.delayed(Duration(milliseconds: (200 + currentStrokes * 500) + 1500));
    if (!mounted || !widget.showAnimation) {
      return;
    }
    setState(() {
      _activeCharIndex = (_activeCharIndex + 1) % _cachedCharGroups.length;
      _cachedParsedPaths = CharacterLoader.parseStrokes(_cachedCharGroups[_activeCharIndex], normalize: true, isFlipped: widget.isFlipped);
    });
    _runCycleLoop();
  }

  @override
  void didUpdateWidget(DrawingCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool dataChanged = widget.strokePaths.length != oldWidget.strokePaths.length;
    final bool stateChanged = (widget.strokeLimit != oldWidget.strokeLimit) || (widget.currentStrokeIndex != oldWidget.currentStrokeIndex) || (widget.isFlipped != oldWidget.isFlipped) || (widget.forcedActiveCharIndex != oldWidget.forcedActiveCharIndex);
    if (dataChanged || stateChanged) {
      setState(() {
        _refreshData();
        if (widget.currentStrokeIndex != oldWidget.currentStrokeIndex) {
          _currentStrokeComplete = false;
          _showSnapStroke = false;
        }
      });
    }
    if (widget.showAnimation && !oldWidget.showAnimation && widget.forcedActiveCharIndex == null) {
      _startCycling();
    } else if (!widget.showAnimation && oldWidget.showAnimation) {
      _cycleTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    _shakeController.dispose();
    _hintController.dispose();
    widget.userPointsNotifier?.removeListener(_onExternalPointsChanged);
    super.dispose();
  }

  void _syncUserPointsWithNotifier() {
    if (widget.userPointsNotifier != null) widget.userPointsNotifier!.value = List.from(_userPoints);
  }

  void _onExternalPointsChanged() {
    if (widget.userPointsNotifier != null &&
        widget.userPointsNotifier!.value.isEmpty &&
        _userPoints.isNotEmpty) {
      setState(() {
        _userPoints.clear();
        _currentStrokeComplete = false;
        _showSnapStroke = false;
      });
    }
  }

  void _playHint() {
    if (_isHintAnimating || !widget.strokeByStrokeMode) {
      return;
    }
    setState(() => _isHintAnimating = true);
    _hintController.forward(from: 0).then((_) {
      if (mounted) {
        setState(() => _isHintAnimating = false);
      }
    });
  }

  void _gradeCurrentStroke() {
    if (!widget.strokeByStrokeMode) {
      return;
    }
    final validStrokes = widget.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').toList();
    if (widget.currentStrokeIndex >= validStrokes.length) {
      return;
    }
    List<Offset> currentStroke = [];
    for (int i = _userPoints.length - 2; i >= 0; i--) {
      if (_userPoints[i] == null) {
        break;
      }
      currentStroke.insert(0, _userPoints[i]!);
    }
    if (currentStroke.length < 2) return;
    List<Offset> referenceMedian = [];
    if (widget.medianPaths.isNotEmpty && widget.currentStrokeIndex < widget.medianPaths.length) {
      referenceMedian = widget.medianPaths[widget.currentStrokeIndex].map((p) => CharacterLoader.transformPoint(p)).toList();
    }
    final result = StrokeMatcher.matchStroke(currentStroke, referenceMedian, masteryLevel: widget.masteryLevel, strictEndpoints: widget.strictGrading);
    
    if (!mounted) return;
    
    setState(() => _gradingResult = result.score * 100.0);
    if (result.isMatch) {
      setState(() {
        _currentStrokeComplete = true;
        _showSnapStroke = true;
        _userPoints.clear();
        _syncUserPointsWithNotifier();
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
    if (paths.isEmpty || !widget.autoCenter) {
      return Offset.zero;
    }
    Rect totalBounds = Rect.zero;
    bool first = true;
    for (final p in paths) {
      final b = p.getBounds();
      if (b.isEmpty || b.width < 5 || b.height < 5) {
        continue;
      }
      if (first) {
        totalBounds = b;
        first = false;
      } else {
        totalBounds = totalBounds.expandToInclude(b);
      }
    }
    if (totalBounds.isEmpty) {
      return Offset.zero;
    }
    return Offset(500.0 - totalBounds.center.dx, 500.0 - totalBounds.center.dy);
  }

  @override
  Widget build(BuildContext context) {
    if (_cachedParsedPaths.isEmpty) {
      return const Center(child: Icon(Icons.broken_image, color: Colors.grey));
    }

    // Generate median paths from stroke paths if not provided
    final List<List<Offset>> generatedMedianPaths = [];
    for (int i = 0; i < _cachedParsedPaths.length; i++) {
      if (!_cachedParsedPaths[i].getBounds().isEmpty) {
        generatedMedianPaths.add(CharacterLoader.samplePoints(_cachedParsedPaths[i], interval: 3.0));
      } else {
        generatedMedianPaths.add([]);
      }
    }

    // Zen & Ink Aesthetic Tokens
    const Color xuanPaper = Color(0xFFFDFCF0);
    const Color carbonInk = Color(0xFF1A1A1B);
    
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final strokeOffset = _getStrokeOffsetForCharacter(_activeCharIndex);
    
    final centeringShift = _getCenteringShift(_cachedParsedPaths);
    final localCurrentIndex = widget.currentStrokeIndex - strokeOffset;

    List<Offset?> activeCharacterUserPoints = List.from(_userPoints);
    if (widget.initialUserStrokes != null) {
      final offset = _getStrokeOffsetForCharacter(_activeCharIndex);
      final count = _cachedCharGroups[_activeCharIndex].length;
      activeCharacterUserPoints = widget.initialUserStrokes!
          .skip(offset)
          .take(count)
          .expand((s) => [...s, null])
          .toList();
    }

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) => Transform.translate(
        offset: Offset(sin(pi * 4 * _shakeController.value) * 10, 0),
        child: child,
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: xuanPaper, // Warm Xuan Paper mandate
            border: Border.all(
              color: widget.strokeByStrokeMode ? Colors.brown.shade200 : Colors.grey.withValues(alpha: 0.2),
              width: widget.strokeByStrokeMode ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _RiceGridPainter(isDark: isDark))),


              if (widget.strokeByStrokeMode && localCurrentIndex >= 0 && localCurrentIndex < _cachedParsedPaths.length)
                Positioned.fill(
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: _CompletedStrokesPainter(
                          paths: _cachedParsedPaths.sublist(0, (_currentStrokeComplete ? localCurrentIndex + 1 : localCurrentIndex).clamp(0, _cachedParsedPaths.length)),
                        ),
                        size: Size.infinite
                      ),
                      if (!_currentStrokeComplete && widget.showReference)
                        CustomPaint(
                          painter: _ReferenceStrokePainter(
                            referencePath: _cachedParsedPaths[localCurrentIndex],
                            canvasSize: Size.infinite,
                          ),
                          size: Size.infinite,
                        ),
                      if (_isHintAnimating)
                        AnimatedBuilder(
                          animation: _hintController,
                          builder: (context, child) => CustomPaint(
                            painter: _HintStrokePainter(
                              path: _cachedParsedPaths[localCurrentIndex.clamp(0, _cachedParsedPaths.length - 1)],
                              points: (widget.medianPaths.isNotEmpty && widget.currentStrokeIndex < widget.medianPaths.length) ? widget.medianPaths[widget.currentStrokeIndex] : null,
                              progress: _hintController.value,
                            ),
                            size: Size.infinite,
                          ),
                        ),
                    ],
                  ),
                ),
              
              if (widget.showAnimation)
                Positioned.fill(
                  child: IgnorePointer(
                    child: _DelayedAnimationWidget(
                      key: ValueKey('anim_v10_${_activeCharIndex}_${widget.strokePaths.length}_${widget.medianPaths.length}'),
                      paths: _cachedParsedPaths,
                      medianPaths: (() {
                        final hasReal = (widget.medianPaths.length >= strokeOffset + _cachedParsedPaths.length);
                        debugPrint("HM: Char $_activeCharIndex. Using real medians: $hasReal. Total in list: ${widget.medianPaths.length}");
                        return hasReal 
                          ? widget.medianPaths.skip(strokeOffset).take(_cachedParsedPaths.length).toList() 
                          : generatedMedianPaths;
                      })(),
                      animationSpeed: widget.animationSpeed,
                      centeringShift: centeringShift,
                      isDark: isDark,
                    ),
                  ),
                ),

              if (_showSnapStroke)
                IgnorePointer(
                  child: CustomPaint(
                    painter: _SnapStrokePainter(_cachedParsedPaths[localCurrentIndex.clamp(0, _cachedParsedPaths.length - 1)]),
                    size: Size.infinite,
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
                          setState(() => _userPoints.add(null));
                          _gradeCurrentStroke();
                        },
                        child: CustomPaint(
                          painter: _UserDrawingPainter(
                            activeCharacterUserPoints, 
                            _gradingResult, 
                            centeringShift: centeringShift, 
                            isDark: false, // Always Carbon Ink on Xuan
                          ), 
                          size: Size.infinite
                        ),
                      );
                    },
                  ),
                ),
              ),

              if (widget.showGrade)
                Positioned(bottom: 10, left: 10, child: Text('Grade: ${_gradingResult?.toStringAsFixed(2) ?? "N/A"}', style: TextStyle(color: _gradingResult == null ? Colors.black : (_gradingResult! > 40 ? Colors.green : Colors.red), fontSize: 16, fontWeight: FontWeight.bold))),

              if (widget.strokeByStrokeMode && !_currentStrokeComplete && !widget.readOnly)
                Positioned(top: 10, right: 10, child: IconButton.filled(icon: Icon(_isHintAnimating ? Icons.lightbulb : Icons.lightbulb_outline), onPressed: _playHint, style: IconButton.styleFrom(backgroundColor: Colors.amber.withValues(alpha: 0.9), foregroundColor: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}

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
    final paint = Paint()..color = const Color(0xFF1A1A1B)..style = PaintingStyle.fill..isAntiAlias = true;
    for (final path in paths) {
      canvas.drawPath(path, paint);
    }
    canvas.restore();
  }
  @override
  bool shouldRepaint(covariant _CompletedStrokesPainter oldDelegate) => oldDelegate.paths.length != paths.length;
}

class _SnapStrokePainter extends CustomPainter {
  final Path strokePath;
  _SnapStrokePainter(this.strokePath);
  @override
  void paint(Canvas canvas, Size size) {
    if (strokePath.getBounds().isEmpty) return;
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);
    final paint = Paint()..color = Colors.green.withValues(alpha: 0.6)..style = PaintingStyle.fill..isAntiAlias = true;
    canvas.drawPath(strokePath, paint);
    canvas.restore();
  }
  @override
  bool shouldRepaint(covariant _SnapStrokePainter oldDelegate) => oldDelegate.strokePath != strokePath;
}

class _ReferenceStrokePainter extends CustomPainter {
  final Path referencePath;
  final Size canvasSize;
  _ReferenceStrokePainter({required this.referencePath, required this.canvasSize});
  @override
  void paint(Canvas canvas, Size size) {
    if (referencePath.getBounds().isEmpty) return;
    final double scaleX = size.width / 1000.0;
    final double scaleY = size.height / 1000.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);
    
    final strokePaint = Paint()..style = PaintingStyle.fill..color = Colors.blue.withValues(alpha: 0.3)..isAntiAlias = true;
    canvas.drawPath(referencePath, strokePaint);
    
    final highlightPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2.0..color = Colors.lightBlue.withValues(alpha: 0.6)..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round..isAntiAlias = true;
    canvas.drawPath(referencePath, highlightPaint);
    
    final metrics = referencePath.computeMetrics().toList();
    if (metrics.isNotEmpty) {
      final metric = metrics.first;
      List<Offset> samples = [];
      for (double i = 0; i <= 1.0; i += 0.01) {
        samples.add(metric.getTangentForOffset(metric.length * i)!.position);
      }
      
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
      if (scoreA < scoreB) { startTip = tipA; endTip = tipB; } 
      else { startTip = tipB; endTip = tipA; }
      
      Offset startPos = Offset.zero, endPos = Offset.zero;
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
    canvas.restore();
  }
  @override
  bool shouldRepaint(_ReferenceStrokePainter oldDelegate) => oldDelegate.referencePath != referencePath;
}

class _HintStrokePainter extends CustomPainter {
  final Path path;
  final List<Offset>? points;
  final double progress;
  _HintStrokePainter({required this.path, this.points, required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    // Standardize Hint to use Pro Logic
    final painter = _ProStrokePainter(
      paths: [path],
      medianPaths: [points ?? []],
      progress: progress,
      centeringShift: Offset.zero,
      isDark: false,
      isHint: true,
    );
    painter.paint(canvas, size);
  }
  @override
  bool shouldRepaint(_HintStrokePainter oldDelegate) => true;
}

class _UserDrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final double? gradingResult;
  final Offset centeringShift;
  final bool isDark;
  _UserDrawingPainter(this.points, this.gradingResult, {required this.centeringShift, required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0) return;
    final scale = size.width / 1000.0;
    const Color carbonInk = Color(0xFF1A1A1B);
    final paint = Paint()..color = gradingResult == null ? carbonInk : (gradingResult! > 40 ? Colors.green : Colors.red)
      ..strokeWidth = scale * 32.0..strokeCap = StrokeCap.round..style = PaintingStyle.stroke;
    for (int i = 1; i < points.length; i++) {
      if (points[i] != null && points[i-1] != null) {
        canvas.drawLine(Offset((points[i-1]!.dx + centeringShift.dx) * scale, (points[i-1]!.dy + centeringShift.dy) * scale), Offset((points[i]!.dx + centeringShift.dx) * scale, (points[i]!.dy + centeringShift.dy) * scale), paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _DelayedAnimationWidget extends StatefulWidget {
  final List<Path> paths;
  final List<List<Offset>>? medianPaths;
  final double animationSpeed;
  final Offset centeringShift;
  final bool isDark;
  const _DelayedAnimationWidget({super.key, required this.paths, this.medianPaths, required this.animationSpeed, required this.centeringShift, required this.isDark});
  @override
  State<_DelayedAnimationWidget> createState() => _DelayedAnimationWidgetState();
}

class _DelayedAnimationWidgetState extends State<_DelayedAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: (500 + widget.paths.length * 700).toInt()),
    )..forward();
    _controller.addStatusListener((status) { 
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 2000), () { 
          if (mounted) _controller.forward(from: 0); 
        }); 
      } 
    });
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => CustomPaint(
          painter: _ProStrokePainter(
            paths: widget.paths,
            medianPaths: widget.medianPaths,
            progress: _controller.value,
            centeringShift: widget.centeringShift,
            isDark: widget.isDark,
          ),
          size: Size.infinite,
        ),
      );
}

class _ProStrokePainter extends CustomPainter {
  final List<Path> paths;
  final List<List<Offset>>? medianPaths;
  final double progress;
  final Offset centeringShift;
  final bool isDark;

  final bool isHint;

  _ProStrokePainter({
    required this.paths,
    this.medianPaths,
    required this.progress,
    required this.centeringShift,
    required this.isDark,
    this.isHint = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if ((paths.isEmpty && !isHint) || size.width == 0) return;

    canvas.save();
    canvas.scale(size.width / 1000.0, size.height / 1000.0);
    canvas.translate(centeringShift.dx, centeringShift.dy);

    final totalStrokes = paths.length;
    final totalTime = progress * totalStrokes;
    const Color carbonInk = Color(0xFF1A1A1B);
    final inkColor = carbonInk;

    for (int i = 0; i < totalStrokes; i++) {
      final strokeProgress = (totalTime - i).clamp(0.0, 1.0);
      if (strokeProgress <= 0) continue;

      final path = paths[i];

      if (strokeProgress >= 1.0) {
        // Fully drawn stroke
        canvas.drawPath(path, Paint()..color = inkColor..style = PaintingStyle.fill);
      } else {
        // 1. PHANTOM STROKE (Subtle guide - minimized to not distract from inking)
        canvas.drawPath(path, Paint()..color = inkColor.withAlpha(25)..style = PaintingStyle.fill);

        // 2. VIRTUAL BRUSH ANIMATION
        const prepThreshold = 0.2;
        final isPrepping = strokeProgress < prepThreshold;
        
        final inkingProgress = isPrepping ? 0.0 : (strokeProgress - prepThreshold) / (1.0 - prepThreshold);
        final easedProgress = Curves.easeInOutQuart.transform(inkingProgress);
        
        final List<Offset> pts = (medianPaths != null && medianPaths!.length > i) ? medianPaths![i] : [];
        
        if (pts.isEmpty) {
          _drawFallbackReveal(canvas, path, easedProgress, inkColor);
        } else {
          final skeleton = Path();
          skeleton.moveTo(pts[0].dx, pts[0].dy);
          for (int j = 1; j < pts.length; j++) {
            skeleton.lineTo(pts[j].dx, pts[j].dy);
          }
          final metrics = skeleton.computeMetrics().toList();
          if (metrics.isNotEmpty) {
            // A. The Masked Stroke Layer (Multi-metric support)
            canvas.saveLayer(path.getBounds().inflate(50), Paint());
            canvas.drawPath(path, Paint()..color = inkColor..style = PaintingStyle.fill..isAntiAlias = true);
            
            final maskPaint = Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 100 
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0)
              ..blendMode = BlendMode.dstIn;
            
            final totalLen = metrics.fold(0.0, (sum, m) => sum + m.length);
            double currentLen = easedProgress * totalLen;
            final maskPath = Path();
            Offset lastTipPos = pts[0];
            
            for (final metric in metrics) {
              if (currentLen <= 0) break;
              final extractLen = currentLen.clamp(0.0, metric.length);
              maskPath.addPath(metric.extractPath(0, extractLen), Offset.zero);
              final tangent = metric.getTangentForOffset(extractLen);
              if (tangent != null) lastTipPos = tangent.position;
              currentLen -= metric.length;
            }
            final currentTipPos = lastTipPos;

            canvas.drawPath(maskPath, maskPaint);
            canvas.restore();

            // B. Visual Cues (Start Hint & Brush Tip)
            if (isPrepping) {
              final pulse = (0.5 + 0.5 * sin(totalTime * 25)).clamp(0.0, 1.0);
              // High contrast green
              canvas.drawCircle(pts[0], 25 + pulse * 10, Paint()..color = Colors.green.withAlpha(120));
              canvas.drawCircle(pts[0], 12, Paint()..color = Colors.green..style = PaintingStyle.fill);
            } else {
              // High-visibility Glowing Brush Tip (Amber Gold for maximal visibility on Xuan)
              final pulse = (0.8 + 0.2 * sin(progress * 45)).clamp(0.0, 1.0);
              const Color gold = Color(0xFFFFD700);
              
              final tipPaint = Paint()
                ..color = gold.withValues(alpha: 0.9)
                ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20.0 * pulse);
              
              canvas.drawCircle(currentTipPos, 45 * pulse, tipPaint);
              canvas.drawCircle(currentTipPos, 15, Paint()..color = Colors.white..style = PaintingStyle.fill);
              canvas.drawCircle(currentTipPos, 18, Paint()..color = gold..style = PaintingStyle.stroke..strokeWidth = 3.0);
            }
          }
        }
      }
    }

    canvas.restore();
  }

  void _drawFallbackReveal(Canvas canvas, Path path, double progress, Color color) {
    // Linear sweep is more reliable than perimeter sampling for closed loops
    final bounds = path.getBounds();
    final isVertical = bounds.height > bounds.width;
    
    canvas.saveLayer(bounds.inflate(10), Paint());
    canvas.drawPath(path, Paint()..color = color..style = PaintingStyle.fill);
    
    final maskPaint = Paint()..blendMode = BlendMode.dstIn;
    canvas.drawRect(
      isVertical 
        ? Rect.fromLTWH(bounds.left - 50, bounds.top, bounds.width + 100, bounds.height * progress)
        : Rect.fromLTWH(bounds.left, bounds.top - 50, bounds.width * progress, bounds.height + 100),
      maskPaint,
    );
    canvas.restore();

    // Add Dot to Fallback
    final tipPos = isVertical 
      ? Offset(bounds.center.dx, bounds.top + bounds.height * progress)
      : Offset(bounds.left + bounds.width * progress, bounds.center.dy);
    
    // Pulse faster in fallback to signal it's a guide
    final pulse = (0.8 + 0.2 * sin(progress * 60)).clamp(0.0, 1.0);
    const Color gold = Color(0xFFFFD700);
    canvas.drawCircle(tipPos, 45 * pulse, Paint()..color = gold.withValues(alpha: 0.6)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15));
    canvas.drawCircle(tipPos, 12, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_ProStrokePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isDark != isDark;
}

class _RiceGridPainter extends CustomPainter {
  final bool isDark;
  _RiceGridPainter({required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = (isDark ? Colors.white : Colors.red.shade900).withValues(alpha: 0.15)..strokeWidth = 1.0..style = PaintingStyle.stroke;
    final dashPaint = Paint()..color = (isDark ? Colors.white : Colors.red.shade900).withValues(alpha: 0.1)..strokeWidth = 0.5..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    _drawDashedLine(canvas, const Offset(0, 0), Offset(size.width, size.height), dashPaint);
    _drawDashedLine(canvas, Offset(size.width, 0), Offset(0, size.height), dashPaint);
  }
  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    final distance = (p2 - p1).distance;
    if (distance == 0) return;
    const dashWidth = 5.0;
    const dashSpace = 5.0;
    final dx = (p2.dx - p1.dx) / distance;
    final dy = (p2.dy - p1.dy) / distance;
    double currentDist = 0;
    while (currentDist < distance) {
      canvas.drawLine(Offset(p1.dx + dx * currentDist, p1.dy + dy * currentDist), Offset(p1.dx + dx * (currentDist + dashWidth), p1.dy + dy * (currentDist + dashWidth)), paint);
      currentDist += dashWidth + dashSpace;
    }
  }
  @override
  bool shouldRepaint(covariant _RiceGridPainter oldDelegate) => oldDelegate.isDark != isDark;
}
