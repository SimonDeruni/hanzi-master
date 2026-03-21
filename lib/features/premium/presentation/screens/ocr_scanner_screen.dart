import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';

import '../../../../core/services/ocr_service.dart';
import '../../../flashcards/domain/entities/flashcard.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../course/presentation/screens/lesson_screen.dart';
import '../../../course/presentation/providers/lesson_controller.dart';
import '../../../course/presentation/widgets/mission_briefing_sheet.dart';

class OcrScannerScreen extends ConsumerStatefulWidget {
  const OcrScannerScreen({super.key});

  @override
  ConsumerState<OcrScannerScreen> createState() => _OcrScannerScreenState();
}

class _OcrScannerScreenState extends ConsumerState<OcrScannerScreen> {
  final OcrService _ocrService = OcrService();
  bool _isScanning = false;
  String _rawExtractedText = "";
  List<Map<String, dynamic>> _matchedCharacters = [];
  Map<String, dynamic> _hskData = {};

  @override
  void initState() {
    super.initState();
    _loadHskData();
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
      _processExtractedText(extractedText);
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
          nextReviewDate: DateTime.now(),
          interval: 0,
          easeFactor: 2.5,
          streak: 0,
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
      nextReviewDate: DateTime.now(),
      interval: 0,
      easeFactor: 2.5,
      streak: 0,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snapshot-to-Practice"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFDF5E6),
      body: Column(
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
              ),
              _buildScanButton(
                icon: Icons.image,
                label: "Gallery",
                onTap: () => _startScan(false),
              ),
            ],
          ),
          
          const SizedBox(height: 30),

          // Results Area
          Expanded(
            child: _isScanning
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.indigo),
                        SizedBox(height: 16),
                        Text("Extracting Chinese script...", style: TextStyle(color: Colors.indigo)),
                      ],
                    ),
                  )
                : _matchedCharacters.isEmpty
                    ? Center(
                        child: Text(
                          _rawExtractedText.isEmpty
                              ? "Scan a textbook page or list to extract characters."
                              : "Found characters, but none match your current dictionary level.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : _buildResultsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: _isScanning ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.indigo),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Found ${_matchedCharacters.length} Characters",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _createDeck,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                icon: const Icon(Icons.add_task, color: Colors.white, size: 18),
                label: const Text("Import All", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _practiceAll,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade800),
                icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                label: const Text("Ascend All", style: TextStyle(color: Colors.white)),
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
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.brown.shade100),
                ),
                child: Row(
                  children: [
                    Text(char['hanzi'], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PinyinText(text: char['pinyin'], style: const TextStyle(fontSize: 16)),
                          Text(char['definition'], style: const TextStyle(color: Colors.black54), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.auto_awesome, color: Colors.amber),
                      onPressed: () => _startLesson(char),
                      tooltip: "Start Ascension",
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
