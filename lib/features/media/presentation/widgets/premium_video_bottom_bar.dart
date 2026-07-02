import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../domain/models/video_transcript.dart';

class PremiumVideoBottomBar extends StatefulWidget {
  final YoutubePlayerController controller;
  final VideoTranscript transcript;
  final int currentIndex;
  final Duration currentPosition;
  final Function(String) onWordTapped;
  final VoidCallback? onInteraction;

  const PremiumVideoBottomBar({
    super.key,
    required this.controller,
    required this.transcript,
    required this.currentIndex,
    required this.currentPosition,
    required this.onWordTapped,
    this.onInteraction,
  });

  @override
  State<PremiumVideoBottomBar> createState() => _PremiumVideoBottomBarState();
}

class _PremiumVideoBottomBarState extends State<PremiumVideoBottomBar> {
  bool _isPlaying = false;
  double _duration = 1.0;
  bool _isDragging = false;
  double _dragValue = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchDuration();
    widget.controller.listen((value) {
      if (mounted) {
        setState(() {
          _isPlaying = value.playerState == PlayerState.playing;
        });
      }
    });
  }

  Future<void> _fetchDuration() async {
    final dur = await widget.controller.duration;
    if (mounted) {
      setState(() {
        _duration = dur;
      });
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${d.inHours > 0 ? '${d.inHours}:' : ''}$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final currentPos = _isDragging ? _dragValue : widget.currentPosition.inSeconds.toDouble();
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: Colors.white.withValues(alpha: 0.1),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24, width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Progress Bar Row
              Row(
                children: [
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.redAccent,
                        inactiveTrackColor: Colors.white24,
                        thumbColor: Colors.white,
                        overlayColor: Colors.red.withValues(alpha: 0.2),
                        trackHeight: 4.0,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
                      ),
                      child: Slider(
                        value: currentPos.clamp(0.0, _duration),
                        min: 0.0,
                        max: _duration > 0 ? _duration : 1.0,
                        onChanged: (val) {
                          widget.onInteraction?.call();
                          setState(() {
                            _isDragging = true;
                            _dragValue = val;
                          });
                        },
                        onChangeEnd: (val) {
                          widget.onInteraction?.call();
                          widget.controller.seekTo(seconds: val, allowSeekAhead: true);
                          setState(() {
                            _isDragging = false;
                          });
                        },
                      ),
                    ),
                  ),
                  Text(
                    '${_formatDuration(Duration(seconds: currentPos.toInt()))} / ${_formatDuration(Duration(seconds: _duration.toInt()))}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Controls Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Line Loop
                  IconButton(
                    icon: const Icon(Icons.repeat, color: Colors.white70),
                    onPressed: () {
                      if (widget.currentIndex >= 0) {
                        widget.controller.seekTo(
                          seconds: widget.transcript.lines[widget.currentIndex].start.inSeconds.toDouble(),
                          allowSeekAhead: true,
                        );
                        widget.controller.playVideo();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  
                  // Playback Controls
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.white),
                    onPressed: () {
                      if (widget.currentIndex > 0) {
                        widget.controller.seekTo(
                          seconds: widget.transcript.lines[widget.currentIndex - 1].start.inSeconds.toDouble(),
                          allowSeekAhead: true,
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 32),
                    onPressed: () {
                      if (_isPlaying) {
                        widget.controller.pauseVideo();
                      } else {
                        widget.controller.playVideo();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.white),
                    onPressed: () {
                      if (widget.currentIndex < widget.transcript.lines.length - 1) {
                        widget.controller.seekTo(
                          seconds: widget.transcript.lines[widget.currentIndex + 1].start.inSeconds.toDouble(),
                          allowSeekAhead: true,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
