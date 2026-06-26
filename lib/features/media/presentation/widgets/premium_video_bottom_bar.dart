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

  const PremiumVideoBottomBar({
    super.key,
    required this.controller,
    required this.transcript,
    required this.currentIndex,
    required this.currentPosition,
    required this.onWordTapped,
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
    widget.controller.videoStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playerState == PlayerState.playing;
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
                          setState(() {
                            _isDragging = true;
                            _dragValue = val;
                          });
                        },
                        onChangeEnd: (val) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side (Sync, Hanzi Pills)
                  Row(
                    children: [
                      // Sync Button
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.link, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text('Sync', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Hanzi Pills for current line
                      if (widget.currentIndex >= 0 && widget.currentIndex < widget.transcript.lines.length)
                        ..._buildHanziPills(widget.transcript.lines[widget.currentIndex].text),
                    ],
                  ),
                  
                  // Center / Right Controls
                  Row(
                    children: [
                      // AI Prep Room
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('AI Prep Room', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            Text('Review Key Words', style: TextStyle(color: Colors.white54, fontSize: 10)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      
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
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHanziPills(String text) {
    // Extract unique hanzi characters
    final hanziChars = text.split('').where((c) => RegExp(r'[\u4e00-\u9fff]').hasMatch(c)).toSet().toList();
    // Take max 3 to fit UI
    final displayChars = hanziChars.take(3).toList();
    
    return displayChars.map((char) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: () => widget.onWordTapped(char),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(char, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.flag, size: 10, color: Colors.black54),
                    SizedBox(width: 4),
                    Icon(Icons.star_border, size: 10, color: Colors.black54),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
