import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';

import '../../../../core/services/ocr_service.dart';
import '../../../flashcards/domain/entities/flashcard.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../course/presentation/screens/lesson_screen.dart';
import '../../../course/presentation/providers/lesson_controller.dart';
import '../../../course/presentation/widgets/mission_briefing_sheet.dart';

class UniversalScannerScreen extends ConsumerStatefulWidget {
  final bool returnTextMode;
  
  const UniversalScannerScreen({super.key, this.returnTextMode = false});

  @override
  ConsumerState<UniversalScannerScreen> createState() => _UniversalScannerScreenState();
}

class _UniversalScannerScreenState extends ConsumerState<UniversalScannerScreen> {
  final OcrService _ocrService = OcrService();
  bool _isScanning = false;
  String _rawExtractedText = "";
  List<Map<String, dynamic>> _matchedCharacters = [];
  Map<String, dynamic> _hskData = {};

  @override
  void initState() {
    super.initState();
    if (!widget.returnTextMode) {
      _loadHskData();
    }
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  Future<void> _loadHskData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/hsk1.json');
      final List<dynamic> data = json.decode(jsonString);
      final Map<String, dynamic> map = {};
      for (var item in data) {
        map[item['hanzi']] = item;
      }
      setState(() {
        _hskData = map;
      });
    } catch (e) {
      debugPrint("Error loading HSK data for OCR: $e");
    }
  }

  Future<void> _startScan(bool fromCamera) async {
    setState(() {
      _isScanning = true;
      _rawExtractedText = "";
      _matchedCharacters = [];
    });

    final extractedText = await _ocrService.scanImage(fromCamera: fromCamera);

    if (extractedText != null && extractedText.isNotEmpty) {
      if (widget.returnTextMode) {
        if (mounted) {
          HapticsManager.success();
          Navigator.pop(context, extractedText);
        }
      } else {
        _processExtractedText(extractedText);
      }
    } else {
      setState(() {
        _isScanning = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No Chinese characters found in the image.")),
        );
      }
    }
  }

  void _processExtractedText(String text) {
    HapticsManager.success();
    List<Map<String, dynamic>> matched = [];

    // Right now, we only cross-reference with our HSK1 DB to build a known deck.
    // In the future (Phase 9), we can use hanzi_metadata to generate completely new cards.
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (_hskData.containsKey(char)) {
        matched.add(_hskData[char]);
      }
    }

    setState(() {
      _rawExtractedText = text;
      _matchedCharacters = matched;
      _isScanning = false;
    });
  }

  Future<void> _createDeck() async {
    if (_matchedCharacters.isEmpty) return;

    HapticsManager.light();
    
    // Simulate creating a custom deck. For now, it just adds them if they don't exist.
    // Real implementation would group them into a "Deck" entity.
    final controller = ref.read(flashcardControllerProvider.notifier);
    
    int addedCount = 0;
    final currentCards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
    
    for (var charData in _matchedCharacters) {
      final exists = currentCards.any((c) => c.hanzi == charData['hanzi']);
      if (!exists) {
        final newCard = Flashcard(
          id: DateTime.now().millisecondsSinceEpoch.toString() + addedCount.toString(),
          hanzi: charData['hanzi'],
          pinyin: charData['pinyin'],
          definition: charData['definition'],
          hskLevel: 1,
          strokePaths: const [],
          modeStats: const {},
        );
        await controller.addFlashcard(newCard);
        addedCount++;
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Added new characters to your library!")),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _startLesson(Map<String, dynamic> charData) async {
    HapticsManager.light();
    
    // 1. Create temporary flashcard
    final card = Flashcard(
      id: 'ocr_${charData['hanzi']}',
      hanzi: charData['hanzi'],
      pinyin: charData['pinyin'],
      definition: charData['definition'],
      hskLevel: 1,
      strokePaths: const [],
      modeStats: const {},
    );

    // 2. Hydrate strokes
    final controller = ref.read(flashcardControllerProvider.notifier);
    final hydratedCard = await controller.loadStrokesFor(card);

    if (mounted) {
      // 3. Populate session providers for the lesson controller
      final allCards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
      ref.read(allCardsProvider.notifier).state = allCards;
      ref.read(activeWarmupCardsProvider.notifier).state = [hydratedCard ?? card];

      // 4. Launch Briefing (Pedagogical "Zen" approach)
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => MissionBriefingSheet(
          targetCard: hydratedCard ?? card,
          warmupCards: [hydratedCard ?? card],
          radicalHanzi: "", // We don't have the radical context here easily
          onStart: () async {
            Navigator.pop(context);
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LessonScreen(card: hydratedCard ?? card)),
            );
          },
        ),
      );
    }
  }

  Future<void> _practiceAll() async {
    if (_matchedCharacters.isEmpty) return;
    HapticsManager.selection();
    
    // For now, let's just start a sequence for the first character
    // A robust "Practice All" would need a session manager.
    // We start with the first one as a MVP of the "Flow".
    _startLesson(_matchedCharacters.first);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Universal Scanner"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CalligraphyBackground(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildScanButton(
                  icon: Icons.camera_alt,
                  label: "Take Photo",
                  onTap: () => _startScan(true),
                  theme: theme,
                ),
                _buildScanButton(
                  icon: Icons.image,
                  label: "Gallery",
                  onTap: () => _startScan(false),
                  theme: theme,
                ),
              ],
            ),
            
            const SizedBox(height: 30),

            // Results Area
            Expanded(
              child: _isScanning
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: theme.colorScheme.primary),
                          const SizedBox(height: 16),
                          Text("Extracting text and objects...", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary)),
                        ],
                      ),
                    )
                  : _matchedCharacters.isEmpty && _rawExtractedText.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.document_scanner_outlined, size: 64, color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
                                const SizedBox(height: 16),
                                Text(
                                  "Scan a textbook, sign, or object to extract Chinese characters.",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                                ),
                              ],
                            ),
                          ),
                        )
                      : _buildResultsList(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanButton({required IconData icon, required String label, required VoidCallback onTap, required ThemeData theme}) {
    return InkWell(
      onTap: _isScanning ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Text(label, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(ThemeData theme) {
    if (widget.returnTextMode) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Extracted Text", style: theme.textTheme.headlineMedium),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  boxShadow: [
                    BoxShadow(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _rawExtractedText,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                HapticsManager.success();
                Navigator.pop(context, _rawExtractedText);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: Icon(Icons.check_circle_outline, color: theme.colorScheme.onPrimary),
              label: Text("Use Text", style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    }

    if (_matchedCharacters.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off_rounded, size: 64, color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
              const SizedBox(height: 16),
              Text(
                "No matching dictionary entries found.",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Found ${_matchedCharacters.length} Characters",
                style: theme.textTheme.titleLarge,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _createDeck,
                    style: IconButton.styleFrom(backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1)),
                    icon: Icon(Icons.library_add, color: theme.colorScheme.primary),
                    tooltip: "Import All",
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _practiceAll,
                    style: IconButton.styleFrom(backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.1)),
                    icon: Icon(Icons.auto_awesome, color: theme.colorScheme.secondary),
                    tooltip: "Ascend All",
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _matchedCharacters.length,
            itemBuilder: (context, index) {
              final char = _matchedCharacters[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  boxShadow: [
                    BoxShadow(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    Text(char['hanzi'], style: theme.textTheme.displaySmall?.copyWith(fontSize: 40)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PinyinText(text: char['pinyin'], style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                          const SizedBox(height: 4),
                          Text(char['definition'], style: theme.textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.play_arrow_rounded, color: theme.colorScheme.secondary),
                        onPressed: () => _startLesson(char),
                        tooltip: "Start Ascension",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
