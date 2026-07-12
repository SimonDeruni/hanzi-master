import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/services/audio_service.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../core/services/pitch_detector_service.dart';
import '../../../../core/utils/dtw_aligner.dart';
import '../../../premium/presentation/screens/paywall_sheet.dart';

import 'package:hanzi_master/features/live_translate/presentation/widgets/tone_graph_painter.dart';
import 'package:hanzi_master/features/live_translate/presentation/widgets/interactive_grading_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/core/providers.dart';

enum ShadowingMode { freeFlow, theme, deck, customWord }

class ShadowingStudioScreen extends ConsumerStatefulWidget {
  final String? initialHanzi;
  final String? initialPinyin;
  final String? initialTranslation;
  final bool isCompact;
  const ShadowingStudioScreen({super.key, this.initialHanzi, this.initialPinyin, this.initialTranslation, this.isCompact = false});

  @override
  ConsumerState<ShadowingStudioScreen> createState() => _ShadowingStudioScreenState();
}

class _ShadowingStudioScreenState extends ConsumerState<ShadowingStudioScreen> with SingleTickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  bool _isSessionStarted = false;
  ShadowingMode _selectedMode = ShadowingMode.theme;
  String _selectedTheme = "HSK 1";
  String? _selectedDeckId;
  String _customWordInput = "";

  bool _isLoadingNextPhrase = false;
  int _sentenceCount = 0;
  Map<String, String>? _currentPhrase;
  bool _isRecording = false;
  bool _isGrading = false;
  bool _isStopping = false; // Prevents re-entry during stop→grade→reset cycle
  Map<String, dynamic>? _lastGrade;
  
  // Tone Graph State
  List<double?> _userPitch = [];
  List<double?> _idealPitch = [];
  double? _highlightStart;
  double? _highlightEnd;
  final _pitchService = PitchDetectorService();
  final List<Map<String, dynamic>> _weakCharacters = [];
  String? _errorMessage;
  String? _recordingPath;
  DateTime? _recordingStartTime;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.initialHanzi != null) {
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
    _audioRecorder.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _startSession() async {
    setState(() {
      _isSessionStarted = true;
      _errorMessage = null;
    });
    if (_currentPhrase == null) {
      await _fetchNextPhrase();
    }
  }

  Future<void> _fetchNextPhrase() async {
    setState(() {
      _isLoadingNextPhrase = true;
      _lastGrade = null;
      _userPitch = [];
      _idealPitch = [];
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
      if (_selectedMode == ShadowingMode.theme) contextInput = "Theme: $_selectedTheme";
      if (_selectedMode == ShadowingMode.deck) {
        final decks = ref.read(deckControllerProvider).valueOrNull ?? [];
        final deck = decks.firstWhere((d) => d.id == _selectedDeckId, orElse: () => decks.first);
        contextInput = "Flashcard Deck: ${deck.name}";
      }
      if (_selectedMode == ShadowingMode.customWord) contextInput = "Word: $_customWordInput";
      if (_selectedMode == ShadowingMode.freeFlow) contextInput = "Free flow conversational practice.";

      final phrase = await geminiService.generateShadowingPhrase(_selectedMode.toString(), contextInput);
      
      if (mounted) {
        setState(() {
          _currentPhrase = phrase;
          _isLoadingNextPhrase = false;
        });
      }
    } on PremiumRequiredException {
      if (mounted) {
        setState(() => _isLoadingNextPhrase = false);
        PaywallSheet.show(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Failed to generate phrase: $e";
          _isLoadingNextPhrase = false;
        });
      }
    }
  }

  Future<void> _playNativeAudio() async {
    if (_currentPhrase == null) return;
    HapticFeedback.lightImpact();
    final audioService = ref.read(audioServiceProvider);
    await audioService.playSentence(_currentPhrase!['hanzi']!);
  }

  Future<void> _startRecording() async {
    if (_isRecording || _isGrading || _isStopping) return; // Prevent double-tap / rapid restart / re-entry
    try {
      if (await _audioRecorder.hasPermission()) {
        HapticFeedback.heavyImpact();
        final tempDir = await getTemporaryDirectory();
        _recordingPath = '${tempDir.path}/shadow_recording_${DateTime.now().millisecondsSinceEpoch}.wav';
        _recordingStartTime = DateTime.now();

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 16000, numChannels: 1),
          path: _recordingPath!,
        );
        setState(() {
          _isRecording = true;
          _pulseController.repeat(reverse: true);
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Microphone permission denied. Enable it in Settings to use Shadowing Studio.")),
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
            _errorMessage = "Recorded audio is empty. Please try again and speak clearly.";
          });
        }
        return;
      }

      // 4. Grade
      try {
        final bytes = await file.readAsBytes();

        final pitchArray = await _pitchService.extractPitchContour(bytes);

        final geminiService = ref.read(geminiServiceProvider);
        final grade = await geminiService.gradeAudio(
          bytes,
          _currentPhrase!['hanzi']!,
          _currentPhrase!['pinyin']!,
        );
        List<double?> actualIdealPitch = [];
        try {
          final audioService = ref.read(audioServiceProvider);
          final audioBytes = await audioService.getSentenceAudioBytes(_currentPhrase!['hanzi'] ?? '');
          if (audioBytes != null) {
            actualIdealPitch = await _pitchService.extractPitchContour(audioBytes);
          }
        } catch (e) {
          debugPrint('Failed to extract ideal pitch: $e');
        }

        if (mounted) {
          setState(() {
            _lastGrade = grade;
            _userPitch = pitchArray;
            _idealPitch = actualIdealPitch;
            _isGrading = false;

            if (grade['words'] != null) {
              for (var word in grade['words']) {
                if (word['isCorrect'] == false) {
                  final existingIndex = _weakCharacters.indexWhere((w) => w['word'] == word['word']);
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
      } on PremiumRequiredException {
        if (mounted) {
          setState(() {
            _isGrading = false;
          });
          PaywallSheet.show(context);
        }
      } on Exception catch (e) {
        final msg = e.toString();
        debugPrint("Grading error: $msg");
        if (mounted) {
          setState(() {
            _isGrading = false;
            if (msg.contains("Azure Speech API keys are missing")) {
              _errorMessage = "Azure Speech keys not configured. Add AZURE_SPEECH_KEY and AZURE_SPEECH_REGION to .env";
            } else if (msg.contains("Azure Error 401")) {
              _errorMessage = "Azure authentication failed. Check your Speech API key and region in .env";
            } else if (msg.contains("Azure Error 429")) {
              _errorMessage = "Azure quota exceeded. Try again later.";
            } else if (msg.contains("TimeoutException") || msg.contains("timed out")) {
              _errorMessage = "Azure grading timed out. Check your internet connection.";
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
      // Perfect session or just aborting, go back to Hub UI
      setState(() {
        _isSessionStarted = false;
        _currentPhrase = null;
        _weakCharacters.clear();
        _sentenceCount = 0;
      });
      return;
    }

    final Set<String> selectedWords = _weakCharacters.map((w) => w['word'] as String).toSet();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                    "Session Summary",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Here are the characters you struggled with:",
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
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
                                if (val == true) selectedWords.add(word);
                                else selectedWords.remove(word);
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
                          subtitle: feedback.isNotEmpty ? Text(feedback, style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)) : null,
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
                            setState(() {
                              _isSessionStarted = false;
                              _currentPhrase = null;
                              _weakCharacters.clear();
                              _sentenceCount = 0;
                            });
                          },
                          child: const Text("Skip", style: TextStyle(color: Colors.grey, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: selectedWords.isEmpty ? null : () {
                            Navigator.pop(context); // close sheet
                            _showDeckSelectionDialog(context, isDark, selectedWords.toList());
                          },
                          child: const Text("Add Selected to Deck", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }
        );
      }
    );
  }

  void _showDeckSelectionDialog(BuildContext context, bool isDark, List<String> wordsToAdd) {
    bool applySrs = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final decksAsync = ref.watch(deckControllerProvider);

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Select a Deck", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(height: 16),
                  
                  SwitchListTile(
                    title: const Text("Apply session grades to Spaced Repetition (Speaking Mode)", style: TextStyle(fontSize: 14)),
                    activeColor: Colors.orange,
                    value: applySrs,
                    onChanged: (val) => setModalState(() => applySrs = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(),
                  
                  if (decksAsync.isLoading) const Center(child: CircularProgressIndicator(color: Colors.orange)),
                  if (decksAsync.hasValue && decksAsync.value!.isEmpty) const Text("No decks found."),
                  if (decksAsync.hasValue && decksAsync.value!.isNotEmpty)
                    ...decksAsync.value!.map((deck) => ListTile(
                      title: Text(deck.name, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                      subtitle: Text("Export to this deck", style: TextStyle(color: isDark ? Colors.white54 : Colors.black54)),
                      trailing: const Icon(Icons.add_circle_outline, color: Colors.orange),
                      onTap: () async {
                        Navigator.pop(context); // Close deck selector
                        setState(() {
                          _isSessionStarted = false;
                          _currentPhrase = null;
                          _weakCharacters.clear();
                          _sentenceCount = 0;
                        });
                        
                        await _saveWordsToDeck(context, deck, applySrs, wordsToAdd);
                      },
                    )),
                  const Divider(),
                  ListTile(
                    title: Text("Create New Deck", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    subtitle: Text("Make a custom collection", style: TextStyle(color: isDark ? Colors.white54 : Colors.black54)),
                    trailing: const Icon(Icons.add_circle, color: Colors.orange),
                    onTap: () {
                      _showCreateDeckDialog(context, isDark, wordsToAdd, applySrs);
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }
        );
      }
    );
  }

  void _showCreateDeckDialog(BuildContext context, bool isDark, List<String> wordsToAdd, bool applySrs) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
          title: Text("New Deck Name", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
          content: TextField(
            controller: controller,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: "E.g. Anime Vocab",
              hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () async {
                if (controller.text.trim().isEmpty) return;
                
                final deckName = controller.text.trim();
                final deckController = ref.read(deckControllerProvider.notifier);
                
                final newDeck = await deckController.createDeck(deckName);
                
                if (context.mounted && newDeck != null) {
                  Navigator.pop(context); // close create dialog
                  Navigator.pop(context); // close select deck bottom sheet
                  setState(() {
                    _isSessionStarted = false;
                    _currentPhrase = null;
                    _weakCharacters.clear();
                  });
                  
                  await _saveWordsToDeck(context, newDeck, applySrs, wordsToAdd);
                }
              },
              child: const Text("Create", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveWordsToDeck(BuildContext context, Deck deck, bool applySrs, List<String> wordsToAdd) async {
    final flashcardController = ref.read(flashcardControllerProvider.notifier);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saving ${wordsToAdd.length} words to ${deck.name}...")));
    
    for (String hanzi in wordsToAdd) {
      // Check if word exists in deck
      final existing = ref.read(flashcardControllerProvider).valueOrNull?.where((c) => c.hanzi == hanzi && c.deckId == deck.id).toList();
      
      Flashcard card;
      if (existing != null && existing.isNotEmpty) {
        card = existing.first;
      } else {
        // Get weak-character context from session grading (pinyin fallback)
        final wData = _weakCharacters.firstWhere((w) => w['word'] == hanzi, orElse: () => {});
        // Hydrate from the bundled dictionary for authoritative pinyin + definition
        final dictResult = await ref.read(globalDictionaryRepositoryProvider).getExact(hanzi);
        card = Flashcard(
          id: DateTime.now().millisecondsSinceEpoch.toString() + hanzi.hashCode.toString(),
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
        final wData = _weakCharacters.firstWhere((w) => w['word'] == hanzi, orElse: () => {});
        final isPartial = wData['isPartial'] ?? false;
        
        int sm2Grade = 0; // Again
        if (isPartial) {
          sm2Grade = 2; // Hard
        }
        
        final updatedCard = card.processReview(sm2Grade, StudyMode.speaking);
        await flashcardController.updateFlashcard(updatedCard);
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Words saved and SRS scheduled!")));
    }
  }

  Widget _buildHubUI(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              // Hero Section
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.orange.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.record_voice_over,
                          size: 80,
                          color: isDark ? Colors.orange.shade300 : Colors.orange.shade600,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Shadowing Studio",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Master your Mandarin pronunciation by mimicking native speech.",
                        style: TextStyle(
                          fontSize: 18,
                          color: isDark ? Colors.white70 : Colors.black54,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      // Mode Selection
                      const SizedBox(height: 24),
                      Text(
                        "PRACTICE MODE",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          ChoiceChip(
                            label: const Text("Free Flow"),
                            selected: _selectedMode == ShadowingMode.freeFlow,
                            onSelected: (val) => setState(() => _selectedMode = ShadowingMode.freeFlow),
                            selectedColor: Colors.orange.shade200,
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                          ),
                          ChoiceChip(
                            label: const Text("Thematic"),
                            selected: _selectedMode == ShadowingMode.theme,
                            onSelected: (val) => setState(() => _selectedMode = ShadowingMode.theme),
                            selectedColor: Colors.orange.shade200,
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                          ),
                          ChoiceChip(
                            label: const Text("Deck (Flashcards)"),
                            selected: _selectedMode == ShadowingMode.deck,
                            onSelected: (val) => setState(() => _selectedMode = ShadowingMode.deck),
                            selectedColor: Colors.orange.shade200,
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                          ),
                          ChoiceChip(
                            label: const Text("Custom Word"),
                            selected: _selectedMode == ShadowingMode.customWord,
                            onSelected: (val) => setState(() => _selectedMode = ShadowingMode.customWord),
                            selectedColor: Colors.orange.shade200,
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                          ),
                        ],
                      ),
                      if (_selectedMode == ShadowingMode.customWord) ...[
                        const SizedBox(height: 16),
                        Builder(
                          builder: (context) {
                            final asyncCards = ref.watch(flashcardControllerProvider);
                            final allCards = asyncCards.valueOrNull ?? [];
                            final options = allCards.map((c) => c.hanzi).toSet().toList();

                            return Autocomplete<String>(
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) return options.take(10);
                                return options.where((String option) => option.contains(textEditingValue.text));
                              },
                              onSelected: (String selection) => setState(() => _customWordInput = selection),
                              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                return TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: "Search library or type custom",
                                    filled: true,
                                    fillColor: isDark ? Colors.grey[900] : Colors.white,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                  ),
                                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                                  onChanged: (val) => setState(() => _customWordInput = val),
                                );
                              },
                              optionsViewBuilder: (context, onSelected, optionsView) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.transparent,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width - 64,
                                      constraints: const BoxConstraints(maxHeight: 250),
                                      decoration: BoxDecoration(
                                        color: isDark ? Colors.grey[850] : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
                                      ),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: optionsView.length,
                                        itemBuilder: (context, index) {
                                          final option = optionsView.elementAt(index);
                                          final cardList = allCards.where((c) => c.hanzi == option);
                                          final card = cardList.isNotEmpty ? cardList.first : null;
                                          return ListTile(
                                            title: Text(option, style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                                            subtitle: card != null ? Text("${card.pinyin} - ${card.definition}", style: TextStyle(color: isDark ? Colors.white70 : Colors.black54), maxLines: 1, overflow: TextOverflow.ellipsis) : null,
                                            onTap: () => onSelected(option),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        ),
                      ],
                      if (_selectedMode == ShadowingMode.theme) ...[
                        const SizedBox(height: 16),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedTheme,
                            dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                            items: ["HSK 1", "HSK 2", "HSK 3", "HSK 4", "HSK 5", "HSK 6", "Native"].map((theme) => DropdownMenuItem(value: theme, child: Text(theme))).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedTheme = val);
                            },
                          ),
                        ),
                      ],
                      if (_selectedMode == ShadowingMode.deck) ...[
                        const SizedBox(height: 16),
                        ref.watch(deckControllerProvider).when(
                          data: (decks) {
                            if (decks.isEmpty) return const Text("No decks found.");
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedDeckId ?? decks.first.id,
                                dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                                items: decks.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
                                onChanged: (val) {
                                  if (val != null) setState(() => _selectedDeckId = val);
                                },
                              ),
                            );
                          },
                          loading: () => const CircularProgressIndicator(strokeWidth: 2),
                          error: (e, st) => const Text("Error loading decks"),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
              // Start Button Area
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      (isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFDF5E6)).withValues(alpha: 0.0),
                      isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFDF5E6),
                    ],
                  ),
                ),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _startSession,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mic, size: 28, color: Colors.white),
                        SizedBox(width: 12),
                        Text(
                          "START SESSION",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: Colors.white,
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
      ),
    );
  }

  Widget _buildSessionUI(BuildContext context, bool isDark) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _showSessionSummaryDialog(context, isDark);
      },
      child: Scaffold(
        backgroundColor: widget.isCompact ? Colors.transparent : (isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)),
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
                      icon: Icon(Icons.keyboard_arrow_down, size: 32, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      onPressed: () => _showSessionSummaryDialog(context, isDark),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shadowing Studio",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                          ),
                          Text(
                            "Endless AI Stream • Sentence $_sentenceCount",
                            style: TextStyle(fontSize: 14, color: Colors.orange, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                                      ],
                ),
              ),
            
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              ),

            // Main Content Area
            Expanded(
              child: _isLoadingNextPhrase 
                ? const Center(child: CircularProgressIndicator(color: Colors.orange))
                : _currentPhrase == null 
                  ? const Center(child: Text("Ready to start."))
                  : _buildPhraseCard(isDark),
            ),

            // Bottom Actions Area
            if (_currentPhrase != null && !_isLoadingNextPhrase)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Grading State
                    if (_isGrading)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange)),
                          SizedBox(width: 12),
                          Text("AI is grading your pronunciation...", style: TextStyle(color: Colors.orange, fontSize: 16)),
                        ],
                      ),
                      
                    const SizedBox(height: 24),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Play Button
                        IconButton(
                          iconSize: widget.isCompact ? 36 : 48,
                          color: isDark ? Colors.white70 : Colors.black54,
                          icon: const Icon(Icons.play_circle_fill),
                          onPressed: _playNativeAudio,
                        ),
                        
                        // Record Button (Hold)
                        GestureDetector(
                          onLongPressStart: (_) => _startRecording(),
                          onLongPressEnd: (_) => _stopRecordingAndGrade(),
                          child: AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: widget.isCompact ? 64 : 80,
                                  height: widget.isCompact ? 64 : 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _isRecording ? Colors.red : (isDark ? Colors.orange.shade800 : Colors.orange),
                                    boxShadow: [
                                      if (_isRecording)
                                        BoxShadow(color: Colors.red.withValues(alpha: 0.5), blurRadius: 20, spreadRadius: 5)
                                      else
                                        BoxShadow(color: Colors.orange.withValues(alpha: 0.3), blurRadius: 10, spreadRadius: 2),
                                    ],
                                  ),
                                  child: Icon(Icons.mic, size: widget.isCompact ? 28 : 36, color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),

                        // Next Button
                        if (!widget.isCompact)
                          IconButton(
                            iconSize: 48,
                            color: isDark ? Colors.white70 : Colors.black54,
                            icon: const Icon(Icons.skip_next),
                            onPressed: _fetchNextPhrase,
                          ),
                      ],
                    ),
                    SizedBox(height: widget.isCompact ? 8 : 16),
                    Text(
                      "Hold mic to record. Release to grade.",
                      style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: widget.isCompact ? 12 : 14),
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

  Widget _buildPhraseCard(bool isDark) {
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
                  color: _lastGrade!['score'] >= 80 ? Colors.green : Colors.orange,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Score: ${_lastGrade!['score']}/100",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _lastGrade!['score'] >= 80 ? Colors.green : Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _lastGrade!['overallFeedback'] ?? "",
                    style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87),
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
                fontSize: widget.isCompact ? 20 : 28,
                color: isDark ? Colors.white70 : Colors.black87,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              _currentPhrase!['hanzi']!,
              style: TextStyle(
                fontSize: widget.isCompact ? 40 : 56,
                color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                fontWeight: FontWeight.w500,
                fontFamily: 'NotoSerifSC',
              ),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            // Breakdown view
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 4,
              children: (_lastGrade!['words'] as List).map<Widget>((item) {
                final isCorrect = item['isCorrect'] ?? true;
                final isPartial = item['isPartial'] ?? false;
                final color = isCorrect 
                    ? (isDark ? Colors.white : const Color(0xFF1A1A1B)) 
                    : (isPartial ? Colors.orange : Colors.red);
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['pinyin'] ?? "",
                      style: TextStyle(fontSize: 16, color: color, fontStyle: FontStyle.italic),
                    ),
                    Text(
                      item['word'] ?? "",
                      style: TextStyle(
                        fontSize: widget.isCompact ? 40 : 56,
                        color: color,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'NotoSerifSC',
                      ),
                    ),
                  ],
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
                    child: Text("Tone Graph", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  )
                ],
              ),
            ),
          ],
          */
          
          const SizedBox(height: 24),
          Text(
            _currentPhrase!['english']!,
            style: TextStyle(
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (!_isSessionStarted) {
      return _buildHubUI(context, isDark);
    }

    return _buildSessionUI(context, isDark);
  }
}
