import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
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

class _RecallModeWidgetState extends ConsumerState<RecallModeWidget> {
  bool _isRevealed = false;
  bool _showScratchpad = false;
  bool _isLoadingStrokes = false;
  late Flashcard _card;

  // Required for DrawingCanvas to capture touch input
  final ValueNotifier<List<ui.Offset?>> _scratchpadNotifier =
      ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _card = widget.card;
  }

  @override
  void dispose() {
    _scratchpadNotifier.dispose();
    super.dispose();
  }

  Future<void> _reveal() async {
    if (_isRevealed) return;

    // Load stroke data lazily on reveal
    if (_card.strokePaths.isEmpty) {
      setState(() => _isLoadingStrokes = true);
      final updated = await ref
          .read(flashcardControllerProvider.notifier)
          .loadStrokesFor(_card);
      if (mounted) {
        setState(() {
          if (updated != null) _card = updated;
          _isLoadingStrokes = false;
          _isRevealed = true;
          _showScratchpad = false; // hide scratchpad on reveal
        });
      }
    } else {
      setState(() {
        _isRevealed = true;
        _showScratchpad = false;
      });
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
            // Main area — card OR scratchpad, fills available space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: _showScratchpad
                    ? _buildScratchpad(isDark, borderColor)
                    : _isRevealed
                        ? _buildRevealedCard(isDark, cardColor, borderColor)
                        : _buildHiddenCard(isDark, cardColor, borderColor),
              ),
            ),

            // Controls row below the card
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: _isRevealed
                  ? const SizedBox.shrink()
                  : TextButton.icon(
                      onPressed: () => setState(
                          () => _showScratchpad = !_showScratchpad),
                      icon: Icon(
                        _showScratchpad
                            ? Icons.close
                            : Icons.draw_outlined,
                        size: 18,
                      ),
                      label: Text(
                        _showScratchpad
                            ? 'Hide Scratchpad'
                            : 'Practice Writing',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
            ),

            // Bottom button area
            if (!_isRevealed)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: _isLoadingStrokes
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ),

            if (_isRevealed)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
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
                        _buildGradeButton(
                            'Again', 0, Colors.red, 'Completely forgot'),
                        _buildGradeButton(
                            'Hard', 2, Colors.orange, 'Got it with difficulty'),
                        _buildGradeButton(
                            'Good', 4, Colors.green, 'Recalled correctly'),
                        _buildGradeButton(
                            'Easy', 5, Colors.blue, 'Perfect recall'),
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

  /// Blank writable canvas — fills the same Expanded area as the card
  Widget _buildScratchpad(bool isDark, Color borderColor) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: borderColor, width: 1),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withAlpha(12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                  ],
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
                    userPointsNotifier: _scratchpadNotifier,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHiddenCard(bool isDark, Color cardColor, Color borderColor) {
    return GestureDetector(
      onTap: _reveal,
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
        child: Column(
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
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: PinyinText(
                text: widget.card.pinyin,
                style: TextStyle(
                  fontSize: 38,
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
            const SizedBox(height: 48),
            Text(
              'Tap to Reveal',
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white30 : Colors.black26,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevealedCard(bool isDark, Color cardColor, Color borderColor) {
    return Container(
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
      child: Column(
        children: [
          // Pinyin + definition reminder
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
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
            height: 20,
            color: isDark ? Colors.white12 : Colors.black12,
            indent: 24,
            endIndent: 24,
          ),

          // ── Full word characters (always shown) ──
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.card.hanzi,
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                height: 1.1,
              ),
            ),
          ),

          // ── Stroke animation (square, centred, not stretched) ──
          if (_card.strokePaths.isNotEmpty)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
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
            )
          else
            const SizedBox(height: 16),
        ],
      ),
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
