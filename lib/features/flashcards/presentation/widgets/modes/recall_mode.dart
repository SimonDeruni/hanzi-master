import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';

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
    
    HapticsManager.light();

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
                        ? SwipeableFlashcard(
                            isSwipeEnabled: !_showScratchpad,
                            onSwiped: (grade) => Navigator.pop(context, grade),
                            child: _buildRevealedCard(isDark, cardColor, borderColor),
                          )
                        : _buildHiddenCard(isDark, cardColor, borderColor),
              ),
            ).animate()
             .fade(duration: 500.ms, curve: Curves.easeOutCubic)
             .slideY(begin: 0.1, end: 0, duration: 500.ms, curve: Curves.easeOutCubic),

            // Controls row below the card
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: _isRevealed
                  ? (_lines.isNotEmpty 
                      ? TextButton.icon(
                          onPressed: () => setState(() => _showScratchpad = !_showScratchpad),
                          icon: Icon(
                            _showScratchpad ? Icons.check_circle_outline : Icons.brush,
                            size: 18,
                          ),
                          label: Text(_showScratchpad ? "View Answer" : "View My Drawing"),
                          style: TextButton.styleFrom(
                            foregroundColor: isDark ? Colors.white54 : Colors.black45,
                          ),
                        )
                      : const SizedBox.shrink())
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
                            ? AppLocalizations.of(context)!.hideScratchpad
                            : AppLocalizations.of(context)!.practiceWriting,
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
                      : BouncingButton(
                          onPressed: _reveal,
                          child: ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.indigo,
                              disabledForegroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.revealAnswer,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ),
              ),

            if (_isRevealed && !_showScratchpad)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Column(
                  children: [
                    Text(
                      "Swipe to Grade:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "⬅️ Again    ➡️ Good    ⬆️ Easy    ⬇️ Hard",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<List<Offset>> _lines = [];
  List<Offset> _currentLine = [];

  void _clearScratchpad() {
    setState(() {
      _lines = [];
      _currentLine = [];
    });
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
                  color: isDark ? Colors.black26 : Colors.white,
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    CalligraphyBackground(child: const SizedBox.expand()),
                    GestureDetector(
                      onPanStart: _isRevealed ? null : (details) {
                        setState(() {
                          _currentLine = [details.localPosition];
                          _lines.add(_currentLine);
                        });
                      },
                      onPanUpdate: _isRevealed ? null : (details) {
                        setState(() {
                          _currentLine.add(details.localPosition);
                        });
                      },
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: _SimpleStrokePainter(
                          lines: _lines,
                          strokeColor: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    if (!_isRevealed)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.refresh),
                          color: isDark ? Colors.white54 : Colors.black54,
                          onPressed: _clearScratchpad,
                        ),
                      ),
                  ],
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
                      AppLocalizations.of(context)!.whatCharacterMeans,
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
            if (widget.card.sourceSentence != null && widget.card.sourceSentence!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.blueAccent.withValues(alpha: 0.1) : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.blueAccent.withValues(alpha: 0.2) : Colors.blue.shade100),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book, size: 14, color: isDark ? Colors.blueAccent.shade100 : Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          "Context Clue",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.blueAccent.shade100 : Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.card.sourceSentence!.replaceAll(widget.card.hanzi, '___'),
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 48),
            Text(
              AppLocalizations.of(context)!.tapToReveal,
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
            
          if (widget.card.sourceSentence != null && widget.card.sourceSentence!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.blueAccent.withValues(alpha: 0.1) : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isDark ? Colors.blueAccent.withValues(alpha: 0.2) : Colors.blue.shade100),
                ),
                child: Text(
                  widget.card.sourceSentence!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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
          child: BouncingButton(
            onPressed: () => Navigator.pop(context, grade),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: color.shade100,
                foregroundColor: color.shade900,
                disabledBackgroundColor: color.shade100,
                disabledForegroundColor: color.shade900,
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
      ),
    );
  }
}

class _SimpleStrokePainter extends CustomPainter {
  final List<List<Offset>> lines;
  final Color strokeColor;

  _SimpleStrokePainter({required this.lines, required this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final line in lines) {
      if (line.isEmpty) continue;
      
      final path = Path();
      path.moveTo(line.first.dx, line.first.dy);
      
      for (int i = 1; i < line.length; i++) {
        path.lineTo(line[i].dx, line[i].dy);
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SimpleStrokePainter oldDelegate) {
    return true; 
  }
}
