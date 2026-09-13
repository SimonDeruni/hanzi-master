import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../data/youtube_repository.dart';
import '../../domain/models/video_transcript.dart';
import '../../domain/models/media_briefing.dart';
import '../../domain/models/youtube_video.dart';
import '../../../../core/services/gemini_service.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_ai_prep_card.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_transcript_line.dart';
import 'package:hanzi_master/core/presentation/widgets/ai_progress_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class SmartMediaDeskScreen extends ConsumerStatefulWidget {
  final YoutubeVideo video;
  const SmartMediaDeskScreen({super.key, required this.video});

  @override
  ConsumerState<SmartMediaDeskScreen> createState() =>
      _SmartMediaDeskScreenState();
}

// â”€â”€â”€ AI Task Progress Dot â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _AiTaskDot extends StatelessWidget {
  final String label;
  final bool done;
  const _AiTaskDot({required this.label, required this.done});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: done ? Colors.green.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: done ? Colors.green.shade300 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            done ? Icons.check_circle : Icons.hourglass_empty,
            size: 14,
            color: done ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: done ? Colors.green.shade700 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€â”€ Skeleton Transcript Line â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _SkeletonTranscriptLine extends StatefulWidget {
  final int index;
  const _SkeletonTranscriptLine({required this.index});

  @override
  State<_SkeletonTranscriptLine> createState() =>
      _SkeletonTranscriptLineState();
}

class _SkeletonTranscriptLineState extends State<_SkeletonTranscriptLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
        final shimmer = Color.lerp(
          Colors.grey.shade200,
          Colors.grey.shade400,
          _animation.value,
        )!;
        // Vary the width to simulate real text
        final widths = [
          0.7,
          0.9,
          0.5,
          0.8,
          0.6,
          0.95,
          0.55,
          0.75,
          0.85,
          0.4,
          0.9,
          0.65
        ];
        final w = widths[widget.index % widths.length];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timestamp placeholder
              Container(
                height: 10,
                width: 36,
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 6),
              // Chinese text placeholder
              Container(
                height: 16,
                width: MediaQuery.of(context).size.width * w,
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              // Pinyin/English placeholder
              Container(
                height: 12,
                width: MediaQuery.of(context).size.width * (w * 0.8),
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SmartMediaDeskScreenState extends ConsumerState<SmartMediaDeskScreen> {
  late YoutubePlayerController _playerController;
  VideoTranscript? _transcript;
  bool _isLoading = true;
  String? _error;
  MediaBriefing? _briefing;

  // Loading step tracking for dynamic status text
  String _loadingStep = 'Fetching subtitles...';
  bool _briefingReady = false;
  bool _memesReady = false;

  int _currentIndex = -1;
  Duration _currentPosition = Duration.zero;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _lineKeys = [];
  StreamSubscription? _positionSubscription;
  bool _showPinyin = true;
  bool _showEnglish = true;
  bool _isAdPlaying = false;

  DateTime _lastSyncUpdate = DateTime.fromMillisecondsSinceEpoch(0);
  static const _syncInterval = Duration(milliseconds: 250);

  List<Map<String, dynamic>> _culturalMemes = [];
  bool _isHskSimplified = false;
  int _hskLevel = 2;
  Map<int, String> _simplifiedTranscript = {};
  Map<String, dynamic>? _activeMeme;
  bool _isSimplifyingAi = false;

  @override
  void initState() {
    super.initState();
    _playerController = YoutubePlayerController.fromVideoId(
      videoId: widget.video.id,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: false,
        mute: false,
        showFullscreenButton: false,
        loop: false,
        color: 'white',
        enableCaption: false,
        showVideoAnnotations: false,
        strictRelatedVideos: true,
        playsInline: true,
        // Block pointer events to YouTube's webview iframe completely so all taps,
        // gestures, scrubbers, and controls are exclusively handled by our custom UI.
        pointerEvents: PointerEvents.none,
      ),
    );
    _loadData();
    _startSyncEngine();

    // Keep the learning desk inline; fullscreen and landscape playback are disabled.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Future<void> _loadData() async {
    try {
      final repository = ref.read(youtubeRepositoryProvider);
      if (mounted) setState(() => _loadingStep = 'Fetching subtitles...');
      var transcript = await repository.getTranscript(widget.video.id);
      if (transcript != null) {
        final cleanedLines = YoutubeRepository.deduplicateAndMergeLines(transcript.lines);
        if (cleanedLines.length != transcript.lines.length) {
          transcript = VideoTranscript(videoId: transcript.videoId, lines: cleanedLines);
        }
        if (mounted) {
          setState(() {
            _transcript = transcript;
            _lineKeys.clear();
            _lineKeys.addAll(
                List.generate(transcript!.lines.length, (_) => GlobalKey()));
            _isLoading = false;
            _loadingStep = 'Generating AI briefing...';
          });
        }
        final gemini = ref.read(geminiServiceProvider);

        // Track briefing
        gemini
            .generateVideoBriefing(widget.video.title, transcript.lines)
            .then((b) {
          if (mounted) {
            setState(() {
              _briefing = b;
              _briefingReady = true;
              _updateLoadingStep();
            });
          }
        }).catchError((Object e) {
          debugPrint('Briefing error: $e');
          if (mounted) {
            _briefingReady = true;
            _updateLoadingStep();
          }
        });

        // Track memes
        gemini
            .generateCulturalMemes(transcript.lines.map((e) => e.text).toList())
            .then((m) {
          if (mounted) {
            setState(() {
              _culturalMemes = m;
              _memesReady = true;
              _updateLoadingStep();
            });
          }
        }).catchError((Object e) {
          debugPrint('Memes error: $e');
          if (mounted) {
            _memesReady = true;
            _updateLoadingStep();
          }
        });

        _translateIncrementally(transcript, gemini);
      } else {
        // Captions failed — fall back to YouTube native captions via the player
        if (mounted) {
          setState(() {
            _error = 'No Closed Captions (CC) found for this video. '
                'Videos with hardcoded or burned-in subtitles do not have digital text tracks available on YouTube.';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _updateLoadingStep() {
    if (_briefingReady && _memesReady) {
      _loadingStep = 'Translating subtitles...';
    } else if (_briefingReady || _memesReady) {
      _loadingStep = 'Generating AI briefing...';
    }
  }

  void _toggleHskSimplified(bool value) async {
    if (!value) {
      setState(() => _isHskSimplified = false);
      return;
    }

    if (_simplifiedTranscript.isNotEmpty) {
      setState(() => _isHskSimplified = true);
      return;
    }

    if (_transcript == null) return;

    // Prompt for HSK level
    final selectedLevel = await showModalBottomSheet<int>(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    AppLocalizations.of(context)!.select_target_hsk_level,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...List.generate(6, (index) {
                final level = index + 1;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withValues(alpha: 0.1),
                    child: Text('$level',
                        style: const TextStyle(color: Colors.orange)),
                  ),
                  title: Text("HSK $level"),
                  onTap: () => Navigator.pop(context, level),
                );
              }),
            ],
          ),
        );
      },
    );

    if (selectedLevel == null) {
      // Revert toggle visually if they cancel
      setState(() => _isHskSimplified = false);
      return;
    }

    setState(() {
      _hskLevel = selectedLevel;
      _isSimplifyingAi = true;
      _isHskSimplified = true;
    });

    final gemini = ref.read(geminiServiceProvider);
    try {
      final result = await gemini.simplifyTranscriptToHsk(
          _transcript!.lines.map((e) => e.text).toList(), _hskLevel);
      if (mounted) setState(() => _simplifiedTranscript = result);
    } catch (e) {
      debugPrint('Simplify error: $e');
      if (mounted) setState(() => _isHskSimplified = false);
    } finally {
      if (mounted) setState(() => _isSimplifyingAi = false);
    }
  }

  Future<void> _translateIncrementally(
      VideoTranscript transcript, GeminiService gemini) async {
    const chunkSize = 20;
    final workingLines = List<TranscriptLine>.from(transcript.lines);
    for (int start = 0; start < workingLines.length; start += chunkSize) {
      if (!mounted) return;
      final end = (start + chunkSize).clamp(0, workingLines.length);
      try {
        final translated = await gemini.translateChunk(
            workingLines.sublist(start, end),
            language: 'English');
        for (int i = 0; i < translated.length; i++) {
          workingLines[start + i] = translated[i];
        }
        if (mounted) {
          setState(() {
            _transcript = VideoTranscript(
                videoId: transcript.videoId, lines: List.from(workingLines));
          });
        }
      } catch (e) {
        debugPrint('Chunk translate error ($start-$end): $e');
      }
    }
  }

  void _startSyncEngine() {
    _positionSubscription = _playerController.videoStateStream.listen((state) {
      // Guard: if YouTube reports an error, show it to the user immediately
      if (_playerController.value.hasError && _error == null) {
        debugPrint('[YouTube] Player error: ${_playerController.value.error}');
        if (mounted) {
          setState(() {
            _error = _mapYoutubePlayerError(_playerController.value.error);
          });
        }
        return;
      }

      // Ad Detection Heuristic
      bool isAd = _playerController.value.playerState == PlayerState.unStarted;
      if (_isAdPlaying != isAd && mounted) {
        setState(() => _isAdPlaying = isAd);
      }

      // Don't force-disable captions — let users toggle YouTube native CC
      // _captionsDisabled flag is now kept for tracking but no JS override

      final position = state.position;
      if (_currentPosition != position) {
        setState(() => _currentPosition = position);
      }

      if (_transcript == null) return;
      final now = DateTime.now();
      if (now.difference(_lastSyncUpdate) < _syncInterval) return;
      _lastSyncUpdate = now;
      final newIndex = _transcript!.lines
          .indexWhere((l) => position >= l.start && position <= l.end);
      final indexChanged = newIndex != -1 && newIndex != _currentIndex;
      if (indexChanged) {
        setState(() {
          _currentIndex = newIndex;
        });

        // Cultural Meme check
        if (_culturalMemes.isNotEmpty && newIndex >= 0) {
          final meme = _culturalMemes.firstWhere(
            (m) => m['line_index'] == newIndex,
            orElse: () => <String, dynamic>{},
          );
          if (meme.isNotEmpty && meme != _activeMeme) {
            _activeMeme = meme;
            _showCulturalMeme(meme);
          }
        }
      }
      if (indexChanged && _scrollController.hasClients) {
        if (newIndex >= 0 && newIndex < _lineKeys.length) {
          final key = _lineKeys[newIndex];
          if (key.currentContext != null) {
            Scrollable.ensureVisible(
              key.currentContext!,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,
              alignment:
                  0.35, // Keeps the active subtitle positioned beautifully at 35% down the viewport
            );
          }
        }
      }
    });
  }

  void _showCulturalMeme(Map<String, dynamic> meme) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.lightbulb, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cultural Note: ${meme['keyword'] ?? ''}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("${meme['explanation'] ?? ''}"),
              ],
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
    ));
  }

  void _onWordTapped(String word) {
    _playerController.pauseVideo();
  }

  void _replayLine(Duration start) {
    _playerController.seekTo(
        seconds: start.inSeconds.toDouble(), allowSeekAhead: true);
    _playerController.playVideo();
  }

  int _getHighlightedCharCount(TranscriptLine line, Duration position) {
    if (position < line.start) return 0;
    if (position >= line.end) return line.text.length;
    final elapsed = position - line.start;
    final progress = elapsed.inMilliseconds / line.duration.inMilliseconds;
    return (progress * line.text.length).floor();
  }

  /// Portrait-mode video controls placed below the video, above the transcript.
  /// Shows scrubber with time labels, play/pause, rewind 10s, forward 10s.
  Widget _buildPortraitControls() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPlaying =
        _playerController.value.playerState == PlayerState.playing;

    return _PortraitVideoControls(
      controller: _playerController,
      currentPosition: _currentPosition,
      isPlaying: isPlaying,
      isDark: isDark,
      onSeekCompleted: _scrollToCurrentPosition,
    );
  }

  /// Scroll the transcript list to the line matching the given video position and apply highlight emphasis.
  void _scrollToCurrentPosition(Duration targetPosition) {
    if (_transcript == null) return;

    // Find matching sentence index
    final newIndex = _transcript!.lines.indexWhere(
        (l) => targetPosition >= l.start && targetPosition <= l.end);

    setState(() {
      _currentPosition = targetPosition;
      if (newIndex >= 0) {
        _currentIndex = newIndex;
      }
    });

    if (newIndex >= 0 &&
        newIndex < _lineKeys.length &&
        _scrollController.hasClients) {
      final key = _lineKeys[newIndex];
      if (key.currentContext != null) {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubic,
          alignment: 0.35,
        );
      }
    }
  }

  // â”€â”€â”€ Portrait Controls Widget â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // (inline private widget for the embedded control bar below the video)

  /// Skeleton transcript list + step indicator shown while data loads.
  /// The video player is already visible above — we don't block it.
  Widget _buildLoadingState() {
    return Column(
      children: [
        // Step indicator with dynamic text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _loadingStep,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              // Show AI task progress
              if (_transcript != null) ...[
                _AiTaskDot(
                    label: AppLocalizations.of(context)!.briefing,
                    done: _briefingReady),
                const SizedBox(width: 8),
                _AiTaskDot(
                    label: AppLocalizations.of(context)!.memes,
                    done: _memesReady),
              ],
            ],
          ),
        ),
        // Skeleton transcript lines
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            itemCount: 12,
            itemBuilder: (context, index) {
              return _SkeletonTranscriptLine(index: index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.subtitles_off_rounded,
                  color: Color(0xFFFFB300), size: 44),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.noCaptionsAvailable,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ??
                  '${AppLocalizations.of(context)!.thisVideoDoesNotHaveADigitalClosedC} '
                      '${AppLocalizations.of(context)!.videosWithHardcodedOrBurnedinSubtit}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                final uri = Uri.tryParse(widget.video.url);
                if (uri != null) {
                  launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.open_in_new_rounded, size: 16),
              label: Text(AppLocalizations.of(context)!.openInYoutube),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF3252C7),
                backgroundColor:
                    const Color(0xFF3252C7).withValues(alpha: 0.08),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _playerController.close();
    _scrollController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _briefing?.displayTitle(widget.video.title) ?? widget.video.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF1C2541),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.video.channelTitle.isNotEmpty)
              Text(
                widget.video.channelTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
            color: isDark ? Colors.white : const Color(0xFF1C2541)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.closed_caption, color: Colors.indigo),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: StatefulBuilder(
                      builder: (ctx, set) => SwitchListTile(
                            title:
                                Text(AppLocalizations.of(context)!.showPinyin),
                            value: _showPinyin,
                            activeThumbColor: Colors.indigo,
                            onChanged: (v) {
                              set(() {});
                              setState(() => _showPinyin = v);
                            },
                          ))),
              PopupMenuItem(
                  child: StatefulBuilder(
                      builder: (ctx, set) => SwitchListTile(
                            title: Text(
                                AppLocalizations.of(context)!.showTranslation),
                            value: _showEnglish,
                            activeThumbColor: Colors.indigo,
                            onChanged: (v) {
                              set(() {});
                              setState(() => _showEnglish = v);
                            },
                          ))),
              const PopupMenuDivider(),
              PopupMenuItem(
                  child: StatefulBuilder(
                      builder: (ctx, set) => SwitchListTile(
                            title: Text(AppLocalizations.of(context)!
                                .hskSimplifySubtitles),
                            value: _isHskSimplified,
                            activeThumbColor: Colors.orange,
                            onChanged: (v) {
                              set(() {});
                              _toggleHskSimplified(v);
                            },
                          ))),
            ],
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, _) {
          return Column(
            children: [
              ClipRect(
                child: Transform.scale(
                  scale: 1.05,
                  child: YoutubePlayer(
                    controller: _playerController,
                    aspectRatio: 16 / 9,
                    controlsBuilder: (context, _) {
                      return Transform.scale(
                        scale: 1 / 1.05,
                        child: Stack(
                          children: [
                            // BLOCK TOUCHES TO YOUTUBE NATIVE CONTROLS
                            Positioned.fill(
                              child: IgnorePointer(
                                ignoring: _isAdPlaying,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    if (_playerController.value.playerState ==
                                        PlayerState.playing) {
                                      _playerController.pauseVideo();
                                    } else {
                                      _playerController.playVideo();
                                    }
                                  },
                                  onLongPress: () {},
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // â”€â”€ Scrollable content â”€â”€
              Expanded(
                child: _isLoading
                    ? _buildLoadingState()
                    : _error != null
                        ? _buildErrorState()
                        : Column(
                            children: [
                              if (_isSimplifyingAi)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: AiProgressBar(
                                      label: AppLocalizations.of(context)!
                                          .simplifyingSubtitles),
                                ),
                              Expanded(
                                child: ListView(
                                  controller: _scrollController,
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 16, 32),
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    if (_briefing != null) ...[
                                      PremiumAiPrepCard(
                                          briefing: _briefing!,
                                          onWordTapped: _onWordTapped),
                                      const SizedBox(height: 32),
                                    ],
                                    if (_transcript != null)
                                      ..._transcript!.lines
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final line = entry.value;
                                        return PremiumTranscriptLine(
                                          key: _lineKeys[index],
                                          line: line,
                                          isCurrent: _currentIndex == index,
                                          highlightedCount:
                                              _currentIndex == index
                                                  ? _getHighlightedCharCount(
                                                      line, _currentPosition)
                                                  : (index < _currentIndex
                                                      ? line.text.length
                                                      : 0),
                                          onReplay: () =>
                                              _replayLine(line.start),
                                          onLineTapped: () {
                                            _playerController.seekTo(
                                                seconds: line.start.inSeconds
                                                    .toDouble(),
                                                allowSeekAhead: true);
                                            _playerController.playVideo();
                                          },
                                          onWordTapped: _onWordTapped,
                                          showPinyin: _showPinyin,
                                          showEnglish: _showEnglish,
                                          simplifiedText: _isHskSimplified
                                              ? _simplifiedTranscript[index]
                                              : null,
                                          isShadowingMode: true,
                                          isRecordingThisLine: false,
                                          onShadowTapped: () {
                                            _playerController.pauseVideo();
                                            final raw = line.pinyin?.trim();
                                            final translation = line.translation
                                                ?.trim()
                                                .toLowerCase();
                                            String effectivePinyin = '';
                                            if (raw != null &&
                                                raw.isNotEmpty &&
                                                (translation == null ||
                                                    raw.toLowerCase() !=
                                                        translation)) {
                                              effectivePinyin = raw;
                                            } else if (RegExp(
                                                    r'[\u4e00-\u9fff]')
                                                .hasMatch(line.text)) {
                                              effectivePinyin =
                                                  PinyinHelper.getPinyinE(
                                                      line.text,
                                                      separator: ' ',
                                                      format: PinyinFormat
                                                          .WITH_TONE_MARK);
                                            }

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ShadowingStudioScreen(
                                                  initialContextSentence:
                                                      line.text,
                                                  initialPinyin:
                                                      effectivePinyin,
                                                  initialTranslation:
                                                      line.translation,
                                                  isCompact: false,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                  ],
                                ),
                              ),
                            ],
                          ),
              ),

              // â”€â”€ Portrait Video Controls (docked at the BOTTOM of the screen) â”€â”€
              _buildPortraitControls(),
            ],
          );
        },
      ),
    );
  }

  String _mapYoutubePlayerError(YoutubeError error) {
    switch (error) {
      case YoutubeError.videoNotFound:
      case YoutubeError.cannotFindVideo:
        return 'This video has been removed or is no longer available.';
      case YoutubeError.notEmbeddable:
      case YoutubeError.sameAsNotEmbeddable:
      case YoutubeError.sameAsNotEmbeddable2:
        return 'This video cannot be played in the app. You can still watch it on YouTube.';
      case YoutubeError.html5Error:
        return 'Your device cannot play this video. Please try a different one.';
      case YoutubeError.invalidParam:
        return 'Invalid video reference. Please try again.';
      default:
        return 'Unable to load this video. Please try another one.';
    }
  }
}

// â”€â”€â”€ Portrait Video Controls (below video player) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

/// Compact video controls bar shown below the video player in portrait mode.
/// Includes: time labels, scrubber, play/pause, rewind 10s, forward 10s.
class _PortraitVideoControls extends StatefulWidget {
  final YoutubePlayerController controller;
  final Duration currentPosition;
  final bool isPlaying;
  final bool isDark;
  final void Function(Duration targetPosition) onSeekCompleted;

  const _PortraitVideoControls({
    required this.controller,
    required this.currentPosition,
    required this.isPlaying,
    required this.isDark,
    required this.onSeekCompleted,
  });

  @override
  State<_PortraitVideoControls> createState() => _PortraitVideoControlsState();
}

class _PortraitVideoControlsState extends State<_PortraitVideoControls> {
  double _duration = 1.0;
  bool _isDragging = false;
  double _dragValue = 0.0;
  StreamSubscription? _videoStateSubscription;

  @override
  void initState() {
    super.initState();
    _initDurationListener();
  }

  void _initDurationListener() {
    _fetchDuration();
    _videoStateSubscription =
        widget.controller.videoStateStream.listen((state) async {
      if (!mounted) return;
      try {
        final dur = await widget.controller.duration;
        if (dur > 0 && dur != _duration && mounted) {
          setState(() => _duration = dur);
        }
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    _videoStateSubscription?.cancel();
    super.dispose();
  }

  Future<void> _fetchDuration() async {
    try {
      final dur = await widget.controller.duration;
      if (mounted && dur > 0) setState(() => _duration = dur);
    } catch (_) {}
  }

  String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  void _seek(double delta) {
    final current = widget.currentPosition.inSeconds.toDouble();
    final target = (current + delta).clamp(0.0, _duration);
    widget.controller.seekTo(seconds: target, allowSeekAhead: true);
    // Immediately scroll transcript to the target position
    widget.onSeekCompleted(Duration(seconds: target.toInt()));
  }

  void _togglePlayPause() {
    if (widget.isPlaying) {
      widget.controller.pauseVideo();
    } else {
      widget.controller.playVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent =
        widget.isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);

    final currentPos =
        _isDragging ? _dragValue : widget.currentPosition.inSeconds.toDouble();
    final currentDuration = Duration(seconds: currentPos.toInt());
    final totalDuration = Duration(seconds: _duration.toInt());

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color:
              widget.isDark ? const Color(0xFF1E1E22) : const Color(0xFFFAF8EE),
          border: Border(
            top: BorderSide(
              color: (widget.isDark ? Colors.white : Colors.black)
                  .withValues(alpha: 0.08),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: widget.isDark ? 0.3 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Scrubber row: current time / slider / total time
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    _fmt(currentDuration),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: widget.isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: accent,
                      inactiveTrackColor:
                          (widget.isDark ? Colors.white : Colors.black)
                              .withValues(alpha: 0.2),
                      thumbColor: accent,
                      overlayColor: accent.withValues(alpha: 0.15),
                      trackHeight: 3.0,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6.0,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14.0,
                      ),
                    ),
                    child: Slider(
                      value: currentPos.clamp(0.0, _duration),
                      min: 0.0,
                      max: _duration > 0 ? _duration : 1.0,
                      onChangeStart: (_) => setState(() => _isDragging = true),
                      onChanged: (v) =>
                          setState(() => _dragValue = v.clamp(0.0, _duration)),
                      onChangeEnd: (v) {
                        final target = v.clamp(0.0, _duration);
                        widget.controller.seekTo(
                          seconds: target,
                          allowSeekAhead: true,
                        );
                        setState(() => _isDragging = false);
                        // Immediately scroll transcript to the target position
                        widget
                            .onSeekCompleted(Duration(seconds: target.toInt()));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    _fmt(totalDuration),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: widget.isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),

            // Control buttons row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Rewind 10s
                  _PortraitCtrlIcon(
                    icon: Icons.replay_10,
                    size: 24,
                    onTap: () => _seek(-10),
                  ),

                  // Play / Pause
                  GestureDetector(
                    onTap: _togglePlayPause,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: accent,
                        size: 24,
                      ),
                    ),
                  ),

                  // Forward 10s
                  _PortraitCtrlIcon(
                    icon: Icons.forward_10,
                    size: 24,
                    onTap: () => _seek(10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortraitCtrlIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const _PortraitCtrlIcon({
    required this.icon,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.grey.shade600, size: size),
      ),
    );
  }
}
