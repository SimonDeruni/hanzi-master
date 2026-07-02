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
  });

  @override
  State<FullscreenMediaOverlay> createState() => _FullscreenMediaOverlayState();
}

class _FullscreenMediaOverlayState extends State<FullscreenMediaOverlay> {
  bool _showHanzi = true;
  bool _showPinyin = true;
  bool _showEnglish = true;
  bool _controlsVisible = true;
  Timer? _hideTimer;
  Timer? _hudTimer;
  double _brightnessOverlayOpacity = 0.0;
  bool _showBrightnessHud = false;

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 4), () {
      if (mounted && _controlsVisible) {
        setState(() => _controlsVisible = false);
      }
    });
  }

  void _onUserInteraction() {
    if (!_controlsVisible) {
      setState(() => _controlsVisible = true);
    }
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CRITICAL: This widget is rendered inside youtube_player_iframe's controlsBuilder.
    // It must NOT use Positioned.fill with an opaque container — that would block the video.
    // Only the controls/subtitles themselves should be visible; video shows through underneath.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_controlsVisible) {
          setState(() => _controlsVisible = false);
        } else {
          _onUserInteraction();
        }
      },
      onVerticalDragUpdate: (details) {
        _onUserInteraction();
        final screenWidth = MediaQuery.of(context).size.width;
        if (details.globalPosition.dx < screenWidth / 2) {
          // Left side: Simulate brightness using a black overlay
          setState(() {
            _brightnessOverlayOpacity = (_brightnessOverlayOpacity + (details.delta.dy * 0.005)).clamp(0.0, 0.85);
            _showBrightnessHud = true;
          });
          
          _hudTimer?.cancel();
          _hudTimer = Timer(const Duration(milliseconds: 1500), () {
            if (mounted) setState(() => _showBrightnessHud = false);
          });
        } else {
          // Right side: Volume
          // youtube_player_iframe doesn't have a simple synchronous getVolume.
          // But we could keep track of it if we wanted to.
        }
      },
      child: Stack(
        children: [
          // Simulated Brightness Overlay
          if (_brightnessOverlayOpacity > 0)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: Colors.black.withValues(alpha: _brightnessOverlayOpacity),
                ),
              ),
            ),

          // Brightness HUD
          if (_showBrightnessHud)
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.brightness_6, color: Colors.white, size: 28),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: 1.0 - (_brightnessOverlayOpacity / 0.85),
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Top Bar (blur glass pill)
          if (_controlsVisible)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: SafeArea(
                child: PremiumVideoTopBar(
                  title: widget.videoTitle,
                  onExitFullscreen: widget.onExitFullscreen,
                  showHanzi: _showHanzi,
                  showPinyin: _showPinyin,
                  showEnglish: _showEnglish,
                  onToggleHanzi: (v) { _onUserInteraction(); setState(() => _showHanzi = v); },
                  onTogglePinyin: (v) { _onUserInteraction(); setState(() => _showPinyin = v); },
                  onToggleEnglish: (v) { _onUserInteraction(); setState(() => _showEnglish = v); },
                  playbackRate: widget.playbackRate,
                  onSpeedChanged: widget.onSpeedChanged,
                ),
              ),
            ),

          // Subtitles — floated above bottom bar
          Positioned(
            left: 40,
            right: 40,
            bottom: _controlsVisible ? 130 : 24,
            child: PremiumSubtitlesOverlay(
              transcript: widget.transcript,
              currentIndex: widget.currentIndex,
              currentPosition: widget.currentPosition,
              onWordTapped: widget.onWordTapped,
              showHanzi: _showHanzi,
              showPinyin: _showPinyin,
              showEnglish: _showEnglish,
            ),
          ),

          // Bottom Bar
          if (_controlsVisible)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
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
        ],
      ),
    );
  }
}
