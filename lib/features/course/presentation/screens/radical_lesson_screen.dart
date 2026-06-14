import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/course/domain/entities/course_unit.dart';

class RadicalLessonScreen extends ConsumerStatefulWidget {
  final CourseNode sunNode;
  final List<CourseNode> clusterNodes; 

  const RadicalLessonScreen({
    super.key,
    required this.sunNode,
    required this.clusterNodes,
  });

  @override
  ConsumerState<RadicalLessonScreen> createState() => _RadicalLessonScreenState();
}

class _RadicalLessonScreenState extends ConsumerState<RadicalLessonScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  Flashcard? _radicalCard;
  bool _isLoading = true;

  // Forge Data
  Flashcard? _forgeTarget; 
  String _forgeBase = "";  
  bool _forgeSuccess = false;
  List<String> _forgeDistractors = [];
  List<String> _forgeOptions = [];

  // Hunt Data
  List<Flashcard> _huntOptions = [];
  final Set<String> _foundTargets = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final controller = ref.read(flashcardControllerProvider.notifier);
      final allCards = await ref.read(flashcardControllerProvider.future);
      
      // Load Metadata for decomposition
      final metaString = await rootBundle.loadString('assets/data/hanzi_metadata.json');
      final Map<String, dynamic> metaData = json.decode(metaString);
      
      // Load Radicals for distractors
      final radString = await rootBundle.loadString('assets/data/radicals.json');
      final radDb = json.decode(radString)['radicals'] as Map<String, dynamic>;
      final allRadicals = radDb.keys.toList();

      // 1. Load Radical Card
      var rad = allCards.firstWhere((c) => c.id == widget.sunNode.uuid, 
          orElse: () => Flashcard(id: widget.sunNode.uuid, hanzi: widget.sunNode.hanzi, pinyin: "", definition: "", hskLevel: 1, strokePaths: const [], modeStats: const {}));
      _radicalCard = await controller.loadStrokesFor(rad);

      // 2. Setup Forge (Find a child that is NOT the radical itself)
      final children = widget.clusterNodes.where((n) => n.uuid != widget.sunNode.uuid).toList();
      if (children.isNotEmpty) {
        final childNode = children.first;
        var childCard = allCards.firstWhere((c) => c.id == childNode.uuid);
        _forgeTarget = childCard;
        
        if (metaData.containsKey(childCard.hanzi)) {
          final decomp = metaData[childCard.hanzi]['decomposition'] as String;
          _forgeBase = decomp.replaceAll(widget.sunNode.hanzi, '').replaceAll(RegExp(r'[⿰⿱⿲⿳⿴⿵⿶⿷⿸⿹⿺⿻]'), '');
          if (_forgeBase.isEmpty) _forgeBase = "?";
        } else {
          _forgeBase = "?"; 
        }
        
        _forgeDistractors = allRadicals
            .where((r) => r != widget.sunNode.hanzi)
            .toList()
          ..shuffle();
        _forgeDistractors = _forgeDistractors.take(2).toList();
        
        _forgeOptions = [widget.sunNode.hanzi, ..._forgeDistractors]..shuffle();
      }

      // 3. Setup Hunt (3 correct, 3 wrong)
      final correct = children.take(3).map((n) => allCards.firstWhere((c) => c.id == n.uuid)).toList();
      final wrong = allCards.where((c) => !widget.clusterNodes.any((n) => n.uuid == c.id)).take(3).toList();
      _huntOptions = [...correct, ...wrong]..shuffle();

      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _nextPage() async {
    if (_currentStep < 2) { 
      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      setState(() => _currentStep++);
    } else {
      if (_radicalCard != null) {
        await ref.read(flashcardControllerProvider.notifier).reviewFlashcard(_radicalCard!, 5);
      }
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CalligraphyBackground(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildTraceStep(),
            if (_forgeTarget != null) _buildForgeStep(),
            _buildHuntStep(),
          ],
        ),
      ),
    );
  }

  // --- STEP 1: TRACE ---
  Widget _buildTraceStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("STEP 1: THE ORIGIN", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey)),
        const SizedBox(height: 24),
        Text("Trace the Radical: ${widget.sunNode.hanzi}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 48),
        SizedBox(
          width: 300, height: 300,
          child: _RadicalTraceWrapper(
            card: _radicalCard!,
            onComplete: _nextPage,
          ),
        ),
      ],
    );
  }

  // --- STEP 2: THE FORGE ---
  Widget _buildForgeStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("STEP 2: THE FORGE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey)),
        const SizedBox(height: 24),
        const Text("Choose the Essence", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "To forge \"${_forgeTarget?.definition.split(';').first.toUpperCase() ?? 'WORD'}\", what essence does $_forgeBase need?", 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.indigo.shade800, height: 1.4)
          ),
        ),
        const SizedBox(height: 48),
        
        DragTarget<String>(
          onWillAcceptWithDetails: (details) => true,
          onAcceptWithDetails: (details) {
            if (details.data == widget.sunNode.hanzi) {
              setState(() => _forgeSuccess = true);
              HapticsManager.success();
              Future.delayed(const Duration(seconds: 2), _nextPage);
            } else {
              HapticsManager.heavy();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong essence! Try again."), duration: Duration(milliseconds: 1000)));
            }
          },
          builder: (context, candidates, rejects) {
            final bool isHovering = candidates.isNotEmpty;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 140, height: 140,
              decoration: BoxDecoration(
                color: _forgeSuccess 
                    ? Colors.green.withValues(alpha: 0.2) 
                    : (isHovering ? Colors.amber.withValues(alpha: 0.2) : Colors.brown.withValues(alpha: 0.1)),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: _forgeSuccess ? Colors.green : (isHovering ? Colors.amber : Colors.brown.shade300),
                  width: _forgeSuccess || isHovering ? 4 : 2,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (!_forgeSuccess)
                    Text(_forgeBase, style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.brown.withValues(alpha: 0.3))),
                  if (_forgeSuccess)
                    Text(_forgeTarget!.hanzi, style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  if (isHovering && !_forgeSuccess)
                    const Icon(Icons.add_circle_outline, size: 48, color: Colors.amber),
                ],
              ),
            );
          },
        ),
        
        const SizedBox(height: 60), 
        
        Wrap(
          spacing: 24, runSpacing: 24,
          alignment: WrapAlignment.center,
          children: _forgeOptions.map((opt) {
            return Draggable<String>(
              data: opt,
              feedback: Material(
                color: Colors.transparent,
                child: _buildTile(opt, Colors.indigo, scale: 1.2, isElevated: true),
              ),
              childWhenDragging: Opacity(opacity: 0.2, child: _buildTile(opt, Colors.indigo)),
              child: _buildTile(opt, Colors.indigo, scale: 1.0, isElevated: true),
            );
          }).toList(),
        ),
        
        const SizedBox(height: 32),
        if (_forgeSuccess)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 500),
            builder: (context, val, child) => Opacity(
              opacity: val,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - val)),
                child: Text(
                  "FORGED: ${widget.sunNode.hanzi} + $_forgeBase = ${_forgeTarget!.hanzi}", 
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTile(String char, Color color, {double scale = 1.0, bool isElevated = false}) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 90, height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
          boxShadow: [
            if (isElevated)
              BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 15, spreadRadius: 2, offset: const Offset(0, 8)),
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2)),
          ],
        ),
        child: Center(
          child: Text(char, style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: color)),
        ),
      ),
    );
  }

  // --- STEP 3: THE HUNT ---
  Widget _buildHuntStep() {
    final int targetCount = _huntOptions.where((c) => widget.clusterNodes.any((n) => n.uuid == c.id)).length;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("STEP 3: THE HUNT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey)),
        const SizedBox(height: 24),
        Text("Find characters with ${widget.sunNode.hanzi}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 48),
        
        Wrap(
          spacing: 16, runSpacing: 16,
          alignment: WrapAlignment.center,
          children: _huntOptions.map((card) {
            final bool isTarget = widget.clusterNodes.any((n) => n.uuid == card.id);
            final bool isFound = _foundTargets.contains(card.id);
            
            return GestureDetector(
              onTap: () {
                if (isTarget && !isFound) {
                  setState(() => _foundTargets.add(card.id));
                  HapticsManager.light();
                  if (_foundTargets.length >= targetCount) {
                    HapticsManager.success();
                    Future.delayed(const Duration(seconds: 1), _nextPage);
                  }
                } else if (!isTarget) {
                  HapticsManager.heavy();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not that one! Look closer."), duration: Duration(milliseconds: 500)));
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: isFound ? Colors.green : Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isFound ? Colors.green : Colors.grey.shade300, width: 2),
                  boxShadow: [if (!isFound) BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))],
                ),
                child: Center(
                  child: isFound 
                    ? const Icon(Icons.check, color: Colors.white, size: 40)
                    : Text(card.hanzi, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _HandPointerHint extends StatefulWidget {
  @override
  State<_HandPointerHint> createState() => _HandPointerHintState();
}

class _HandPointerHintState extends State<_HandPointerHint> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Simple slide animation from left to right
        return Transform.translate(
          offset: Offset(200 * _animation.value, 0),
          child: Opacity(
            opacity: sin(_animation.value * pi),
            child: const Icon(Icons.touch_app, size: 40, color: Colors.indigo),
          ),
        );
      },
    );
  }
}

class _RadicalTraceWrapper extends StatefulWidget {
  final Flashcard card;
  final VoidCallback onComplete;
  const _RadicalTraceWrapper({required this.card, required this.onComplete});

  @override
  State<_RadicalTraceWrapper> createState() => _RadicalTraceWrapperState();
}

class _RadicalTraceWrapperState extends State<_RadicalTraceWrapper> {
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
        showAnimation: false, // Static ghost
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
