import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/services/audio_service.dart';
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
import '../../../echo_hall/presentation/widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

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

  bool _isLoadingNextPhrase = false;
  bool _isStartingSession = false;
  int _sentenceCount = 0;
  Map<String, String>? _currentPhrase;
  bool _isRecording = false;
  bool _isGrading = false;
  bool _isStopping = false; // Prevents re-entry during stop→grade→reset cycle
  Map<String, dynamic>? _lastGrade;

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
      _selectedMode = ShadowingMode.customSentence;
      _customWordInput = widget.initialContextSentence!;
      _isSessionStarted = true;
      if (widget.initialPinyin != null || widget.initialTranslation != null) {
        _currentPhrase = {
          "hanzi": widget.initialContextSentence!,
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
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
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

  Future<void> _fetchNextPhrase() async {
    setState(() {
      _isLoadingNextPhrase = true;
      _lastGrade = null;
      _errorMessage = null;
      _sentenceCount++;
      // Cleanse any stuck recording/grading states when transitioning
      _isRecording = false;
      _isGrading = false;
      _isStopping = false;
    });

    try {
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
    HapticFeedback.lightImpact();
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
        HapticFeedback.heavyImpact();
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
          _pulseController.repeat(reverse: true);
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)?.microphonePermissionDeniedEnableItI ??
                    "Microphone permission denied. Enable it in Settings to use Shadowing Studio.")),
          );
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
    HapticFeedback.lightImpact();

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

        final geminiService = ref.read(geminiServiceProvider);
        final grade = await geminiService.gradeAudio(
          bytes,
          _currentPhrase!['hanzi']!,
          _currentPhrase!['pinyin']!,
        );

        if (mounted) {
          setState(() {
            _lastGrade = grade;
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
              _errorMessage = "Azure quota exceeded. Try again later.";
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

    showModalBottomSheet(
        context: context,
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
                    AppLocalizations.of(context)?.sessionSummary ?? "Session Summary",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)?.hereAreTheCharactersYouStruggledWit ??
                        "Here are the characters you struggled with:",
                    style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5),
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
                            activeColor: Colors.orange,
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
                              fontFamily: 'NotoSerifSC',
                              color: isPartial ? Colors.orange : Colors.red,
                            ),
                          ),
                          subtitle: feedback.isNotEmpty
                              ? Text(feedback,
                                  style: TextStyle(
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black87))
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
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
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

    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor:
            isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        builder: (context) {
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
                    activeThumbColor: Colors.orange,
                    value: applySrs,
                    onChanged: (val) => setModalState(() => applySrs = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(),
                  if (decksAsync.isLoading)
                    const Center(
                        child: CircularProgressIndicator(color: Colors.orange)),
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
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.black54)),
                          trailing: const Icon(Icons.add_circle_outline,
                              color: Colors.orange),
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
                        style: const TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        AppLocalizations.of(context)!.makeACustomCollection,
                        style: TextStyle(
                            color: isDark ? Colors.white54 : Colors.black54)),
                    trailing:
                        const Icon(Icons.add_circle, color: Colors.orange),
                    onTap: () {
                      _showCreateDeckDialog(
                          context, isDark, wordsToAdd, applySrs);
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
          backgroundColor:
              isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
          title: Text(AppLocalizations.of(context)!.newDeckName,
              style: TextStyle(color: isDark ? Colors.white : Colors.black)),
          content: HanziTextField(
            controller: controller,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.egAnimeVocab,
              hintStyle:
                  TextStyle(color: isDark ? Colors.white54 : Colors.black54),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelAction,
                  style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
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
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveWordsToDeck(BuildContext context, Deck deck, bool applySrs,
      List<String> wordsToAdd) async {
    final flashcardController = ref.read(flashcardControllerProvider.notifier);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!
            .saving_words_to(wordsToAdd.length, deck.name))));

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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(AppLocalizations.of(context)!.wordsSavedAndSrsScheduled)));
  }

  // Accent color matching the rest of the app (Explore / Roleplay / Echo Hall)
  static const Color _accentGold = Color(0xFFFFB300);
  static const Color _accentGoldLight = Color(0xFFFFD54F);

  Widget _buildSectionLabel({
    required IconData icon,
    required String title,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: _accentGold),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              letterSpacing: 0.3,
            ),
          ),
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
    return GestureDetector(
      onTap: () {
        if (_selectedMode != mode) {
          setState(() => _selectedMode = mode);
          HapticFeedback.selectionClick();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutQuart,
        decoration: BoxDecoration(
          color: isSelected
              ? _accentGold.withValues(alpha: isDark ? 0.25 : 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: _accentGold.withValues(alpha: 0.4), width: 1)
              : null,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 14,
                color: isSelected
                    ? _accentGold
                    : (isDark ? Colors.white54 : Colors.black38)),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? (isDark ? _accentGoldLight : const Color(0xFF1A1A1B))
                      : (isDark ? Colors.white54 : Colors.black38),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 11,
                  letterSpacing: 0.2,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigCard({
    required bool isDark,
    required String label,
    required Widget child,
  }) {
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white38 : Colors.black45,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildHubUI(BuildContext context, bool isDark) {
    final bgColor = Theme.of(context).colorScheme.surface;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header Bar ────────────────────────────────────────
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                children: [
                  if (widget.showBackButton)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      color: primaryText,
                      onPressed: () => Navigator.pop(context),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: Text(
                      l10n.shadowingStudio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // ── Hero Icon ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _accentGold.withValues(alpha: isDark ? 0.1 : 0.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.graphic_eq_rounded,
                  size: 38,
                  color: isDark ? _accentGoldLight : _accentGold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ── Subtitle ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                l10n.masterYourMandarinPronunciationnbyM,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white60 : Colors.black54,
                  height: 1.35,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // ── Content ───────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: _selectedMode == ShadowingMode.customWord &&
                        _dictionaryResults.isNotEmpty
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
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
                    ),
                    const SizedBox(height: 6),

                    // Primary modes: responsive segmented pill grid
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF2C2C2E)
                            : Colors.black.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 3.5,
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
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Configuration Section ─────────────────────
                    _buildSectionLabel(
                      icon: Icons.settings_rounded,
                      title: AppLocalizations.of(context)!.configuration,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 6),

                    if (_selectedMode == ShadowingMode.freeFlow) ...[
                      _buildConfigCard(
                        isDark: isDark,
                        label: l10n.practiceMode,
                        child: Text(
                          l10n.freeFlowConversationalPractice,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF1A1A1B),
                            fontSize: 13,
                            height: 1.3,
                          ),
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
                            HanziTextField(
                              controller: _customWordController,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .searchDictionaryOrTypeCustom,
                                filled: true,
                                fillColor: isDark
                                    ? const Color(0xFF2C2C2E)
                                    : const Color(0xFFF5F5F5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black),
                              onChanged: (val) {
                                setState(() => _customWordInput = val);
                                _onSearchChanged(val);
                              },
                            ),
                            if (_dictionaryResults.isNotEmpty)
                              Container(
                                width: double.infinity,
                                constraints:
                                    const BoxConstraints(maxHeight: 250),
                                margin: const EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                  color:
                                      isDark ? Colors.grey[850] : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: isDark
                                          ? Colors.white12
                                          : Colors.black12),
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
                                return DropdownButtonHideUnderline(
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
                                );
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

                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),

            // Start Button Area
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
              child: FilledButton.icon(
                key: const Key('shadowing_start_session'),
                onPressed: _isStartingSession ? null : _startSession,
                icon: _isStartingSession
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.mic, size: 22),
                label: Text(
                  _isStartingSession ? l10n.sTARTING : l10n.startSession,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: _accentGold,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
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
      fontFamily: 'NotoSerifSC',
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

    final highlightColor =
        isDark ? const Color(0xFF818CF8) : const Color(0xFF4F46E5);
    final highlightBg =
        highlightColor.withValues(alpha: isDark ? 0.28 : 0.16);

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
          HapticFeedback.selectionClick();
          setState(() {
            _playbackSpeed = isSlow ? 1.0 : 0.8;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSlow
                ? (isDark
                    ? const Color(0xFFD97706).withValues(alpha: 0.25)
                    : const Color(0xFFFEF3C7))
                : (isDark
                    ? Colors.white10
                    : Colors.black.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSlow
                  ? (isDark
                      ? const Color(0xFFF59E0B)
                      : const Color(0xFFD4AF37))
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
                color: isSlow
                    ? (isDark
                        ? const Color(0xFFFBBF24)
                        : const Color(0xFFB45309))
                    : (isDark ? Colors.white70 : Colors.black54),
              ),
              const SizedBox(width: 4),
              Text(
                '${_playbackSpeed.toStringAsFixed(1)}x',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSlow
                      ? (isDark
                          ? const Color(0xFFFBBF24)
                          : const Color(0xFFB45309))
                      : (isDark ? Colors.white70 : Colors.black54),
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
        backgroundColor: widget.isCompact
            ? Colors.transparent
            : Theme.of(context).colorScheme.surface,
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
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      size: 32,
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF1A1A1B)),
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
                                        l10n?.shadowingStudio ?? "Shadowing Studio",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? Colors.white
                                                : const Color(0xFF1A1A1B)),
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
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.orange,
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

                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(_errorMessage!,
                                    style: const TextStyle(color: Colors.red),
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
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.orange))
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
                                      const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.orange)),
                                      const SizedBox(width: 12),
                                      Text(
                                        l10n?.aiIsGradingYourPronunciation ??
                                            "AI is grading your pronunciation...",
                                        style: const TextStyle(
                                            color: Colors.orange,
                                            fontSize: 16),
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
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                      icon: const Icon(Icons.play_circle_fill),
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
                                                      ? Colors.red
                                                      : (isDark
                                                          ? Colors
                                                              .orange.shade800
                                                          : Colors.orange),
                                                  boxShadow: [
                                                    if (_isRecording)
                                                      BoxShadow(
                                                          color: Colors.red
                                                              .withValues(
                                                                  alpha: 0.5),
                                                          blurRadius: 20,
                                                          spreadRadius: 5)
                                                    else
                                                      BoxShadow(
                                                          color: Colors.orange
                                                              .withValues(
                                                                  alpha: 0.3),
                                                          blurRadius: 10,
                                                          spreadRadius: 2),
                                                  ],
                                                ),
                                                child: Icon(Icons.mic,
                                                    size: widget.isCompact
                                                        ? 28
                                                        : 36,
                                                    color: Colors.white),
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
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black54,
                                        icon: Icon((_selectedMode ==
                                                    ShadowingMode.customWord ||
                                                _selectedMode ==
                                                    ShadowingMode
                                                        .customSentence)
                                            ? Icons.check_circle_outline
                                            : Icons.skip_next),
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
                                  style: TextStyle(
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.black54,
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

  String _getLocalizedOverallFeedback(String? feedback, AppLocalizations? l10n) {
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
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color:
                      _lastGrade!['score'] >= 80 ? Colors.green : Colors.orange,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    l10n != null
                        ? l10n.score(_lastGrade!['score'], 100)
                        : "Score: ${_lastGrade!['score']}/100",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _lastGrade!['score'] >= 80
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getLocalizedOverallFeedback(
                        _lastGrade!['overallFeedback'], l10n),
                    style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.black87),
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
                color: isDark ? Colors.white70 : Colors.black87,
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

                Color color;
                if (isOmitted) {
                  color = Colors.grey;
                } else if (isCorrect) {
                  color = Colors.green;
                } else if (isPartial) {
                  color = Colors.orange;
                } else {
                  color = Colors.red;
                }

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
                          fontFamily: 'NotoSerifSC',
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],

          // Tone Graph is hidden for V1 MVP as requested by user
          /*
          if (_lastGrade != null && _userPitch.isNotEmpty) ...[
            const SizedBox(height: 24),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(double.infinity, 120),
                    painter: ToneGraphPainter(
                      idealPitch: _idealPitch,
                      userPitch: _userPitch,
                      isLive: false,
                      highlightStart: _highlightStart,
                      highlightEnd: _highlightEnd,
                    ),
                  ),
                  const Positioned(
                    top: 8, left: 16,
                    child: Text(AppLocalizations.of(context)!.toneGraph, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  )
                ],
              ),
            ),
          ],
          */

          const SizedBox(height: 24),
          TranslatedDefinition(
            definition: _currentPhrase!['english']!,
            hanzi: _currentPhrase!['hanzi'],
            definitionLanguage: 'English',
            originalStyle: TextStyle(
              fontSize: widget.isCompact ? 16 : 20,
              color: isDark ? Colors.white54 : Colors.black54,
              fontStyle: FontStyle.italic,
              fontFamily: 'serif',
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

    showModalBottomSheet(
      context: context,
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
                      color: Colors.grey[400],
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
                    fontFamily: 'NotoSerifSC',
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
                          ? l10n.score((wordData['accuracyScore'] as num).toInt(), 100)
                          : "Score: ${(wordData['accuracyScore'] as num).toInt()}/100",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
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
                          size: 14,
                          color: isDark
                              ? Colors.orange.shade300
                              : Colors.orange.shade800),
                      const SizedBox(width: 4),
                      Text(
                        l10n?.tapAnySyllableToAuditionAll4Tones ??
                            "Tap any syllable to audition all 4 tones:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.orange.shade300
                              : Colors.orange.shade800,
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
                            ? Colors.green
                            : (acc >= 60 ? Colors.orange : Colors.red);
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
                              actualTone: acc >= 80 ? tone : (tone % 4 + 1),
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
                      color: isDark ? Colors.white70 : Colors.black87,
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
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
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
                      final acc =
                          (firstPhoneme['accuracy'] as num?)?.toInt() ?? 100;
                      ToneComparisonSheet.show(
                        context,
                        character: char,
                        pinyin: pinyinMarked,
                        expectedTone: tone,
                        actualTone: acc >= 80 ? tone : (tone % 4 + 1),
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
                        actualTone: tone,
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
                    foregroundColor: isDark ? Colors.white : Colors.black87,
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
