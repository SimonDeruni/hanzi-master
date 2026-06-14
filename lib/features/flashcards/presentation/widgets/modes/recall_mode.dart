import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

class RecallModeWidget extends ConsumerStatefulWidget {
  final Flashcard card;
  final int reviewedCount;
  final int dueCount;
  final int newCount;
  final int learningCount;

  const RecallModeWidget({
    super.key,
    required this.card,
    this.reviewedCount = 0,
    this.dueCount = 0,
    this.newCount = 0,
    this.learningCount = 0,
  });

  @override
  ConsumerState<RecallModeWidget> createState() => _RecallModeWidgetState();
}

class _RecallModeWidgetState extends ConsumerState<RecallModeWidget>
    with SingleTickerProviderStateMixin {
  bool _isRevealed = false;
  bool _showScratchpad = false;
  bool _isLoadingStrokes = false;
  late Flashcard _card;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _card = widget.card;
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flipAnimation = CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  Future<void> _reveal() async {
    if (_isRevealed) return;

    // Load stroke data lazily on reveal if not already loaded
    if (_card.strokePaths.isEmpty) {
      setState(() => _isLoadingStrokes = true);
      final updated = await ref
          .read(flashcardControllerProvider.notifier)
          .loadStrokesFor(_card);
      if (mounted) {
        setState(() {
          if (updated != null) _card = updated;
          _isLoadingStrokes = false;
        });
      }
    }

    if (mounted) {
      setState(() => _isRevealed = true);
      _flipController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final cardColor = isDark ? Colors.white.withAlpha(12) : Colors.white;
    final borderColor = isDark ? Colors.white12 : Colors.black12;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: StudySessionAppBar(
        title: 'Recall Mode',
        dueCount: widget.dueCount,
        newCount: widget.newCount,
        learningCount: widget.learningCount,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main card — takes most of the space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: GestureDetector(
                  onTap: !_isRevealed ? _reveal : null,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: borderColor),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withAlpha(12),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                      ],
                    ),
                    child: _isLoadingStrokes
                        ? const Center(child: CircularProgressIndicator())
                        : _isRevealed
                            ? _buildRevealedFace(isDark)
                            : _buildHiddenFace(isDark),
                  ),
                ),
              ),
            ),

            // Scratchpad toggle (only before reveal)
            if (!_isRevealed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: TextButton.icon(
                  onPressed: () =>
                      setState(() => _showScratchpad = !_showScratchpad),
                  icon: Icon(
                    _showScratchpad ? Icons.close : Icons.draw_outlined,
                    size: 18,
                  ),
                  label: Text(
                    _showScratchpad ? 'Hide Scratchpad' : 'Practice Writing',
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor:
                        isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
              ),

            // Scratchpad canvas
            if (_showScratchpad && !_isRevealed)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: AspectRatio(
                  aspectRatio: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CalligraphyBackground(
                      child: DrawingCanvas(
                        strokePaths: const [],
                        medianPaths: const [],
                        showAnimation: false,
                        readOnly: false,
                        showControls: true,
                        showGrade: false,
                        showGuideLines: true,
                      ),
                    ),
                  ),
                ),
              ),

            // Reveal button (before reveal)
            if (!_isRevealed)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _reveal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Reveal Answer',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

            // Grading buttons (after reveal)
            if (_isRevealed)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                child: Column(
                  children: [
                    Text(
                      'How well did you remember?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildGradeButton('Again', 0, Colors.red, 'Completely forgot'),
                        _buildGradeButton('Hard', 2, Colors.orange, 'Got it with difficulty'),
                        _buildGradeButton('Good', 4, Colors.green, 'Recalled correctly'),
                        _buildGradeButton('Easy', 5, Colors.blue, 'Perfect recall'),
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

  Widget _buildHiddenFace(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'What character means:',
          style: TextStyle(
            fontSize: 15,
            color: isDark ? Colors.white54 : Colors.black45,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: PinyinText(
            text: widget.card.pinyin,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            widget.card.definition,
            style: TextStyle(
              fontSize: 22,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Tap to Reveal',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white30 : Colors.black26,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildRevealedFace(bool isDark) {
    return Column(
      children: [
        // Top: pinyin & definition reminder
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              PinyinText(
                text: widget.card.pinyin,
                style: TextStyle(
                  fontSize: 20,
                  color: isDark ? Colors.white54 : Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.card.definition,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        Divider(
          height: 32,
          color: isDark ? Colors.white12 : Colors.black12,
          indent: 24,
          endIndent: 24,
        ),

        // The answer: character + stroke animation
        Expanded(
          child: _card.strokePaths.isEmpty
              ? Center(
                  child: Text(
                    widget.card.hanzi,
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CalligraphyBackground(
                        child: DrawingCanvas(
                          strokePaths: _card.strokePaths,
                          medianPaths: _card.medianPaths,
                          showAnimation: true,
                          readOnly: true,
                          isFlipped: _card.isFlipped,
                          showGrade: false,
                          showControls: false,
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGradeButton(
      String label, int grade, MaterialColor color, String tooltip) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Tooltip(
          message: tooltip,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, grade),
            style: ElevatedButton.styleFrom(
              backgroundColor: color.shade100,
              foregroundColor: color.shade900,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: color.shade300, width: 1),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
