import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../domain/models/video_transcript.dart';

/// YouTube-style bottom bar:
/// - Thin red scrubber flush to the bottom of the control area
/// - Time stamps (current / total) left-aligned
/// - Center controls: rewind 10s, play/pause, forward 10s
/// - Fullscreen-exit button on the far right
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
    if (mounted) setState(() => _duration = dur);
  }

  String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  void _seek(double delta) {
    widget.onInteraction?.call();
    final current = widget.currentPosition.inSeconds.toDouble();
    final target = (current + delta).clamp(0.0, _duration);
    widget.controller.seekTo(seconds: target, allowSeekAhead: true);
  }

  @override
  Widget build(BuildContext context) {
    final currentPos =
        _isDragging ? _dragValue : widget.currentPosition.inSeconds.toDouble();
    final currentDuration = Duration(seconds: currentPos.toInt());
    final totalDuration = Duration(seconds: _duration.toInt());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Scrubber row (time left · slider · time right) ─────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Text(
                _fmt(currentDuration),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.red,
                    inactiveTrackColor: Colors.white38,
                    thumbColor: Colors.white,
                    overlayColor: Colors.red.withValues(alpha: 0.2),
                    trackHeight: 3.0,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 5.0),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 12.0),
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
                      widget.controller
                          .seekTo(seconds: val, allowSeekAhead: true);
                      setState(() => _isDragging = false);
                    },
                  ),
                ),
              ),
              Text(
                _fmt(totalDuration),
                style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),

        // ── Controls row ───────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Line-loop / previous-line button
              _ControlIcon(
                icon: Icons.repeat_one,
                size: 22,
                color: Colors.white60,
                onTap: () {
                  widget.onInteraction?.call();
                  if (widget.currentIndex >= 0) {
                    widget.controller.seekTo(
                      seconds: widget.transcript.lines[widget.currentIndex]
                          .start.inSeconds
                          .toDouble(),
                      allowSeekAhead: true,
                    );
                    widget.controller.playVideo();
                  }
                },
              ),

              // Rewind 10s
              _ControlIcon(
                icon: Icons.replay_10,
                size: 28,
                color: Colors.white,
                onTap: () => _seek(-10),
              ),

              // Play / Pause — YouTube uses a slightly larger button
              GestureDetector(
                onTap: () {
                  widget.onInteraction?.call();
                  if (_isPlaying) {
                    widget.controller.pauseVideo();
                  } else {
                    widget.controller.playVideo();
                  }
                },
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 36,
                ),
              ),

              // Forward 10s
              _ControlIcon(
                icon: Icons.forward_10,
                size: 28,
                color: Colors.white,
                onTap: () => _seek(10),
              ),

              // Next subtitle line
              _ControlIcon(
                icon: Icons.skip_next,
                size: 22,
                color: Colors.white60,
                onTap: () {
                  widget.onInteraction?.call();
                  if (widget.currentIndex <
                      widget.transcript.lines.length - 1) {
                    widget.controller.seekTo(
                      seconds: widget
                          .transcript.lines[widget.currentIndex + 1].start.inSeconds
                          .toDouble(),
                      allowSeekAhead: true,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ControlIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final VoidCallback onTap;

  const _ControlIcon({
    required this.icon,
    required this.size,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}
