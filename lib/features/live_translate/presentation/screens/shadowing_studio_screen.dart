import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/services/audio_service.dart';
import '../../../../core/personal/her_account.dart';
import '../../../../core/personal/her_content.dart';
import '../../../../features/auth/presentation/providers/auth_controller.dart';

import '../../../../core/services/gemini_service.dart';
import '../../../../core/widgets/translated_definition.dart';

import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/shared/widgets/breathing_widget.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/core/utils/shadowing_line.dart';
import '../../../echo_hall/presentation/widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/services/pitch_detector_service.dart';
import 'package:hanzi_master/core/utils/pitch_contour.dart';
import '../widgets/tone_graph_card.dart';

enum ShadowingMode { freeFlow, theme, deck, customWord, customSentence }

class ShadowingStudioScreen extends ConsumerStatefulWidget {
  final String? initialHanzi;
  final String? initialPinyin;
  final String? initialTranslation;
  final String? initialContextSentence;
  final bool isCompact;
  final bool showBackButton;
  final bool startSessionImmediately;
  final ShadowingMode? initialSelectedMode;
  final String? initialSelectedTheme;
  final String? initialSelectedDeckId;
  final String? initialCustomWordInput;
  final Map<String, String>? initialPhrase;

  const ShadowingStudioScreen({
    super.key,
    this.initialHanzi,
    this.initialPinyin,
    this.initialTranslation,
    this.initialContextSentence,
    this.isCompact = false,
    this.showBackButton = true,
    this.startSessionImmediately = false,
    this.initialSelectedMode,
    this.initialSelectedTheme,
    this.initialSelectedDeckId,
    this.initialCustomWordInput,
    this.initialPhrase,
  });

  @override
  ConsumerState<ShadowingStudioScreen> createState() =>
      _ShadowingStudioScreenState();
}

class _ShadowingStudioScreenState extends ConsumerState<ShadowingStudioScreen>
    with SingleTickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();

  bool _isSessionStarted = false;
  ShadowingMode _selectedMode = ShadowingMode.theme;
  String _selectedTheme = 'HSK 1';
  String? _selectedDeckId;
  String _customWordInput = "";
  final TextEditingController _customWordController = TextEditingController();
  List<Flashcard> _dictionaryResults = [];
  Timer? _searchDebounce;
  bool _isSearchFocused = false;

  bool _isLoadingNextPhrase = false;
  bool _isStartingSession = false;
  int _sentenceCount = 0;
  Map<String, String>? _currentPhrase;
  bool _isRecording = false;
  bool _isGrading = false;
  bool _isStopping = false; // Prevents re-entry during stop→grade→reset cycle
  Map<String, dynamic>? _lastGrade;

  /// What the learner's voice actually did, and what the phrase's tones should have
  /// done — both in Hz per point, `null` where nothing was voiced.
  ///
  /// These are **display data**, measured from the recording before Azure is called at
  /// all. They are deliberately not read back out of [_lastGrade]: the grader only
  /// measures a contour for a *single* character (see `LocalToneGrader`), so a phrase
  /// has to be measured here regardless. Keeping them separate also means the graph
  /// cannot be broken by a grading failure.
  List<double?> _userPitch = const [];
  List<double?> _idealPitch = const [];

  // Session State
  final List<Map<String, dynamic>> _weakCharacters = [];
  final List<String> _phraseHistory = [];
  String? _errorMessage;
  String? _recordingPath;
  DateTime? _recordingStartTime;

  double _playbackSpeed = 0.8;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  // Haptic feedback has been added in global widgets where possible.

  void _exitSession() {
    if ((widget.initialContextSentence != null &&
            widget.initialContextSentence!.isNotEmpty) ||
        widget.initialHanzi != null ||
        widget.startSessionImmediately ||
        (widget.showBackButton && Navigator.of(context).canPop())) {
      Navigator.pop(context);
    } else {
      setState(() {
        _isSessionStarted = false;
        _currentPhrase = null;
        _lastGrade = null;
        _userPitch = const [];
        _idealPitch = const [];
        _sentenceCount = 0;
        _phraseHistory.clear();
        _weakCharacters.clear();
      });
    }
  }

  double _getHanziFontSize(int length) {
    if (length < 6) return widget.isCompact ? 40.0 : 56.0;
    if (length < 12) return widget.isCompact ? 32.0 : 44.0;
    if (length < 20) return widget.isCompact ? 24.0 : 32.0;
    return widget.isCompact ? 20.0 : 28.0;
  }

  double _getPinyinFontSize(int length) {
    if (length < 6) return widget.isCompact ? 20.0 : 28.0;
    if (length < 12) return widget.isCompact ? 16.0 : 22.0;
    if (length < 20) return widget.isCompact ? 14.0 : 18.0;
    return widget.isCompact ? 12.0 : 16.0;
  }

  @override
  void initState() {
    super.initState();
    if (widget.startSessionImmediately || widget.initialPhrase != null) {
      _isSessionStarted = true;
      if (widget.initialSelectedMode != null) {
        _selectedMode = widget.initialSelectedMode!;
      }
      if (widget.initialSelectedTheme != null) {
        _selectedTheme = widget.initialSelectedTheme!;
      }
      if (widget.initialSelectedDeckId != null) {
        _selectedDeckId = widget.initialSelectedDeckId;
      }
      if (widget.initialCustomWordInput != null) {
        _customWordInput = widget.initialCustomWordInput!;
      }
      if (widget.initialPhrase != null) {
        _currentPhrase = Map<String, String>.from(widget.initialPhrase!);
        _sentenceCount = 1;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _fetchNextPhrase();
        });
      }
    } else if (widget.initialContextSentence != null &&
        widget.initialContextSentence!.isNotEmpty) {
      // Whatever block arrived - the browser can hand over a whole paragraph -
      // practise a line a person can actually repeat. Shortened only when no
      // pinyin came with it, so the line and its pinyin can never disagree.
      final String sentence = widget.initialPinyin == null
          ? shadowingLine(
              widget.initialContextSentence!,
              widget.initialHanzi ?? '',
            )
          : widget.initialContextSentence!;
      _selectedMode = ShadowingMode.customSentence;
      _customWordInput = sentence;
      _isSessionStarted = true;
      if (widget.initialPinyin != null || widget.initialTranslation != null) {
        _currentPhrase = {
          "hanzi": sentence,
          "pinyin": widget.initialPinyin ?? "",
          "english": widget.initialTranslation ?? "",
        };
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _fetchNextPhrase();
        });
      }
    } else if (widget.initialHanzi != null) {
      _selectedMode = ShadowingMode.customWord;
      _customWordInput = widget.initialHanzi!;
      _isSessionStarted = true;
      _currentPhrase = {
        "hanzi": widget.initialHanzi!,
        "pinyin": widget.initialPinyin ?? "",
        "english": widget.initialTranslation ?? "",
      };
    }

    _pulseController = AnimationController(
      vsync: this,
      duration: ZenMotion.ambientFast,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: ZenMotion.natural),
    );
  }

  @override
  void dispose() {
    // Stop any active recording before disposing to prevent crashes
    if (_isRecording) {
      try {
        _audioRecorder.stop();
      } catch (_) {
        // Ignore — recorder may already be in an invalid state
      }
    }
    if (_recordingPath != null) {
      try {
        final file = File(_recordingPath!);
        if (file.existsSync()) {
          file.deleteSync();
        }
      } catch (e) {
        debugPrint("Error deleting shadowing recording on dispose: $e");
      }
    }
    _audioRecorder.dispose();
    _pulseController.dispose();
    _searchDebounce?.cancel();
    _customWordController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _searchDebounce?.cancel();
    if (query.trim().isEmpty) {
      setState(() => _dictionaryResults = []);
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 250), () async {
      final repo = ref.read(globalDictionaryRepositoryProvider);
      final result = await repo.search(query);
      if (mounted) {
        setState(() {
          _dictionaryResults = result.getOrElse((_) => []);
        });
      }
    });
  }

  Future<void> _startSession() async {
    if (_isStartingSession) return;
    final consent = await AiConsentSheet.ensureConsent(context);
    if (!consent || !mounted) return;
    setState(() {
      _isStartingSession = true;
      _errorMessage = null;
    });
    try {
      if (_currentPhrase == null) {
        await _fetchNextPhrase();
      }
      if (mounted && _currentPhrase != null) {
        if (!widget.showBackButton) {
          final phraseToPass = _currentPhrase;
          _currentPhrase = null;
          await Navigator.of(context, rootNavigator: true).push(
            SwipeBackRoute(
              builder: (context) => ShadowingStudioScreen(
                showBackButton: true,
                startSessionImmediately: true,
                initialSelectedMode: _selectedMode,
                initialSelectedTheme: _selectedTheme,
                initialSelectedDeckId: _selectedDeckId,
                initialCustomWordInput: _customWordInput,
                initialPhrase: phraseToPass,
              ),
            ),
          );
        } else {
          setState(() => _isSessionStarted = true);
        }
      }
    } finally {
      if (mounted) setState(() => _isStartingSession = false);
    }
  }

  /// The learner's measured pitch contour, in Hz, `null` where nothing was voiced.
  ///
  /// Returns an empty list instead of throwing: this is display data, and failing to
  /// draw a graph must never be able to fail a grading pass.
  Future<List<double?>> _measurePitch(Uint8List bytes) async {
    try {
      return await PitchDetectorService().extractPitchContour(bytes);
    } catch (e) {
      debugPrint('Shadowing pitch contour failed: $e');
      return const [];
    }
  }

  /// The shape the phrase's tones should have made — the dashed target stroke.
  ///
  /// Built from the tones Azure *expects*, in phrase order, one equal slot each. It is
  /// **not time-aligned to the recording**: Azure returns no per-syllable offsets, so
  /// where each character begins is unknown. See `PitchContourMath.idealForTones`, and
  /// the note the graph's own lightbulb carries.
  ///
  /// The shape is centred on the learner's own median pitch so the two strokes sit at
  /// comparable heights. A tone is a *shape*, not an absolute pitch, and a target pinned
  /// at a fixed 150 Hz would make a clean match on a higher voice look like a miss.
  List<double?> _idealPitchFor(
    Map<String, dynamic> grade,
    List<double?> measured,
  ) {
    final words = grade['words'];
    if (words is! List || words.isEmpty) return const [];

    final tones = <int>[];
    for (final word in words) {
      if (word is! Map) continue;
      tones.add((word['expectedTone'] as num?)?.toInt() ?? 0);
    }
    if (tones.isEmpty) return const [];

    final voiced = measured.whereType<double>().toList()..sort();
    final baseHz = voiced.isEmpty ? 150.0 : voiced[voiced.length ~/ 2];
    return PitchContourMath.idealForTones(tones, baseHz: baseHz);
  }

  Future<void> _fetchNextPhrase() async {
    setState(() {
      _isLoadingNextPhrase = true;
      _lastGrade = null;
      // A new phrase means the old graph is about a different sentence.
      _userPitch = const [];
      _idealPitch = const [];
      _errorMessage = null;
      _sentenceCount++;
      // Cleanse any stuck recording/grading states when transitioning
      _isRecording = false;
      _isGrading = false;
      _isStopping = false;
    });

    try {
      // Her sentences come from her own bank, not from the model: a theme handed to
      // Gemini is a hint, and "only sentences related to love" has to be a guarantee.
      // The bank is local, so the line also arrives with no key and no connection. Her
      // *own* words are the exception — see `shadowingBankAppliesTo`.
      if (HerAccount.isHer(ref.read(currentUserProvider)?.email) &&
          HerContent.shadowingBankAppliesTo(_selectedMode.toString())) {
        final Map<String, String> phrase =
            HerContent.shadowingSentenceAfter(_phraseHistory);
        if (mounted) {
          setState(() {
            _currentPhrase = phrase;
            _isLoadingNextPhrase = false;
            _phraseHistory.add(phrase['hanzi'] ?? '');
          });
        }
        return;
      }

      final geminiService = ref.read(geminiServiceProvider);

      String contextInput = "";
      if (_selectedMode == ShadowingMode.theme) {
        contextInput = "Theme: $_selectedTheme";
      }
      if (_selectedMode == ShadowingMode.deck) {
        final decks = ref.read(deckControllerProvider).valueOrNull ?? [];
        final deck = decks.firstWhere((d) => d.id == _selectedDeckId,
            orElse: () => decks.first);
        contextInput = "Flashcard Deck: ${deck.name}";
      }
      if (_selectedMode == ShadowingMode.customWord) {
        contextInput = "Word: $_customWordInput";
      }
      if (_selectedMode == ShadowingMode.customSentence) {
        contextInput = "Exact Sentence: $_customWordInput";
      }
      if (_selectedMode == ShadowingMode.freeFlow) {
        contextInput = "Free flow conversational practice.";
      }

      final phrase = await geminiService.generateShadowingPhrase(
          _selectedMode.toString(), contextInput,
          previousPhrases: _phraseHistory);

      if (mounted) {
        setState(() {
          _currentPhrase = phrase;
          _isLoadingNextPhrase = false;
          _phraseHistory.add(phrase['hanzi'] ?? '');
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Failed to generate phrase. Please try again.";
          _isLoadingNextPhrase = false;
        });
      }
    }
  }

  Future<void> _playNativeAudio() async {
    if (_currentPhrase == null) return;
    HapticsManager.light();
    final audioService = ref.read(audioServiceProvider);
    final mappedRate = _playbackSpeed == 0.8 ? 0.40 : 0.50;
    await audioService.playSentence(
      _currentPhrase!['hanzi']!,
      voiceName: 'Kore',
      speechRate: mappedRate,
      playbackRate: 1.0,
    );
  }

  Future<void> _startRecording() async {
    if (_isRecording || _isGrading || _isStopping) {
      return; // Prevent double-tap / rapid restart / re-entry
    }
    final consent = await AiConsentSheet.ensureConsent(context);
    if (!consent || !mounted) return;
    try {
      if (await _audioRecorder.hasPermission()) {
        HapticsManager.heavy();
        final tempDir = await getTemporaryDirectory();
        _recordingPath =
            '${tempDir.path}/shadow_recording_${DateTime.now().millisecondsSinceEpoch}.wav';
        _recordingStartTime = DateTime.now();

        await _audioRecorder.start(
          const RecordConfig(
              encoder: AudioEncoder.pcm16bits,
              sampleRate: 16000,
              numChannels: 1),
          path: _recordingPath!,
        );
        setState(() {
          _isRecording = true;
          // Reduced motion: mark recording without a breathing pulse.
          if (!context.reduceMotion) {
            _pulseController.repeat(reverse: true);
          }
        });
      } else {
        if (mounted) {
          ZenToast.error(
              context,
              AppLocalizations.of(context)
                      ?.microphonePermissionDeniedEnableItI ??
                  "Microphone permission denied. Enable it in Settings to use Shadowing Studio.");
        }
      }
    } catch (e) {
      debugPrint("Recording error: $e");
    }
  }

  Future<void> _stopRecordingAndGrade() async {
    // Guard: prevent re-entry if already stopping/grading
    if (_isStopping || !_isRecording) return;
    _isStopping = true;
    HapticsManager.light();

    try {
      // 1. Validate minimum recording duration BEFORE calling stop()
      //    This prevents InvalidAudioBufferException from being thrown
      //    when the internal audio buffer is empty/corrupted.
      final recordDuration = _recordingStartTime != null
          ? DateTime.now().difference(_recordingStartTime!)
          : Duration.zero;

      if (recordDuration.inMilliseconds < 400) {
        if (mounted) {
          setState(() {
            _isRecording = false;
            _isGrading = false;
            _pulseController.stop();
            _pulseController.reset();
            _errorMessage = "Recording too short. Hold the mic button longer.";
          });
        }
        return;
      }

      // 2. Stop recorder (now safe — buffer has enough data)
      String? path;
      try {
        path = await _audioRecorder.stop();
      } catch (e) {
        debugPrint("Recorder stop error: $e");
        if (mounted) {
          setState(() {
            _isRecording = false;
            _isGrading = false;
            _pulseController.stop();
            _pulseController.reset();
            _errorMessage = "Recording error. Please try again.";
          });
        }
        return;
      }

      setState(() {
        _isRecording = false;
        _isGrading = true;
        _pulseController.stop();
        _pulseController.reset();
      });

      if (path == null || _currentPhrase == null) {
        if (mounted) {
          setState(() {
            _isGrading = false;
            _errorMessage = "No recording captured. Please try again.";
          });
        }
        return;
      }

      // 3. Validate audio file
      final file = File(path);
      if (!file.existsSync() || file.lengthSync() < 1000) {
        if (mounted) {
          setState(() {
            _isGrading = false;
            _errorMessage =
                "Recorded audio is empty. Please try again and speak clearly.";
          });
        }
        return;
      }

      // 4. Grade
      try {
        final bytes = await file.readAsBytes();

        // Measure the learner's own voice first. This is only for the graph — the
        // *verdict* comes from `gradeAudio` — but doing it here means the picture of
        // what they said is drawn from the recording itself rather than from the
        // grader's opinion of it.
        final measuredPitch = await _measurePitch(bytes);

        final geminiService = ref.read(geminiServiceProvider);
        final grade = await geminiService.gradeAudio(
          bytes,
          _currentPhrase!['hanzi']!,
          _currentPhrase!['pinyin']!,
        );

        if (mounted) {
          setState(() {
            _lastGrade = grade;
            _userPitch = measuredPitch;
            _idealPitch = _idealPitchFor(grade, measuredPitch);
            _isGrading = false;

            if (grade['words'] != null) {
              for (var word in grade['words']) {
                if (word['isCorrect'] == false && word['isOmitted'] != true) {
                  final existingIndex = _weakCharacters
                      .indexWhere((w) => w['word'] == word['word']);
                  if (existingIndex >= 0) {
                    _weakCharacters[existingIndex] = word;
                  } else {
                    _weakCharacters.add(word);
                  }
                }
              }
            }
          });
        }
      } on Exception catch (e) {
        final msg = e.toString();
        debugPrint("Grading error: $msg");
        if (mounted) {
          setState(() {
            _isGrading = false;
            if (msg.contains("Azure Speech API keys are missing")) {
              _errorMessage =
                  "Azure Speech keys not configured. Add AZURE_SPEECH_KEY and AZURE_SPEECH_REGION to .env";
            } else if (msg.contains("Azure Error 401")) {
              _errorMessage =
                  "Azure authentication failed. Check your Speech API key and region in .env";
            } else if (msg.contains("Azure Error 429")) {
              // Was a hardcoded English sentence; the 14-locale key already
              // existed for exactly this message.
              _errorMessage =
                  AppLocalizations.of(context)!.azureQuotaExceededTryAgainLater;
            } else if (msg.contains("TimeoutException") ||
                msg.contains("timed out")) {
              _errorMessage =
                  "Azure grading timed out. Check your internet connection.";
            } else if (msg.contains("Recognition failed: null") ||
                msg.contains("null")) {
              _errorMessage = "Could not hear you clearly. Please try again.";
            } else {
              _errorMessage = "Error analyzing audio: $e";
            }
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isStopping = false;
        });
      }
    }
  }

  void _showSessionSummaryDialog(BuildContext context, bool isDark) {
    if (_weakCharacters.isEmpty) {
      // Perfect session or just aborting, go back to Hub UI or pop
      _exitSession();
      return;
    }

    final Set<String> selectedWords =
        _weakCharacters.map((w) => w['word'] as String).toSet();

    zenSheet(context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor:
            isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (context) {
      return StatefulBuilder(builder: (context, setModalState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)?.sessionSummary ??
                    "Session Summary",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)
                        ?.hereAreTheCharactersYouStruggledWit ??
                    "Here are the characters you struggled with:",
                style:
                    TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height * 0.5),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _weakCharacters.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final wordData = _weakCharacters[index];
                    final word = wordData['word'];
                    final feedback = wordData['feedback'] ?? '';
                    final isPartial = wordData['isPartial'] ?? false;
                    final isSelected = selectedWords.contains(word);

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                        value: isSelected,
                        activeColor: _accentOf(isDark),
                        onChanged: (val) {
                          setModalState(() {
                            if (val == true) {
                              selectedWords.add(word);
                            } else {
                              selectedWords.remove(word);
                            }
                          });
                        },
                      ),
                      title: Text(
                        word,
                        style: TextStyle(
                          fontSize: 28,
                          color:
                              isPartial ? _accentOf(isDark) : _alertOf(isDark),
                        ),
                      ),
                      subtitle: feedback.isNotEmpty
                          ? Text(feedback,
                              style: TextStyle(
                                  color:
                                      isDark ? Colors.white70 : Colors.black87))
                          : null,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // close sheet
                        _exitSession();
                      },
                      child: Text(AppLocalizations.of(context)!.skip,
                          style:
                              TextStyle(color: _mutedOf(isDark), fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // Book-screen primary: Deep Carbon Ink in light mode,
                        // Emperor's Gold in dark mode.
                        backgroundColor: isDark
                            ? Colors.amber.shade700
                            : const Color(0xFF1A1A1B),
                        foregroundColor:
                            isDark ? const Color(0xFF1A1A1B) : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: selectedWords.isEmpty
                          ? null
                          : () {
                              Navigator.pop(context); // close sheet
                              _showDeckSelectionDialog(
                                  context, isDark, selectedWords.toList());
                            },
                      child: Text(
                          AppLocalizations.of(context)!.addSelectedToDeck,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      });
    });
  }

  void _showDeckSelectionDialog(
      BuildContext context, bool isDark, List<String> wordsToAdd) {
    bool applySrs = true;

    zenSheet(context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: isDark
            ? const Color(0xFF1A1A1B)
            : const Color(0xFFFDFCF0), builder: (context) {
      return StatefulBuilder(builder: (context, setModalState) {
        final decksAsync = ref.watch(deckControllerProvider);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.selectADeck,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text(
                    "Apply session grades to Spaced Repetition (Speaking Mode)",
                    style: TextStyle(fontSize: 14)),
                activeThumbColor: _accentOf(isDark),
                value: applySrs,
                onChanged: (val) => setModalState(() => applySrs = val),
                contentPadding: EdgeInsets.zero,
              ),
              const Divider(),
              if (decksAsync.isLoading)
                Center(child: ZenLoader(color: _accentOf(isDark))),
              if (decksAsync.hasValue && decksAsync.value!.isEmpty)
                Text(AppLocalizations.of(context)!.no_decks_found),
              if (decksAsync.hasValue && decksAsync.value!.isNotEmpty)
                ...decksAsync.value!.map((deck) => ListTile(
                      title: Text(deck.name,
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black)),
                      subtitle: Text(
                          AppLocalizations.of(context)!.exportToThisDeck,
                          style: TextStyle(
                              color: isDark ? Colors.white54 : Colors.black54)),
                      trailing: Icon(Icons.add_circle_outline,
                          color: _accentOf(isDark)),
                      onTap: () async {
                        Navigator.pop(context); // Close deck selector
                        _exitSession();

                        await _saveWordsToDeck(
                            context, deck, applySrs, wordsToAdd);
                      },
                    )),
              const Divider(),
              ListTile(
                title: Text(AppLocalizations.of(context)!.createNewDeck,
                    style: TextStyle(
                        color: _accentOf(isDark), fontWeight: FontWeight.bold)),
                subtitle: Text(
                    AppLocalizations.of(context)!.makeACustomCollection,
                    style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54)),
                trailing: Icon(Icons.add_circle, color: _accentOf(isDark)),
                onTap: () {
                  _showCreateDeckDialog(context, isDark, wordsToAdd, applySrs);
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      });
    });
  }

  void _showCreateDeckDialog(BuildContext context, bool isDark,
      List<String> wordsToAdd, bool applySrs) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _cardOf(isDark),
          title: Text(AppLocalizations.of(context)!.newDeckName,
              style: TextStyle(color: _inkOf(isDark))),
          content: HanziTextField(
            controller: controller,
            style: TextStyle(color: _inkOf(isDark)),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.egAnimeVocab,
              hintStyle: TextStyle(color: _mutedOf(isDark)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _accentOf(isDark))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _accentOf(isDark))),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelAction,
                  style: TextStyle(color: _mutedOf(isDark))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark ? Colors.amber.shade700 : const Color(0xFF1A1A1B),
                foregroundColor:
                    isDark ? const Color(0xFF1A1A1B) : Colors.white,
              ),
              onPressed: () async {
                if (controller.text.trim().isEmpty) return;

                final deckName = controller.text.trim();
                final deckController =
                    ref.read(deckControllerProvider.notifier);

                final newDeck = await deckController.createDeck(deckName);

                if (context.mounted && newDeck != null) {
                  Navigator.pop(context); // close create dialog
                  Navigator.pop(context); // close select deck bottom sheet
                  _exitSession();

                  await _saveWordsToDeck(
                      context, newDeck, applySrs, wordsToAdd);
                }
              },
              child: Text(AppLocalizations.of(context)!.createAction,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveWordsToDeck(BuildContext context, Deck deck, bool applySrs,
      List<String> wordsToAdd) async {
    final flashcardController = ref.read(flashcardControllerProvider.notifier);
    ZenToast.info(
        context,
        AppLocalizations.of(context)!
            .saving_words_to(wordsToAdd.length, deck.name));

    for (String hanzi in wordsToAdd) {
      // Check if word exists in deck
      final existing = ref
          .read(flashcardControllerProvider)
          .valueOrNull
          ?.where((c) => c.hanzi == hanzi && c.deckId == deck.id)
          .toList();

      Flashcard card;
      if (existing != null && existing.isNotEmpty) {
        card = existing.first;
      } else {
        // Get weak-character context from session grading (pinyin fallback)
        final wData = _weakCharacters.firstWhere((w) => w['word'] == hanzi,
            orElse: () => {});
        // Hydrate from the bundled dictionary for authoritative pinyin + definition
        final dictResult =
            await ref.read(globalDictionaryRepositoryProvider).getExact(hanzi);
        card = Flashcard(
          id: DateTime.now().millisecondsSinceEpoch.toString() +
              hanzi.hashCode.toString(),
          deckId: deck.id,
          hanzi: hanzi,
          pinyin: dictResult?.pinyin ?? wData['pinyin'] ?? "",
          definition: dictResult?.definition ?? "",
          hskLevel: dictResult?.hskLevel ?? 0,
          strokePaths: const [],
          modeStats: const {},
        );
        await flashcardController.addFlashcard(card);
      }

      // Apply SRS Logic
      if (applySrs) {
        final wData = _weakCharacters.firstWhere((w) => w['word'] == hanzi,
            orElse: () => {});
        final isPartial = wData['isPartial'] ?? false;

        int sm2Grade = 0; // Again
        if (isPartial) {
          sm2Grade = 2; // Hard
        }

        final updatedCard = card.processReview(sm2Grade, StudyMode.speaking);
        await flashcardController.updateFlashcard(updatedCard);
      }
    }

    if (!context.mounted) return;
    ZenToast.success(
        context, AppLocalizations.of(context)!.wordsSavedAndSrsScheduled);
  }

  // ── Book-screen parity tokens ───────────────────────────────────────────────
  // Sourced from [AppTheme] so every screen shares one visual vocabulary.
  static const Color _bookBgDark = AppTheme.surfaceDark;
  static const Color _bookBgLight = AppTheme.surfaceLight;
  static const Color _bookCardBgDark = AppTheme.cardBgDark;
  static const Color _bookCardBgLight = AppTheme.cardBgLight;
  static const Color _bookAccentDark = AppTheme.accentDark;
  static const Color _bookAccentLight = AppTheme.accentLight;
  static const IconData _configCardIcon = Icons.settings_rounded;

  // ── Session palette (book-screen parity) ───────────────────────────────────
  //
  // The live shadowing flow used to speak a different visual language: a
  // `Colors.orange` accent, Material `Colors.green`/`Colors.red` verdicts, an M3
  // `colorScheme.surface` background and its own radii — so the screen you spend
  // the whole session on looked like a different app from the hub, the reader and
  // the book screens. These helpers route it through the same [AppTheme] tokens.
  static Color _accentOf(bool isDark) =>
      isDark ? _bookAccentDark : _bookAccentLight;

  static Color _inkOf(bool isDark) =>
      isDark ? Colors.white : const Color(0xFF1A1A1B);

  static Color _mutedOf(bool isDark) =>
      isDark ? Colors.white60 : const Color(0xFF6B655B);

  static Color _bgOf(bool isDark) => isDark ? _bookBgDark : _bookBgLight;

  static Color _cardOf(bool isDark) =>
      isDark ? _bookCardBgDark : _bookCardBgLight;

  /// Emperor's Gold hairline, as used by every calligraphic surface.
  static Color _goldOf(bool isDark) =>
      isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);

  /// Jade Green success, per `docs/UI_UX_STANDARDS.md` § Colour Palette.
  static const Color _successOf = Color(0xFF2E7D32);

  /// The documented Cinnabar alert red. Recording is a *live* state and a failed
  /// grade is an alert, so both wear this rather than the accent — which would
  /// read as "tap me" while the mic is already running.
  static Color _alertOf(bool isDark) =>
      isDark ? Colors.redAccent : const Color(0xFFC62828);

  Widget _buildSectionLabel({
    required IconData icon,
    required String title,
    required bool isDark,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? _bookAccentDark : _bookAccentLight,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing,
          ],
        ],
      ),
    );
  }

  Widget _buildSegmentModeTab({
    required ShadowingMode mode,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    final isSelected = _selectedMode == mode;
    final accent = isDark ? _bookAccentDark : _bookAccentLight;
    return GestureDetector(
      onTap: () {
        if (_selectedMode != mode) {
          setState(() => _selectedMode = mode);
          HapticsManager.selection();
        }
      },
      child: AnimatedContainer(
        duration: ZenMotion.of(context, ZenMotion.swap),
        curve: ZenMotion.natural,
        decoration: BoxDecoration(
          color: isSelected
              ? accent.withValues(alpha: 0.12)
              : (isDark ? _bookCardBgDark : _bookCardBgLight),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? accent
                : (isDark
                    ? Colors.white10
                    : Colors.black.withValues(alpha: 0.06)),
            width: isSelected ? 1.3 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? accent
                  : (isDark ? Colors.white60 : Colors.black45),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? accent
                      : (isDark ? Colors.white70 : const Color(0xFF2C2C2E)),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  fontSize: 12.5,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturePill({
    required IconData icon,
    required String label,
    required bool isDark,
    Color? color,
  }) {
    // Matches the book-screen badge vocabulary (pill radius, tinted fill+border).
    final badgeColor = color ?? (isDark ? _bookAccentDark : _bookAccentLight);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showStudioGuideSheet(BuildContext context, bool isDark) {
    zenSheet(
      context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: isDark ? _bookCardBgDark : _bookCardBgLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(
            color:
                isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.08),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black26,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              _buildStudioGuideCard(sheetContext, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudioGuideCard(BuildContext context, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? _bookCardBgDark : _bookCardBgLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (isDark ? _bookAccentDark : _bookAccentLight)
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 22,
                  color: isDark ? _bookAccentDark : _bookAccentLight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.shadowingStudioAndToneAnalysis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.shadowNativeAudioAndVisualize,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : const Color(0xFF2C2C2E),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildPillarStep(
                  step: '1',
                  label: l10n.play,
                  icon: Icons.headphones_rounded,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildPillarStep(
                  step: '2',
                  label: l10n.shadowing,
                  icon: Icons.mic_rounded,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildPillarStep(
                  step: '3',
                  label: l10n.toneAccuracy,
                  icon: Icons.analytics_outlined,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPillarStep({
    required String step,
    required String label,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: isDark ? _bookCardBgDark : _bookCardBgLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark ? _bookAccentDark : _bookAccentLight,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white70 : const Color(0xFF2C2C2E),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildConfigCard({
    required bool isDark,
    required String label,
    required Widget child,
  }) {
    final cardBg = isDark ? _bookCardBgDark : _bookCardBgLight;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _configCardIcon,
                size: 20,
                color: isDark ? _bookAccentDark : _bookAccentLight,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark ? _bookAccentDark : _bookAccentLight,
                    letterSpacing: 0.9,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildHubUI(BuildContext context, bool isDark) {
    final bgColor = isDark ? _bookBgDark : _bookBgLight;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        top: widget.showBackButton,
        bottom: widget.showBackButton,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Content (starts directly with Practice Mode) ──────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
// ── Mode Selector Section ─────────────────────
                    _buildSectionLabel(
                      icon: Icons.tune_rounded,
                      title: l10n.practiceMode,
                      isDark: isDark,
                      trailing: GestureDetector(
                        onTap: () => _showStudioGuideSheet(context, isDark),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 20,
                            color: isDark ? _bookAccentDark : _bookAccentLight,
                          ),
                        ),
                      ),
                    ),
GridView(
                        gridDelegate: ZenGrid.tiles(
                            maxTileWidth: 170,
                            childAspectRatio: 2.35,
                            crossSpacing: 10,
                            mainSpacing: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildSegmentModeTab(
                            mode: ShadowingMode.freeFlow,
                            icon: Icons.mic_none_rounded,
                            label: l10n.freeFlow,
                            isDark: isDark,
                          ),
                          _buildSegmentModeTab(
                            mode: ShadowingMode.theme,
                            icon: Icons.auto_stories_rounded,
                            label: l10n.thematic,
                            isDark: isDark,
                          ),
                          _buildSegmentModeTab(
                            mode: ShadowingMode.deck,
                            icon: Icons.style_rounded,
                            label: l10n.deckFlashcards,
                            isDark: isDark,
                          ),
                          _buildSegmentModeTab(
                            mode: ShadowingMode.customWord,
                            icon: Icons.text_fields_rounded,
                            label: l10n.customWord,
                            isDark: isDark,
                          ),
                        ]),
const SizedBox(height: 14),
// ── Configuration Section ─────────────────────
                    _buildSectionLabel(
                      icon: Icons.settings_rounded,
                      title: AppLocalizations.of(context)!.configuration,
                      isDark: isDark,
                    ),
if (_selectedMode == ShadowingMode.freeFlow) ...[
                      _buildConfigCard(
                        isDark: isDark,
                        label: l10n.practiceMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.freeFlowConversationalPractice,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white70
                                    : const Color(0xFF2C2C2E),
                                fontSize: 14,
                                height: 1.55,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _buildFeaturePill(
                                  icon: Icons.check_circle_outline_rounded,
                                  label: l10n.toneAccuracy,
                                  isDark: isDark,
                                  color: isDark
                                      ? Colors.green.shade300
                                      : Colors.teal.shade700,
                                ),
                                _buildFeaturePill(
                                  icon: Icons.graphic_eq_rounded,
                                  label: l10n.pronunciationAssessment,
                                  isDark: isDark,
                                  color: isDark
                                      ? Colors.blue.shade300
                                      : Colors.indigo.shade700,
                                ),
                                _buildFeaturePill(
                                  icon: Icons.speed_rounded,
                                  label: '0.8x / 1.0x',
                                  isDark: isDark,
                                  color: isDark
                                      ? Colors.purple.shade300
                                      : Colors.deepPurple.shade700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
if (_selectedMode == ShadowingMode.customWord) ...[
                      _buildConfigCard(
                        isDark: isDark,
                        label: AppLocalizations.of(context)!.chinese_character,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (hasFocus != _isSearchFocused) {
                                  setState(() => _isSearchFocused = hasFocus);
                                }
                              },
                              child: HanziTextField(
                                controller: _customWordController,
                                showClearButton: true,
                                textInputAction: TextInputAction.search,
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  size: 20,
                                  color:
                                      isDark ? Colors.white54 : Colors.black45,
                                ),
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .searchDictionaryOrTypeCustom,
                                  hintStyle: TextStyle(
                                    color: isDark
                                        ? Colors.white38
                                        : Colors.black38,
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: isDark
                                      ? const Color(0xFF2C2C2E)
                                      : Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 14),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color: isDark
                                          ? Colors.white24
                                          : Colors.black26,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color: isDark
                                          ? _bookAccentDark
                                          : _bookAccentLight,
                                      width: 1.3,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 16,
                                ),
                                onChanged: (val) {
                                  setState(() => _customWordInput = val);
                                  _onSearchChanged(val);
                                },
                              ),
                            ),
                            if (_dictionaryResults.isNotEmpty)
                              Container(
                                width: double.infinity,
                                constraints:
                                    const BoxConstraints(maxHeight: 250),
                                margin: const EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? _bookCardBgDark
                                      : _bookCardBgLight,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      color: isDark
                                          ? Colors.white10
                                          : Colors.black
                                              .withValues(alpha: 0.06)),
                                ),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: _dictionaryResults.length,
                                  itemBuilder: (context, index) {
                                    final card = _dictionaryResults[index];
                                    return ListTile(
                                      title: Text(card.hanzi,
                                          style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            '${PinyinUtils.convertNumericToMarks(card.pinyin)} - ',
                                            style: TextStyle(
                                                color: isDark
                                                    ? Colors.white70
                                                    : Colors.black54),
                                          ),
                                          Expanded(
                                            child: TranslatedDefinition(
                                              definition: card.definition,
                                              originalStyle: TextStyle(
                                                  color: isDark
                                                      ? Colors.white70
                                                      : Colors.black54),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _customWordInput = card.hanzi;
                                          _customWordController.text =
                                              card.hanzi;
                                          _dictionaryResults = [];
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                    if (_selectedMode == ShadowingMode.theme) ...[
                      _buildConfigCard(
                        isDark: isDark,
                        label: AppLocalizations.of(context)!.hsk_level,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedTheme,
                            isExpanded: true,
                            dropdownColor:
                                isDark ? const Color(0xFF2C2C2E) : Colors.white,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF1A1A1B),
                              fontSize: 15,
                            ),
                            items: <(String, String)>[
                              ('HSK 1', l10n.hsk1),
                              ('HSK 2', l10n.hsk2),
                              ('HSK 3', l10n.hsk3),
                              ('HSK 4', l10n.hsk4),
                              ('HSK 5', l10n.hsk5),
                              ('HSK 6', l10n.hsk6),
                              ('Native', l10n.native),
                            ]
                                .map((theme) => DropdownMenuItem(
                                      value: theme.$1,
                                      child: Text(theme.$2),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedTheme = val);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                    if (_selectedMode == ShadowingMode.deck) ...[
                      _buildConfigCard(
                        isDark: isDark,
                        label: AppLocalizations.of(context)!.flashcardDeckTitle,
                        child: ref.watch(deckControllerProvider).when(
                              data: (decks) {
                                if (decks.isEmpty) {
                                  return Text(AppLocalizations.of(context)!
                                      .no_decks_found);
                                }
                                return ZenFadeIn(
                                    child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedDeckId ?? decks.first.id,
                                    isExpanded: true,
                                    dropdownColor: isDark
                                        ? const Color(0xFF2C2C2E)
                                        : Colors.white,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF1A1A1B),
                                      fontSize: 15,
                                    ),
                                    items: decks
                                        .map((d) => DropdownMenuItem(
                                            value: d.id, child: Text(d.name)))
                                        .toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() => _selectedDeckId = val);
                                      }
                                    },
                                  ),
                                ));
                              },
                              loading: () => const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                              error: (e, st) => Text(
                                  AppLocalizations.of(context)!
                                      .error_loading_decks),
                            ),
                      ),
                    ],
const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
// Start Button Area
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                widget.showBackButton ? 14 : 10,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  key: const Key('shadowing_start_session'),
                  onPressed: _isStartingSession ? null : _startSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? Colors.amber.shade700
                        : const Color(0xFF1A1A1B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isStartingSession)
                        const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      else
                        const Icon(Icons.mic, size: 22),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _isStartingSession
                              ? l10n.sTARTING
                              : l10n.startSession,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHanziPhraseView(bool isDark) {
    final hanziText = _currentPhrase!['hanzi'] ?? '';
    final targetHanzi = widget.initialHanzi?.trim();
    final fontSize = _getHanziFontSize(hanziText.length);
    final defaultColor = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final baseStyle = TextStyle(
      fontSize: fontSize,
      color: defaultColor,
      fontWeight: FontWeight.w500,
      height: 1.35,
    );

    if (targetHanzi == null ||
        targetHanzi.isEmpty ||
        !hanziText.contains(targetHanzi)) {
      return Text(
        hanziText,
        style: baseStyle,
        textAlign: TextAlign.center,
      );
    }

    // The practised characters wear the canonical accent, the way the reader
    // inks the sentence you are on — not Material indigo.
    final highlightColor = _accentOf(isDark);
    final highlightBg = highlightColor.withValues(alpha: isDark ? 0.28 : 0.16);

    final spans = <InlineSpan>[];
    int lastEnd = 0;
    for (final match
        in RegExp(RegExp.escape(targetHanzi)).allMatches(hanziText)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: hanziText.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: baseStyle.copyWith(
          color: highlightColor,
          backgroundColor: highlightBg,
          fontWeight: FontWeight.bold,
        ),
      ));
      lastEnd = match.end;
    }
    if (lastEnd < hanziText.length) {
      spans.add(TextSpan(
        text: hanziText.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return Text.rich(
      TextSpan(children: spans),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSpeedToggle(bool isDark) {
    final isSlow = (_playbackSpeed == 0.8);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('shadowing_speed_toggle'),
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          HapticsManager.selection();
          setState(() {
            _playbackSpeed = isSlow ? 1.0 : 0.8;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSlow
                ? _accentOf(isDark).withValues(alpha: isDark ? 0.22 : 0.10)
                : (isDark
                    ? Colors.white10
                    : Colors.black.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSlow
                  ? _goldOf(isDark)
                  : (isDark ? Colors.white24 : Colors.black12),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.speed_rounded,
                size: 16,
                color: isSlow ? _accentOf(isDark) : _mutedOf(isDark),
              ),
              const SizedBox(width: 4),
              Text(
                '${_playbackSpeed.toStringAsFixed(1)}x',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSlow ? _accentOf(isDark) : _mutedOf(isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionUI(BuildContext context, bool isDark) {
    final l10n = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _showSessionSummaryDialog(context, isDark);
      },
      child: Scaffold(
        // Xuan paper / carbon, not the M3 default surface: the session you spend
        // the whole flow on must sit on the same ground as the hub and the reader.
        backgroundColor: widget.isCompact ? Colors.transparent : _bgOf(isDark),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Top Bar
                        if (!widget.isCompact)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      size: 32, color: _inkOf(isDark)),
                                  tooltip: l10n?.back,
                                  onPressed: () => _showSessionSummaryDialog(
                                      context, isDark),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n?.shadowingStudio ??
                                            "Shadowing Studio",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: _inkOf(isDark)),
                                      ),
                                      Text(
                                        (_selectedMode ==
                                                    ShadowingMode.customWord ||
                                                _selectedMode ==
                                                    ShadowingMode
                                                        .customSentence)
                                            ? (l10n?.singlePhrasePractice ??
                                                "Single Phrase Practice")
                                            : (l10n?.endlessAiStreamSentence(
                                                    _sentenceCount) ??
                                                "Endless AI Stream • Sentence $_sentenceCount"),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: _accentOf(isDark),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _buildSpeedToggle(isDark),
                              ],
                            ),
                          ),
// Gold hairline under the header, as on every other
                        // calligraphic surface.
                        if (!widget.isCompact)
                          Container(
                            height: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            color: _goldOf(isDark).withValues(alpha: 0.25),
                          ),
if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(_errorMessage!,
                                    style: TextStyle(color: _alertOf(isDark)),
                                    textAlign: TextAlign.center),
                                if (_errorMessage!
                                    .contains("Failed to generate phrase")) ...[
                                  const SizedBox(height: 8),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _errorMessage = null;
                                      });
                                      if (_currentPhrase == null) {
                                        _fetchNextPhrase();
                                      }
                                    },
                                    icon: const Icon(Icons.refresh, size: 16),
                                    label: Text(
                                        AppLocalizations.of(context)!.retry),
                                  ),
                                ]
                              ],
                            ),
                          ),
// Main Content Area
                        Expanded(
                          child: _isLoadingNextPhrase
                              ? Center(
                                  child: ZenLoader(color: _accentOf(isDark)))
                              : _currentPhrase == null
                                  ? Center(
                                      child: Text(AppLocalizations.of(context)!
                                          .readyToStart))
                                  : _buildPhraseCard(isDark),
                        ),
// Bottom Actions Area
                        if (_currentPhrase != null && !_isLoadingNextPhrase)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 32.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Grading State
                                if (_isGrading)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // ZenLoader, not a bare spinner: the
                                      // standard forbids a section-level
                                      // CircularProgressIndicator.
                                      ZenLoader(
                                          strokeWidth: 2,
                                          color: _accentOf(isDark)),
                                      const SizedBox(width: 12),
                                      Flexible(
                                        child: Text(
                                          l10n?.aiIsGradingYourPronunciation ??
                                              "AI is grading your pronunciation...",
                                          style: TextStyle(
                                              color: _accentOf(isDark),
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
const SizedBox(height: 24),
Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Play Button
                                    IconButton(
                                      iconSize: widget.isCompact ? 36 : 48,
                                      color: _inkOf(isDark),
                                      icon: const Icon(Icons.play_circle_fill),
                                      tooltip: l10n?.play,
                                      onPressed: _playNativeAudio,
                                    ),
// Record Button (Hold)
                                    GestureDetector(
                                      onLongPressStart: (_) =>
                                          _startRecording(),
                                      onLongPressEnd: (_) =>
                                          _stopRecordingAndGrade(),
                                      child: BreathingWidget(
                                        isBreathing: _isRecording,
                                        child: AnimatedBuilder(
                                          animation: _pulseAnimation,
                                          builder: (context, child) {
                                            return Transform.scale(
                                              scale: _pulseAnimation.value,
                                              child: Container(
                                                width:
                                                    widget.isCompact ? 64 : 80,
                                                height:
                                                    widget.isCompact ? 64 : 80,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: _isRecording
                                                      ? _alertOf(isDark)
                                                      : _accentOf(isDark),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: (_isRecording
                                                                ? _alertOf(
                                                                    isDark)
                                                                : _accentOf(
                                                                    isDark))
                                                            .withValues(
                                                                alpha: 0.35),
                                                        blurRadius: _isRecording
                                                            ? 20
                                                            : 10,
                                                        spreadRadius:
                                                            _isRecording
                                                                ? 5
                                                                : 2),
                                                  ],
                                                ),
                                                child: Icon(Icons.mic,
                                                    size: widget.isCompact
                                                        ? 28
                                                        : 36,
                                                    // The dark-mode accent is
                                                    // light amber, so its glyph
                                                    // has to be ink; the light-mode
                                                    // accent (and both alert reds)
                                                    // are dark, so white wins.
                                                    color:
                                                        isDark && !_isRecording
                                                            ? const Color(
                                                                0xFF1A1A1B)
                                                            : Colors.white),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
// Next Button / Done Button
                                    if (!widget.isCompact)
                                      IconButton(
                                        iconSize: 48,
                                        color: _mutedOf(isDark),
                                        icon: Icon((_selectedMode ==
                                                    ShadowingMode.customWord ||
                                                _selectedMode ==
                                                    ShadowingMode
                                                        .customSentence)
                                            ? Icons.check_circle_outline
                                            : Icons.skip_next),
                                        tooltip: l10n?.skip,
                                        onPressed: () {
                                          if (_selectedMode ==
                                                  ShadowingMode.customWord ||
                                              _selectedMode ==
                                                  ShadowingMode
                                                      .customSentence) {
                                            Navigator.of(context).pop();
                                          } else {
                                            _fetchNextPhrase();
                                          }
                                        },
                                      ),
                                  ],
                                ),
                                SizedBox(height: widget.isCompact ? 8 : 16),
                                Text(
                                  l10n?.holdMicToRecordReleaseToGrade ??
                                      "Hold mic to record. Release to grade.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: _mutedOf(isDark),
                                      fontSize: widget.isCompact ? 12 : 14),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getLocalizedOverallFeedback(
      String? feedback, AppLocalizations? l10n) {
    if (feedback == null || feedback.isEmpty || l10n == null) {
      return feedback ?? '';
    }
    switch (feedback) {
      case 'Perfect pronunciation! Sounds like a native speaker.':
        return l10n.perfectPronunciationSoundsLikeANati;
      case 'Great job! A few minor tone inaccuracies.':
        return l10n.greatJobAFewMinorToneInaccuracies;
      case 'Not bad, but your tones need some work.':
        return l10n.notBadButYourTonesNeedSomeWork;
      case 'Keep practicing! Listen to the native audio and try again.':
        return l10n.keepPracticingListenToTheNativeAudi;
      case 'Good effort! Keep practicing.':
        return l10n.goodEffortKeepPracticing;
      default:
        return feedback;
    }
  }

  Widget _buildPhraseCard(bool isDark) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // If we have a grade, show it above the text!
          if (_lastGrade != null)
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _cardOf(isDark),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _lastGrade!['score'] >= 80
                      ? _successOf
                      : _accentOf(isDark),
                  width: 1.4,
                ),
              ),
              child: Column(
                children: [
                  // A number only when there was something to score. `heardPhrase` is
                  // false when nothing was assessed or the whole phrase was skipped, and
                  // "0/100" beside "we could not hear the phrase" contradicts itself:
                  // 0% reads as *an attempt that scored nothing*, which is a different
                  // and harsher claim than *not an attempt at all*.
                  if (_lastGrade!['heardPhrase'] != false)
                    Text(
                      l10n != null
                          ? l10n.score(_lastGrade!['score'], 100)
                          : "Score: ${_lastGrade!['score']}/100",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _lastGrade!['score'] >= 80
                            ? _successOf
                            : _accentOf(isDark),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    _getLocalizedOverallFeedback(
                        _lastGrade!['overallFeedback'], l10n),
                    style: TextStyle(fontSize: 16, color: _mutedOf(isDark)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
// The Phrase
          if (_lastGrade == null || _lastGrade!['words'] == null) ...[
            Text(
              _currentPhrase!['pinyin']!,
              style: TextStyle(
                fontSize: _getPinyinFontSize(_currentPhrase!['hanzi']!.length),
                color: _mutedOf(isDark),
                fontStyle: FontStyle.italic,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildHanziPhraseView(isDark),
          ] else ...[
            // Breakdown view
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 4,
              children: (_lastGrade!['words'] as List).map<Widget>((item) {
                final isCorrect = item['isCorrect'] ?? false;
                final isPartial = item['isPartial'] ?? false;
                final isOmitted = item['isOmitted'] ?? false;

                // Verdicts in the documented palette: Jade Green for a correct
                // character, the accent for a near miss, the Cinnabar alert for a
                // miss and muted ink for one that was never attempted.
                final Color color = isOmitted
                    ? _mutedOf(isDark)
                    : isCorrect
                        ? _successOf
                        : isPartial
                            ? _accentOf(isDark)
                            : _alertOf(isDark);

                return GestureDetector(
                  onTap: () =>
                      _showWordDetailSheet(context, isDark, item, color),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item['pinyin'] ?? "",
                        style: TextStyle(
                            fontSize: _getPinyinFontSize(
                                    _currentPhrase!['hanzi']!.length) *
                                0.8,
                            color: color,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        item['word'] ?? "",
                        style: TextStyle(
                          fontSize: _getHanziFontSize(
                              _currentPhrase!['hanzi']!.length),
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
          if (_lastGrade != null && _userPitch.isNotEmpty) ...[
            const SizedBox(height: 24),
            ToneGraphCard(
              userPitch: _userPitch,
              idealPitch: _idealPitch,
              height: 120,
              // The two strokes are not time-aligned here — Azure returns no syllable
              // offsets, so the target is drawn as equal slots — and the lightbulb is
              // where that gets said, rather than letting the graph imply an alignment
              // it cannot have.
              helpNote:
                  AppLocalizations.of(context)?.toneGraphHowToReadPhraseNote,
            ),
          ],

          const SizedBox(height: 24),
          TranslatedDefinition(
            definition: _currentPhrase!['english']!,
            hanzi: _currentPhrase!['hanzi'],
            definitionLanguage: 'English',
            originalStyle: TextStyle(
              fontSize: widget.isCompact ? 16 : 20,
              color: _mutedOf(isDark),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showWordDetailSheet(BuildContext context, bool isDark,
      Map<String, dynamic> wordData, Color wordColor) {
    final word = wordData['word'] ?? '';
    final feedback = wordData['feedback'] ?? '';
    final isCorrect = wordData['isCorrect'] ?? false;
    final isPartial = wordData['isPartial'] ?? false;
    final isOmitted = wordData['isOmitted'] ?? false;

    final l10n = AppLocalizations.of(context);
    String errorLabel;
    if (isOmitted) {
      errorLabel = l10n?.omitted ?? 'Omitted';
    } else if (isCorrect) {
      errorLabel = l10n?.correct ?? 'Correct';
    } else if (isPartial) {
      errorLabel = l10n?.partial ?? 'Partial';
    } else {
      errorLabel = l10n?.mispronounced ?? 'Mispronounced';
    }

    zenSheet(
      context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor:
          isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              left: 24,
              right: 24,
              top: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      // Same handle as every other sheet in the app.
                      color: isDark ? Colors.white24 : Colors.black12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Word in large font
                Text(
                  word,
                  style: TextStyle(
                    fontSize: 48,
                    color: wordColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Error type badge
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: wordColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      errorLabel,
                      style: TextStyle(
                        color: wordColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
// Phoneme Breakdown & Exact Score
                if (wordData['accuracyScore'] != null) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      l10n != null
                          ? l10n.score(
                              (wordData['accuracyScore'] as num).toInt(), 100)
                          : "Score: ${(wordData['accuracyScore'] as num).toInt()}/100",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _inkOf(isDark),
                      ),
                    ),
                  ),
                ],
if (wordData['phonemes'] != null &&
                    (wordData['phonemes'] as List).isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app_outlined,
                          size: 14, color: _accentOf(isDark)),
                      const SizedBox(width: 4),
                      Text(
                        l10n?.tapAnySyllableToAuditionAll4Tones ??
                            "Tap any syllable to audition all 4 tones:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _accentOf(isDark),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: (wordData['phonemes'] as List)
                          .asMap()
                          .entries
                          .map<Widget>((entry) {
                        final idx = entry.key;
                        final p = entry.value;
                        final acc = (p['accuracy'] as num).toInt();
                        final color = acc >= 80
                            ? _successOf
                            : (acc >= 60
                                ? _accentOf(isDark)
                                : _alertOf(isDark));
                        final phonemeStr =
                            (p['phoneme'] ?? '').toString().trim();

                        int tone = 1;
                        String pinyinBase = phonemeStr;
                        final match = RegExp(
                                r'^([a-zA-ZüÜāēīōūǖáéíóúǘǎěǐǒǔǚàèìòùǜ]+)\s*(\d)?$')
                            .firstMatch(phonemeStr);
                        if (match != null) {
                          pinyinBase = match.group(1) ?? phonemeStr;
                          if (match.group(2) != null) {
                            tone = int.tryParse(match.group(2)!) ??
                                PinyinUtils.getTone(pinyinBase);
                          } else {
                            tone = PinyinUtils.getTone(pinyinBase);
                          }
                        } else {
                          tone = PinyinUtils.getTone(phonemeStr);
                        }

                        final char = (word.length > idx) ? word[idx] : word;
                        final pinyinMarked = PinyinUtils.convertNumericToMarks(
                            '$pinyinBase$tone');

                        return InkWell(
                          onTap: () {
                            ToneComparisonSheet.show(
                              context,
                              character: char,
                              pinyin: pinyinMarked,
                              expectedTone: tone,
                              // Azure assesses phonemes, not tones: it never
                              // reports the tone that was heard. 0 means "not
                              // measured", so the sheet shows the target tone and
                              // the 4-tone audition instead of a verdict invented
                              // from the accuracy percentage (which used to mark a
                              // perfect tone wrong whenever the vowel slipped).
                              actualTone: 0,
                              feedback: feedback,
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: color.withValues(alpha: 0.6)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(p['phoneme']?.toString() ?? '',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: color)),
                                    const SizedBox(width: 4),
                                    Icon(Icons.volume_up_outlined,
                                        size: 12, color: color),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text("$acc%",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: color)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
if (feedback.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    feedback,
                    style: TextStyle(
                      fontSize: 16,
                      color: _mutedOf(isDark),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                // Listen button
                ElevatedButton.icon(
                  onPressed: () {
                    final audioService = ref.read(audioServiceProvider);
                    audioService.playSentence(
                      word,
                      voiceName: 'Kore',
                      speechRate: 0.40,
                      playbackRate: 1.0,
                    );
                  },
                  icon: const Icon(Icons.volume_up),
                  label: Text(AppLocalizations.of(context)!.listenToThisWord),
                  style: ElevatedButton.styleFrom(
                    // Same primary as every other sheet in the app.
                    backgroundColor: isDark
                        ? Colors.amber.shade700
                        : const Color(0xFF1A1A1B),
                    foregroundColor:
                        isDark ? const Color(0xFF1A1A1B) : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 12),
                // Compare 4 Tones button
                ElevatedButton.icon(
                  onPressed: () {
                    final phonemes = (wordData['phonemes'] as List?) ?? [];
                    if (phonemes.isNotEmpty) {
                      final firstPhoneme = phonemes.first;
                      final phonemeStr = (firstPhoneme[
                                  AppLocalizations.of(context)!.phoneme] ??
                              '')
                          .toString()
                          .trim();
                      int tone = 1;
                      String pinyinBase = phonemeStr;
                      final match = RegExp(
                              r'^([a-zA-ZüÜāēīōūǖáéíóúǘǎěǐǒǔǚàèìòùǜ]+)\s*(\d)?$')
                          .firstMatch(phonemeStr);
                      if (match != null) {
                        pinyinBase = match.group(1) ?? phonemeStr;
                        if (match.group(2) != null) {
                          tone = int.tryParse(match.group(2)!) ??
                              PinyinUtils.getTone(pinyinBase);
                        } else {
                          tone = PinyinUtils.getTone(pinyinBase);
                        }
                      } else {
                        tone = PinyinUtils.getTone(phonemeStr);
                      }
                      final char = word.isNotEmpty ? word[0] : word;
                      final pinyinMarked =
                          PinyinUtils.convertNumericToMarks('$pinyinBase$tone');
                      ToneComparisonSheet.show(
                        context,
                        character: char,
                        pinyin: pinyinMarked,
                        expectedTone: tone,
                        // The word's own measured tone (0 when the grader heard
                        // none), never a value derived from the accuracy score.
                        actualTone:
                            (wordData['actualTone'] as num?)?.toInt() ?? 0,
                        feedback: feedback,
                      );
                    } else {
                      final pinyinStr = (wordData['pinyin'] ?? '').toString();
                      final tone = PinyinUtils.getTone(pinyinStr);
                      ToneComparisonSheet.show(
                        context,
                        character: word.isNotEmpty ? word[0] : word,
                        pinyin: pinyinStr,
                        expectedTone: tone,
                        actualTone:
                            (wordData['actualTone'] as num?)?.toInt() ?? 0,
                        feedback: feedback,
                      );
                    }
                  },
                  icon: const Icon(Icons.tune),
                  label: Text(AppLocalizations.of(context)!.compare4Tones),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.05),
                    foregroundColor: _inkOf(isDark),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    side: BorderSide(
                        color: isDark ? Colors.white24 : Colors.black12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 12),
                // Study Character button
                ElevatedButton.icon(
                  onPressed: () {
                    final fakeCard = Flashcard(
                      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
                      hanzi: word,
                      pinyin: wordData['pinyin'] ?? '',
                      definition: '',
                      hskLevel: 1,
                      strokePaths: const [],
                      modeStats: const {},
                    );
                    Navigator.pop(context); // Close sheet
                    Navigator.push(
                        context,
                        SwipeBackPageRoute(
                            builder: (_) =>
                                CharacterDetailScreen(card: fakeCard)));
                  },
                  icon: const Icon(Icons.menu_book),
                  label: Text(AppLocalizations.of(context)!.studyCharacter),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: wordColor,
                    shadowColor: Colors.transparent,
                    side: BorderSide(color: wordColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_isSessionStarted) {
      return _buildHubUI(context, isDark);
    }

    return _buildSessionUI(context, isDark);
  }
}
