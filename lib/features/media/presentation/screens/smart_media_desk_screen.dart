import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' hide Video;
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt show Video;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../data/youtube_repository.dart';
import '../../domain/models/video_transcript.dart';
import '../../domain/models/media_briefing.dart';
import '../../../../core/services/gemini_service.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

import 'package:hanzi_master/features/media/presentation/widgets/fullscreen_media_overlay.dart';

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
  StreamSubscription? _positionSubscription;

  @override
  void initState() {
    super.initState();
    _playerController = YoutubePlayerController.fromVideoId(
      videoId: widget.video.id.value,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: false,
        mute: false,
        showFullscreenButton: false,
        loop: false,
        color: 'white',
        // Disable YouTube's native closed captions
        enableCaption: false,
      ),
    );

    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final repository = ref.read(youtubeRepositoryProvider);
      final transcript = await repository.getTranscript(widget.video.id.value);

      if (transcript != null) {
        if (mounted) {
          setState(() {
            _transcript = transcript;
            _isLoading = false;
          });
          _startSyncEngine();
        }

        // Generate AI Briefing in background
        final gemini = ref.read(geminiServiceProvider);
        gemini.generateVideoBriefing(widget.video.title, transcript.lines).then((briefing) {
          if (mounted) {
            setState(() {
              _briefing = briefing;
            });
          }
        }).catchError((e) {
          debugPrint("Briefing error: $e");
        });

      } else {
        if (mounted) {
          setState(() {
            _error = "No closed captions available for this video.";
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

  void _startSyncEngine() {
    _positionSubscription = _playerController.videoStateStream.listen((state) {
      final position = state.position;
      if (_transcript == null) return;

      int newIndex = _transcript!.lines.indexWhere(
        (line) => position >= line.start && position <= line.end
      );

      setState(() {
        _currentPosition = position;
        if (newIndex != -1 && newIndex != _currentIndex) {
          _currentIndex = newIndex;
          
          // Auto scroll to current index
          if (_scrollController.hasClients) {
            final targetOffset = newIndex * 60.0; // Approximation of item height
            _scrollController.animateTo(
              targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    });
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
      builder: (context) {
        return Container(
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red));
                    }
                    final aiSentence = snapshot.data;
                    if (aiSentence == null) return const SizedBox.shrink();

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(aiSentence.chinese, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(aiSentence.english, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                          const SizedBox(height: 16),
                          ...aiSentence.words.map((w) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${w.hanzi} (${w.pinyin}): ", style: const TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(child: Text(w.meaning)),
                              ],
                            ),
                          )),
                        ],
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  int _getHighlightedCharCount(TranscriptLine line, Duration position) {
    if (position < line.start) return 0;
    if (position >= line.end) return line.text.length;
    
    final elapsed = position - line.start;
    final progress = elapsed.inMilliseconds / line.duration.inMilliseconds;
    return (progress * line.text.length).floor();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _playerController.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0),
      appBar: AppBar(
        title: Text(widget.video.title, style: const TextStyle(color: Colors.black87, fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          // Top Player
          YoutubePlayer(
            controller: _playerController,
            aspectRatio: 16 / 9,
            controlsBuilder: (context, isFullscreen) {
              if (!isFullscreen || _transcript == null || _currentIndex < 0 || _currentIndex >= _transcript!.lines.length) {
                return const SizedBox.shrink();
              }

              return FullscreenMediaOverlay(
                controller: _playerController,
                transcript: _transcript!,
                currentIndex: _currentIndex,
                currentPosition: _currentPosition,
                onWordTapped: _onWordTapped,
                videoTitle: widget.video.title,
                onExitFullscreen: () {
                  _playerController.exitFullScreen();
                },
              );
            },
          ),

          // Middle AI Briefing
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            )
          else if (_error != null)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            )
          else ...[
            if (_briefing != null)
              ExpansionTile(
                title: const Text('AI Prep Room', style: TextStyle(fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.psychology, color: Colors.indigo),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_briefing!.summary),
                        const SizedBox(height: 12),
                        const Text('Target Vocabulary:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: _briefing!.hardWords.map((w) => ActionChip(
                            label: Text(w),
                            onPressed: () => _onWordTapped(w),
                          )).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            
            // Bottom Transcript List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _transcript!.lines.length,
                itemBuilder: (context, index) {
                  final line = _transcript!.lines[index];
                  final isCurrent = index == _currentIndex;
                  final highlightedCount = _getHighlightedCharCount(line, _currentPosition);

                  return Container(
                    color: isCurrent ? Colors.indigo.withValues(alpha: 0.1) : Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.loop, size: 20, color: isCurrent ? Colors.indigo : Colors.grey),
                          onPressed: () => _replayLine(line.start),
                          tooltip: 'Shadow (Replay Sentence)',
                        ),
                        IconButton(
                          icon: const Text('✨', style: TextStyle(fontSize: 16)),
                          onPressed: () => _showSentenceLesson(line.text),
                          tooltip: 'AI Sentence Explainer',
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (line.pinyin != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    line.pinyin!,
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                ),
                              Wrap(
                                children: line.text.split('').asMap().entries.map((entry) {
                                  final charIndex = entry.key;
                                  final char = entry.value;
                                  final isHighlighted = isCurrent && charIndex <= highlightedCount;
                                  final isChinese = RegExp(r'[\u4e00-\u9fff]').hasMatch(char);

                                  final textWidget = Text(
                                    char,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: isHighlighted ? Colors.indigo[900] : Colors.black87,
                                      fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                                      height: 1.5,
                                    ),
                                  );

                                  return isChinese
                                    ? GestureDetector(
                                        onTap: () => _onWordTapped(char),
                                        child: textWidget,
                                      )
                                    : textWidget;
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
