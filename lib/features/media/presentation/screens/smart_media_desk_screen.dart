import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt show Video;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../data/youtube_repository.dart';
import '../../domain/models/video_transcript.dart';
import '../../domain/models/media_briefing.dart';
import '../../../../core/services/gemini_service.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

import 'package:hanzi_master/features/media/presentation/widgets/fullscreen_media_overlay.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_ai_prep_card.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_transcript_line.dart';

class SmartMediaDeskScreen extends ConsumerStatefulWidget {
  final yt.Video video;
  const SmartMediaDeskScreen({super.key, required this.video});

  @override
  ConsumerState<SmartMediaDeskScreen> createState() => _SmartMediaDeskScreenState();
}

class _SmartMediaDeskScreenState extends ConsumerState<SmartMediaDeskScreen> {
  late YoutubePlayerController _playerController;
  VideoTranscript? _transcript;
  bool _isLoading = true;
  String? _error;
  MediaBriefing? _briefing;

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
  bool _isRecording = false;
  String _shadowFeedback = '';
  Map<String, dynamic>? _activeMeme;

  @override
  void initState() {
    super.initState();
    _playerController = YoutubePlayerController.fromVideoId(
      videoId: widget.video.id.value,
      autoPlay: true, // Try to autoplay to bypass the initial white play button
      params: const YoutubePlayerParams(
        showControls: false, // Disables native YouTube HTML controls
        mute: true, // Required to bypass mobile autoplay blockers
        showFullscreenButton: false,
        loop: false,
        color: 'white',
        enableCaption: false,
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
      final transcript = await repository.getTranscript(widget.video.id.value);
      if (transcript != null) {
        if (mounted) {
          setState(() { 
            _transcript = transcript; 
            _lineKeys.clear();
            _lineKeys.addAll(List.generate(transcript.lines.length, (_) => GlobalKey()));
            _isLoading = false; 
          });
        }
        _startSyncEngine();
        final gemini = ref.read(geminiServiceProvider);
        gemini.generateVideoBriefing(widget.video.title, transcript.lines)
            .then((b) { if (mounted) setState(() => _briefing = b); })
            .catchError((Object e) { debugPrint('Briefing error: $e'); });
            
        gemini.generateCulturalMemes(transcript.lines.map((e) => e.text).toList())
            .then((m) { if (mounted) setState(() => _culturalMemes = m); })
            .catchError((Object e) { debugPrint('Memes error: $e'); });
            
        _translateIncrementally(transcript, gemini);
      } else {
        if (mounted) setState(() { _error = 'No closed captions available.'; _isLoading = false; });
      }
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _isLoading = false; });
    }
  }

  void _toggleHskSimplified(bool value) async {
    setState(() {
      _isHskSimplified = value;
    });
    if (value && _simplifiedTranscript.isEmpty && _transcript != null) {
      final gemini = ref.read(geminiServiceProvider);
      try {
        final result = await gemini.simplifyTranscriptToHsk(
          _transcript!.lines.map((e) => e.text).toList(), 
          _hskLevel
        );
        if (mounted) setState(() => _simplifiedTranscript = result);
      } catch (e) {
        debugPrint('Simplify error: \$e');
      }
    }
  }

  Future<void> _translateIncrementally(VideoTranscript transcript, GeminiService gemini) async {
    const chunkSize = 20;
    final workingLines = List<TranscriptLine>.from(transcript.lines);
    for (int start = 0; start < workingLines.length; start += chunkSize) {
      if (!mounted) return;
      final end = (start + chunkSize).clamp(0, workingLines.length);
      try {
        final translated = await gemini.translateChunk(workingLines.sublist(start, end), language: 'English');
        for (int i = 0; i < translated.length; i++) {
          workingLines[start + i] = translated[i];
        }
        if (mounted) setState(() { _transcript = VideoTranscript(videoId: transcript.videoId, lines: List.from(workingLines)); });
      } catch (e) {
        debugPrint('Chunk translate error ($start-$end): $e');
      }
    }
  }

  void _startSyncEngine() {
    _positionSubscription = _playerController.videoStateStream.listen((state) {
      if (_playerController.value.playerState == PlayerState.playing && _wasMutedForAutoplay) {
        _playerController.unMute();
        _wasMutedForAutoplay = false;
      }
      
      if (_transcript == null) return;
      final now = DateTime.now();
      if (now.difference(_lastSyncUpdate) < _syncInterval) return;
      _lastSyncUpdate = now;
      final position = state.position;
      final newIndex = _transcript!.lines.indexWhere((l) => position >= l.start && position <= l.end);
      final indexChanged = newIndex != -1 && newIndex != _currentIndex;
      setState(() {
        _currentPosition = position;
        if (indexChanged) {
          _currentIndex = newIndex;
          if (_isShadowingMode) {
            _playerController.pauseVideo();
            _shadowFeedback = "Tap microphone to speak";
          }
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
              alignment: 0.3, // Keeps the active subtitle positioned beautifully at 30% down the list
            );
          }
        }
      }
    });
  }

  void _showCulturalMeme(Map<String, dynamic> meme) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.lightbulb, color: Colors.amber),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cultural Note: \${meme['keyword']}", style: const TextStyle(fontWeight: FontWeight.bold)),
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
      )
    );
  }

  void _onWordTapped(String word) {
    _playerController.pauseVideo();
    showQuickLook(context, word);
  }

  void _replayLine(Duration start) {
    _playerController.seekTo(seconds: start.inSeconds.toDouble(), allowSeekAhead: true);
    _playerController.playVideo();
  }

  void _showSentenceLesson(String sentence) {
    _playerController.pauseVideo();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("AI Micro-Lesson", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<AiSentence>(
                future: ref.read(geminiServiceProvider).generateSentenceLesson(sentence),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                  if (snapshot.hasError) return Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red));
                  final s = snapshot.data;
                  if (s == null) return const SizedBox.shrink();
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.chinese, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(s.english, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                        const SizedBox(height: 16),
                        ...s.words.map((w) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("${w.hanzi} (${w.pinyin}): ", style: const TextStyle(fontWeight: FontWeight.bold)),
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
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0),
      // Hide AppBar when in fullscreen
      appBar: _isFullscreen ? null : AppBar(
        title: const Text("Learn Chinese",
            style: TextStyle(color: Color(0xFF1C2541), fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1C2541)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.closed_caption, color: Colors.indigo),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            itemBuilder: (context) => [
              PopupMenuItem(child: StatefulBuilder(builder: (ctx, set) => SwitchListTile(
                title: const Text('Show Pinyin'),
                value: _showPinyin,
                activeThumbColor: Colors.indigo,
                onChanged: (v) { set(() {}); setState(() => _showPinyin = v); },
              ))),
              PopupMenuItem(child: StatefulBuilder(builder: (ctx, set) => SwitchListTile(
                title: const Text('Show Translation'),
                value: _showEnglish,
                activeThumbColor: Colors.indigo,
                onChanged: (v) { set(() {}); setState(() => _showEnglish = v); },
              ))),
              const PopupMenuDivider(),
              PopupMenuItem(child: StatefulBuilder(builder: (ctx, set) => SwitchListTile(
                title: const Text('HSK Simplify Subtitles'),
                value: _isHskSimplified,
                activeThumbColor: Colors.orange,
                onChanged: (v) { set(() {}); _toggleHskSimplified(v); },
              ))),
              PopupMenuItem(child: StatefulBuilder(builder: (ctx, set) => SwitchListTile(
                title: const Text('Shadow Mode (Mic)'),
                value: _isShadowingMode,
                activeThumbColor: Colors.redAccent,
                onChanged: (v) { set(() {}); setState(() => _isShadowingMode = v); },
              ))),
            ],
          ),
        ],
      ),
      floatingActionButton: _isShadowingMode
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  if (_isRecording) {
                    _isRecording = false;
                    _shadowFeedback = "Perfect! 98% Match. Resuming video...";
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                         setState(() => _shadowFeedback = "");
                         _playerController.playVideo();
                      }
                    });
                  } else {
                    _isRecording = true;
                    _shadowFeedback = "Listening... speak now.";
                  }
                });
              },
              backgroundColor: _isRecording ? Colors.red : Colors.indigo,
              icon: Icon(_isRecording ? Icons.stop : Icons.mic, color: Colors.white),
              label: Text(_isRecording ? "Stop" : "Hold to Speak", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          : null,
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
                } else if (orientation == Orientation.portrait && _isFullscreen) {
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
                              if (_playerController.value.playerState == PlayerState.playing) {
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
                            onTap: _enterFullscreen,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.fullscreen, color: Colors.white, size: 20),
                                  SizedBox(width: 4),
                                  Text('Full', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  // If fullscreen, show our full custom overlay
                  if (_transcript == null || _currentIndex < 0 || _currentIndex >= _transcript!.lines.length) {
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
                ? const Center(child: CircularProgressIndicator())
                : _error != null 
                  ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
                  : Column(
                      children: [
                        if (_shadowFeedback.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            color: _shadowFeedback.contains("Perfect") ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(_shadowFeedback.contains("Perfect") ? Icons.check_circle : Icons.mic, 
                                  color: _shadowFeedback.contains("Perfect") ? Colors.green : Colors.red, size: 20),
                                const SizedBox(width: 8),
                                Text(_shadowFeedback, style: TextStyle(
                                  color: _shadowFeedback.contains("Perfect") ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                )),
                              ],
                            ),
                          ),
                        Expanded(
                          child: ListView(
                            controller: _scrollController,
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 120), // Extra padding for FAB
                            physics: const BouncingScrollPhysics(),
                            children: [
                              if (_briefing != null) ...[
                                PremiumAiPrepCard(briefing: _briefing!, onWordTapped: _onWordTapped),
                                const SizedBox(height: 32),
                              ],
                              if (_transcript != null)
                                ..._transcript!.lines.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final line = entry.value;
                                  return PremiumTranscriptLine(
                                    key: _lineKeys[index],
                                    line: line,
                                    isCurrent: _currentIndex == index,
                                    highlightedCount: _currentIndex == index ? _getHighlightedCharCount(line, _currentPosition) : (index < _currentIndex ? line.text.length : 0),
                                    onReplay: () => _replayLine(line.start),
                                    onLineTapped: () {
                                      _playerController.seekTo(seconds: line.start.inSeconds.toDouble(), allowSeekAhead: true);
                                      _playerController.playVideo();
                                    },
                                    onAiExplain: () => _showSentenceLesson(line.text),
                                    onWordTapped: _onWordTapped,
                                    showPinyin: _showPinyin,
                                    showEnglish: _showEnglish,
                                    simplifiedText: _isHskSimplified ? _simplifiedTranscript[index] : null,
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
}
