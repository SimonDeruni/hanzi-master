import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../data/youtube_repository.dart';
import '../../domain/models/video_transcript.dart';
import '../../domain/models/media_briefing.dart';
import '../../domain/models/youtube_video.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../core/services/audio_recording_service.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/info_bulb.dart';

import 'package:hanzi_master/features/media/presentation/widgets/fullscreen_media_overlay.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_ai_prep_card.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_transcript_line.dart';
import 'package:hanzi_master/core/presentation/widgets/ai_progress_bar.dart';

class SmartMediaDeskScreen extends ConsumerStatefulWidget {
  final YoutubeVideo video;
  const SmartMediaDeskScreen({super.key, required this.video});

  @override
  ConsumerState<SmartMediaDeskScreen> createState() =>
      _SmartMediaDeskScreenState();
}

// ─── AI Task Progress Dot ─────────────────────────────────────────────────────

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

// ─── Skeleton Transcript Line ─────────────────────────────────────────────────

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
  bool _translationStarted = false;
  int _translatedChunks = 0;
  int _totalChunks = 0;

  int _currentIndex = -1;
  Duration _currentPosition = Duration.zero;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _lineKeys = [];
  StreamSubscription? _positionSubscription;
  bool _showPinyin = true;
  bool _showEnglish = true;
  PlayerState _playerState = PlayerState.unknown;

  DateTime _lastSyncUpdate = DateTime.fromMillisecondsSinceEpoch(0);
  static const _syncInterval = Duration(milliseconds: 250);

  bool _isFullscreen = false;
  bool _wasMutedForAutoplay = true;
  double _playbackRate = 1.0;

  List<Map<String, dynamic>> _culturalMemes = [];
  bool _isHskSimplified = false;
  int _hskLevel = 2;
  Map<int, String> _simplifiedTranscript = {};
  bool _isShadowingMode = false;
  bool _captionsDisabled = false;
  bool _isRecording = false;
  int? _recordingLineIndex;
  String _shadowFeedback = '';
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
        pointerEvents: PointerEvents.none,
      ),
    );
    _loadData();

    // Allow landscape orientation so we can auto-trigger fullscreen when phone is rotated
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _loadData() async {
    try {
      final repository = ref.read(youtubeRepositoryProvider);
      if (mounted) setState(() => _loadingStep = 'Fetching subtitles...');
      final transcript = await repository.getTranscript(widget.video.id);
      if (transcript != null) {
        if (mounted) {
          setState(() {
            _transcript = transcript;
            _lineKeys.clear();
            _lineKeys.addAll(
                List.generate(transcript.lines.length, (_) => GlobalKey()));
            _isLoading = false;
            _loadingStep = 'Generating AI briefing...';
          });
        }
        _startSyncEngine();
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
        if (mounted)
          setState(() {
            _error =
                'No captions available. You can still watch with YouTube native captions.';
            _isLoading = false;
          });
      }
    } catch (e) {
      if (mounted)
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Select Target HSK Level',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...List.generate(6, (index) {
                final level = index + 1;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.withValues(alpha: 0.1),
                    child: Text('$level',
                        style: const TextStyle(color: Colors.orange)),
                  ),
                  title: Text('HSK $level'),
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
        if (mounted)
          setState(() {
            _transcript = VideoTranscript(
                videoId: transcript.videoId, lines: List.from(workingLines));
          });
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

      if (!_captionsDisabled) {
        _captionsDisabled = true;
        _playerController.webViewController.runJavaScript(
          'player.setOption("captions", "track", {});',
        );
      }

      if (_transcript == null) return;
      final now = DateTime.now();
      if (now.difference(_lastSyncUpdate) < _syncInterval) return;
      _lastSyncUpdate = now;
      final position = state.position;
      final newIndex = _transcript!.lines
          .indexWhere((l) => position >= l.start && position <= l.end);
      final indexChanged = newIndex != -1 && newIndex != _currentIndex;
      setState(() {
        _currentPosition = position;
        if (indexChanged) {
          _currentIndex = newIndex;
          // Removed auto-pause for shadowing mode based on user feedback
        }

        // Cultural Meme check
        if (_culturalMemes.isNotEmpty && _currentIndex >= 0) {
          final meme = _culturalMemes.firstWhere(
            (m) => m['line_index'] == _currentIndex,
            orElse: () => <String, dynamic>{},
          );
          if (meme.isNotEmpty && meme != _activeMeme) {
            _activeMeme = meme;
            _showCulturalMeme(meme);
          }
        }
      });
      if (indexChanged && _scrollController.hasClients) {
        if (newIndex >= 0 && newIndex < _lineKeys.length) {
          final key = _lineKeys[newIndex];
          if (key.currentContext != null) {
            Scrollable.ensureVisible(
              key.currentContext!,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              alignment:
                  0.3, // Keeps the active subtitle positioned beautifully at 30% down the list
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
                Text("Cultural Note: \${meme['keyword']}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("\${meme['explanation']}"),
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
    showQuickLook(context, word);
  }

  void _replayLine(Duration start) {
    _playerController.seekTo(
        seconds: start.inSeconds.toDouble(), allowSeekAhead: true);
    _playerController.playVideo();
  }

  void _showSentenceLesson(String sentence) {
    _playerController.pauseVideo();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1C1C1E)
          : Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("AI Micro-Lesson",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<AiSentence>(
                future: ref
                    .read(geminiServiceProvider)
                    .generateSentenceLesson(sentence),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return const Center(child: CircularProgressIndicator());
                  if (snapshot.hasError)
                    return Text("Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red));
                  final s = snapshot.data;
                  if (s == null) return const SizedBox.shrink();
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.chinese,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(s.english,
                            style: const TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic)),
                        const SizedBox(height: 16),
                        ...s.words.map((w) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${w.hanzi} (${w.pinyin}): ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Expanded(child: Text(w.meaning)),
                                  ]),
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getHighlightedCharCount(TranscriptLine line, Duration position) {
    if (position < line.start) return 0;
    if (position >= line.end) return line.text.length;
    final elapsed = position - line.start;
    final progress = elapsed.inMilliseconds / line.duration.inMilliseconds;
    return (progress * line.text.length).floor();
  }

  Future<void> _toggleShadowRecording([int? index]) async {
    final audioService = ref.read(audioRecordingServiceProvider);

    if (_isRecording) {
      if (index != null &&
          _recordingLineIndex != null &&
          index != _recordingLineIndex) {
        await audioService.stopRecording();
      } else {
        setState(() {
          _isRecording = false;
          _shadowFeedback = "Processing your pronunciation...";
        });

        final path = await audioService.stopRecording();
        if (path != null && _transcript != null) {
          try {
            final file = File(path);
            final byteData = await file.readAsBytes();

            // Determine the line we were shadowing
            final targetIndex = _recordingLineIndex ?? _currentIndex;
            if (targetIndex >= 0 && targetIndex < _transcript!.lines.length) {
              final line = _transcript!.lines[targetIndex];

              final gemini = ref.read(geminiServiceProvider);
              final result = await gemini.gradeAudio(
                  byteData, line.text, line.pinyin ?? "");
              final score = result['score'] ?? 0;

              setState(() {
                _shadowFeedback = "Score: $score/100. Resuming video...";
                _recordingLineIndex = null;
              });

              Future.delayed(const Duration(seconds: 3), () {
                if (mounted) {
                  setState(() => _shadowFeedback = "");
                  _playerController.playVideo();
                }
              });
            } else {
              setState(() {
                _shadowFeedback = "Couldn't identify line.";
                _recordingLineIndex = null;
              });
              _playerController.playVideo();
            }
          } catch (e) {
            setState(() {
              _shadowFeedback = "Error: $e";
              _recordingLineIndex = null;
            });
            _playerController.playVideo();
          }
        } else {
          _playerController.playVideo();
        }
        return;
      }
    }

    final hasPerm = await audioService.requestPermission();
    if (!hasPerm) return;

    // Pause video while recording!
    _playerController.pauseVideo();

    setState(() {
      _isRecording = true;
      _recordingLineIndex = index;
      _shadowFeedback = "Listening... speak now.";
    });
    await audioService.startRecording('youtube_shadowing');
  }

  void _enterFullscreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    setState(() => _isFullscreen = true);
  }

  void _exitFullscreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    setState(() => _isFullscreen = false);
  }

  void _changeSpeed(double speed) {
    setState(() {
      _playbackRate = speed;
      _playerController.setPlaybackRate(speed);
    });
  }

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
                _AiTaskDot(label: 'Briefing', done: _briefingReady),
                const SizedBox(width: 8),
                _AiTaskDot(label: 'Memes', done: _memesReady),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.subtitles_off,
                  color: Colors.orange, size: 48),
            ),
            const SizedBox(height: 24),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The video player is still active above. Try YouTube'
              's built-in CC button in the player.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                final uri = Uri.tryParse(widget.video.url);
                if (uri != null) {
                  launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in YouTube'),
            ),
          ],
        ),
      ),
    );
  }

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
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0),
      // Hide AppBar when in fullscreen
      appBar: _isFullscreen
          ? null
          : AppBar(
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InfoBulb(
                    id: 'learn_chinese_video',
                    title: "Learn Chinese",
                    message:
                        "Watch Chinese videos with interactive subtitles. Tap any word to see its definition, or tap a subtitle line to practice shadowing and improve your pronunciation.",
                  ),
                  Text("Learn Chinese",
                      style: TextStyle(
                          color: Color(0xFF1C2541),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Color(0xFF1C2541)),
              actions: [
                PopupMenuButton<String>(
                  icon: const Icon(Icons.closed_caption, color: Colors.indigo),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: StatefulBuilder(
                            builder: (ctx, set) => SwitchListTile(
                                  title: const Text('Show Pinyin'),
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
                                  title: const Text('Show Translation'),
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
                                  title: const Text('HSK Simplify Subtitles'),
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

      body: Column(
        children: [
          // ── Video Player with OrientationBuilder for auto-rotate ──
          OrientationBuilder(
            builder: (context, orientation) {
              // Automatically sync the player fullscreen state with the device orientation
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                if (orientation == Orientation.landscape && !_isFullscreen) {
                  setState(() => _isFullscreen = true);
                } else if (orientation == Orientation.portrait &&
                    _isFullscreen) {
                  setState(() => _isFullscreen = false);
                }
              });

              return ClipRect(
                child: Transform.scale(
                  scale: 1.05,
                  child: YoutubePlayer(
                    controller: _playerController,
                    aspectRatio: 16 / 9,
                    // CRITICAL: We MUST use controlsBuilder to render UI on top of the iframe.
                    // Sibling Positioned widgets get swallowed by the Android WebView Z-index.
                    controlsBuilder: (context, isFullscreenState) {
                      // Apply counter-scale so our controls don't get stretched/clipped
                      return Transform.scale(
                        scale: 1 / 1.05,
                        child: Builder(
                          builder: (context) {
                            // If not fullscreen, just show the transparent Play/Pause layer + Fullscreen button
                            if (!isFullscreenState) {
                              return Stack(
                                children: [
                                  // BLOCK TOUCHES TO YOUTUBE NATIVE CONTROLS
                                  Positioned.fill(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        if (_playerController
                                                .value.playerState ==
                                            PlayerState.playing) {
                                          _playerController.pauseVideo();
                                        } else {
                                          _playerController.playVideo();
                                        }
                                      },
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                  // The Fullscreen Button
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        HapticsManager.light();
                                        _enterFullscreen();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.black
                                              .withValues(alpha: 0.6),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.fullscreen,
                                                color: Colors.white, size: 20),
                                            SizedBox(width: 4),
                                            Text('Full',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            // If fullscreen, show our full custom overlay
                            if (_transcript == null ||
                                _currentIndex < 0 ||
                                _currentIndex >= _transcript!.lines.length) {
                              return const SizedBox.shrink();
                            }

                            return FullscreenMediaOverlay(
                              controller: _playerController,
                              transcript: _transcript!,
                              currentIndex: _currentIndex,
                              currentPosition: _currentPosition,
                              onWordTapped: _onWordTapped,
                              videoTitle: widget.video.title,
                              onExitFullscreen: _exitFullscreen,
                              playbackRate: _playbackRate,
                              onSpeedChanged: _changeSpeed,
                              isShadowingMode: _isShadowingMode,
                              isRecording: _isRecording,
                              shadowFeedback: _shadowFeedback,
                              onToggleRecord: () =>
                                  _toggleShadowRecording(null),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          // ── Scrollable content (hidden if fullscreen) ──
          if (!_isFullscreen)
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _error != null
                      ? _buildErrorState()
                      : Column(
                          children: [
                            if (_shadowFeedback.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                color: _shadowFeedback.contains("Perfect")
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : Colors.red.withValues(alpha: 0.1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                        _shadowFeedback.contains("Perfect")
                                            ? Icons.check_circle
                                            : Icons.mic,
                                        color:
                                            _shadowFeedback.contains("Perfect")
                                                ? Colors.green
                                                : Colors.red,
                                        size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(_shadowFeedback,
                                          style: TextStyle(
                                            color: _shadowFeedback
                                                    .contains("Perfect")
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            if (_isSimplifyingAi)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: AiProgressBar(
                                    label: 'Simplifying subtitles...'),
                              ),
                            Expanded(
                              child: ListView(
                                controller: _scrollController,
                                padding: const EdgeInsets.fromLTRB(16, 24, 16,
                                    120), // Extra padding for scrolling
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
                                        highlightedCount: _currentIndex == index
                                            ? _getHighlightedCharCount(
                                                line, _currentPosition)
                                            : (index < _currentIndex
                                                ? line.text.length
                                                : 0),
                                        onReplay: () => _replayLine(line.start),
                                        onLineTapped: () {
                                          _playerController.seekTo(
                                              seconds: line.start.inSeconds
                                                  .toDouble(),
                                              allowSeekAhead: true);
                                          _playerController.playVideo();
                                        },
                                        onAiExplain: () =>
                                            _showSentenceLesson(line.text),
                                        onWordTapped: _onWordTapped,
                                        showPinyin: _showPinyin,
                                        showEnglish: _showEnglish,
                                        simplifiedText: _isHskSimplified
                                            ? _simplifiedTranscript[index]
                                            : null,
                                        isShadowingMode: false,
                                        isRecordingThisLine: false,
                                        onShadowTapped: null,
                                      );
                                    }),
                                ],
                              ),
                            ),
                          ],
                        ),
            ),
        ],
      ),
    );
  }

  String _mapYoutubeWebError(String description) {
    final lower = description.toLowerCase();
    if (lower.contains('video unavailable') ||
        lower.contains('removed') ||
        lower.contains('private')) {
      return 'This video has been removed or is no longer available.';
    }
    if (lower.contains('not embeddable') || lower.contains('restricted')) {
      return 'This video cannot be played in the app. You can still watch it on YouTube.';
    }
    if (lower.contains('not found') || lower.contains('unavailable')) {
      return 'Video not found. It may have been deleted or is region-blocked.';
    }
    return 'Unable to load this video. Please try another one.';
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
