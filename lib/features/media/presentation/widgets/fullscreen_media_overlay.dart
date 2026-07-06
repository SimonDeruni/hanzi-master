import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../domain/models/video_transcript.dart';

import 'premium_video_top_bar.dart';
import 'premium_video_bottom_bar.dart';
import 'premium_subtitles_overlay.dart';

class FullscreenMediaOverlay extends StatefulWidget {
  final YoutubePlayerController controller;
  final VideoTranscript transcript;
  final int currentIndex;
  final Duration currentPosition;
  final Function(String) onWordTapped;
  final String videoTitle;
  final VoidCallback onExitFullscreen;
  final double playbackRate;
  final ValueChanged<double> onSpeedChanged;
  final bool isShadowingMode;
  final bool isRecording;
  final String shadowFeedback;
  final VoidCallback onToggleRecord;

  const FullscreenMediaOverlay({
    super.key,
    required this.controller,
    required this.transcript,
    required this.currentIndex,
    required this.currentPosition,
    required this.onWordTapped,
    required this.videoTitle,
    required this.onExitFullscreen,
    required this.playbackRate,
    required this.onSpeedChanged,
    this.isShadowingMode = false,
    this.isRecording = false,
    this.shadowFeedback = '',
    required this.onToggleRecord,
  });

  @override
  State<FullscreenMediaOverlay> createState() => _FullscreenMediaOverlayState();
}

class _FullscreenMediaOverlayState extends State<FullscreenMediaOverlay>
    with TickerProviderStateMixin {
  bool _showHanzi = true;
  bool _showPinyin = true;
  bool _showEnglish = true;
  bool _controlsVisible = true;
  Timer? _hideTimer;
  double _subtitleBgOpacity = 0.4;

  // Sparkline feedback animation
  late AnimationController _feedbackAnimCtrl;
  late Animation<Offset> _feedbackSlide;
  String _lastFeedback = '';
  Timer? _feedbackDismissTimer;

  @override
  void initState() {
    super.initState();
    _startHideTimer();

    _feedbackAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _feedbackSlide = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _feedbackAnimCtrl,
      curve: Curves.easeOutQuart,
    ));
  }

  @override
  void didUpdateWidget(FullscreenMediaOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger sparkline when feedback text arrives/changes
    if (widget.shadowFeedback != oldWidget.shadowFeedback &&
        widget.shadowFeedback.isNotEmpty) {
      _lastFeedback = widget.shadowFeedback;
      _feedbackAnimCtrl.forward(from: 0);
      _feedbackDismissTimer?.cancel();
      _feedbackDismissTimer = Timer(const Duration(seconds: 4), () {
        if (mounted) _feedbackAnimCtrl.reverse();
      });
    }
    if (widget.shadowFeedback.isEmpty && oldWidget.shadowFeedback.isNotEmpty) {
      _feedbackAnimCtrl.reverse();
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _feedbackDismissTimer?.cancel();
    _feedbackAnimCtrl.dispose();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _controlsVisible) {
        setState(() => _controlsVisible = false);
      }
    });
  }

  void _onUserInteraction() {
    if (!_controlsVisible) setState(() => _controlsVisible = true);
    _startHideTimer();
  }

  bool _isGoodScore(String feedback) {
    // Look for score ≥ 70 in "Score: XX/100"
    final match = RegExp(r'Score:\s*(\d+)').firstMatch(feedback);
    if (match != null) {
      final score = int.tryParse(match.group(1) ?? '0') ?? 0;
      return score >= 70;
    }
    return feedback.toLowerCase().contains('perfect') ||
        feedback.toLowerCase().contains('great');
  }

  @override
  Widget build(BuildContext context) {
    // CRITICAL: rendered inside controlsBuilder — must not block the video iframe.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_controlsVisible) {
          setState(() => _controlsVisible = false);
        } else {
          _onUserInteraction();
        }
      },
      child: Stack(
        children: [
          // ── Top gradient scrim ─────────────────────────────────────────
          if (_controlsVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 100,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.65),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // ── Bottom gradient scrim ──────────────────────────────────────
          if (_controlsVisible)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 130,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.75),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // ── Top bar ───────────────────────────────────────────────────
          if (_controlsVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: PremiumVideoTopBar(
                  title: widget.videoTitle,
                  onExitFullscreen: widget.onExitFullscreen,
                  showHanzi: _showHanzi,
                  showPinyin: _showPinyin,
                  showEnglish: _showEnglish,
                  onToggleHanzi: (v) {
                    _onUserInteraction();
                    setState(() => _showHanzi = v);
                  },
                  onTogglePinyin: (v) {
                    _onUserInteraction();
                    setState(() => _showPinyin = v);
                  },
                  onToggleEnglish: (v) {
                    _onUserInteraction();
                    setState(() => _showEnglish = v);
                  },
                  playbackRate: widget.playbackRate,
                  onSpeedChanged: widget.onSpeedChanged,
                  subtitleBgOpacity: _subtitleBgOpacity,
                  onOpacityChanged: (v) {
                    _onUserInteraction();
                    setState(() => _subtitleBgOpacity = v);
                  },
                ),
              ),
            ),

          // ── Center play/pause tap zone (when controls hidden) ─────────
          // This handles tapping the center to toggle play/pause visually
          if (!_controlsVisible)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _onUserInteraction,
              ),
            ),

          // ── Subtitles — sit just above the bottom bar ─────────────────
          Positioned(
            left: 48,
            right: widget.isShadowingMode ? 80 : 48,
            bottom: _controlsVisible ? 100 : 20,
            child: PremiumSubtitlesOverlay(
              transcript: widget.transcript,
              currentIndex: widget.currentIndex,
              currentPosition: widget.currentPosition,
              onWordTapped: (word) {
                _onUserInteraction();
                widget.onWordTapped(word);
              },
              showHanzi: _showHanzi,
              showPinyin: _showPinyin,
              showEnglish: _showEnglish,
              bgOpacity: _subtitleBgOpacity,
            ),
          ),

          // ── Bottom bar (YouTube-style controls) ───────────────────────
          if (_controlsVisible)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: PremiumVideoBottomBar(
                  controller: widget.controller,
                  transcript: widget.transcript,
                  currentIndex: widget.currentIndex,
                  currentPosition: widget.currentPosition,
                  onWordTapped: widget.onWordTapped,
                  onInteraction: _onUserInteraction,
                ),
              ),
            ),

          // ── Shadow mic pill (small, bottom-right corner) ──────────────
          if (widget.isShadowingMode)
            Positioned(
              bottom: _controlsVisible ? 90 : 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  _onUserInteraction();
                  widget.onToggleRecord();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: widget.isRecording
                        ? Colors.red
                        : Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: widget.isRecording
                          ? Colors.redAccent
                          : Colors.white38,
                      width: 1.5,
                    ),
                    boxShadow: [
                      if (widget.isRecording)
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.isRecording ? Icons.stop_rounded : Icons.mic,
                        color: Colors.white,
                        size: 18,
                      ),
                      if (widget.isRecording) ...[
                        const SizedBox(width: 6),
                        const Text(
                          'Stop',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

          // ── Sparkline feedback pill (slides in from top) ───────────────
          if (_lastFeedback.isNotEmpty)
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _feedbackSlide,
                child: Center(
                  child: _SparklinePill(
                    feedback: _lastFeedback,
                    isGood: _isGoodScore(_lastFeedback),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A compact pill that shows score + a tiny sparkline bar graph.
class _SparklinePill extends StatelessWidget {
  final String feedback;
  final bool isGood;

  const _SparklinePill({required this.feedback, required this.isGood});

  @override
  Widget build(BuildContext context) {
    final color = isGood ? const Color(0xFF4CAF50) : const Color(0xFFFF5252);
    // Extract numeric score if present e.g. "Score: 82/100"
    final match = RegExp(r'(\d+)/100').firstMatch(feedback);
    final score = match != null ? int.tryParse(match.group(1)!) ?? 0 : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: color.withValues(alpha: 0.7), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGood ? Icons.check_circle_outline : Icons.mic_none,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 8),
          if (score != null) ...[
            // Mini sparkline bar
            _MiniScoreBar(score: score, color: color),
            const SizedBox(width: 10),
            Text(
              '$score/100',
              style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              score != null
                  ? (isGood ? '好！Keep it up' : 'Keep practicing')
                  : feedback,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniScoreBar extends StatelessWidget {
  final int score;
  final Color color;

  const _MiniScoreBar({required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    // 5-segment sparkline
    const segments = 5;
    final filled = ((score / 100) * segments).round();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(segments, (i) {
        return Container(
          width: 6,
          height: i < segments - 1 ? 10 + (i * 3).toDouble() : 22,
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          decoration: BoxDecoration(
            color: i < filled
                ? color
                : Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
