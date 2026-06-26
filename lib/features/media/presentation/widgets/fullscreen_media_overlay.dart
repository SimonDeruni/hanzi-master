import 'dart:ui';
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

  const FullscreenMediaOverlay({
    super.key,
    required this.controller,
    required this.transcript,
    required this.currentIndex,
    required this.currentPosition,
    required this.onWordTapped,
    required this.videoTitle,
    required this.onExitFullscreen,
  });

  @override
  State<FullscreenMediaOverlay> createState() => _FullscreenMediaOverlayState();
}

class _FullscreenMediaOverlayState extends State<FullscreenMediaOverlay> {
  bool _showHanzi = true;
  bool _showPinyin = true;
  bool _showEnglish = true;
  bool _controlsVisible = true;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() => _controlsVisible = !_controlsVisible);
        },
        child: SafeArea(
          child: Stack(
            children: [
              // Top Bar
              if (_controlsVisible)
                Positioned(
                  top: 20,
                  left: 40,
                  right: 40,
                  child: PremiumVideoTopBar(
                    title: widget.videoTitle,
                    onExitFullscreen: widget.onExitFullscreen,
                    showHanzi: _showHanzi,
                    showPinyin: _showPinyin,
                    showEnglish: _showEnglish,
                    onToggleHanzi: (v) => setState(() => _showHanzi = v),
                    onTogglePinyin: (v) => setState(() => _showPinyin = v),
                    onToggleEnglish: (v) => setState(() => _showEnglish = v),
                  ),
                ),
              
              // Subtitles Overlay
              Positioned(
                left: 80,
                right: 80,
                bottom: _controlsVisible ? 160 : 40, 
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
                  bottom: 20,
                  left: 40,
                  right: 40,
                  child: PremiumVideoBottomBar(
                    controller: widget.controller,
                    transcript: widget.transcript,
                    currentIndex: widget.currentIndex,
                    currentPosition: widget.currentPosition,
                    onWordTapped: widget.onWordTapped,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
