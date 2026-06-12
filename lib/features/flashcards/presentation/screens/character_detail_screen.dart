import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/mastery_seal.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/review_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:hanzi_master/features/flashcards/presentation/widgets/cross_reference_text.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/character_chat_drawer.dart';

class CharacterDetailScreen extends ConsumerStatefulWidget {
  final Flashcard card;
  const CharacterDetailScreen({super.key, required this.card});

  @override
  ConsumerState<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends ConsumerState<CharacterDetailScreen> {
  final List<Map<String, dynamic>> _anatomyComponents = [];
  Map<String, dynamic>? _fullHanziMeta;
  late PageController _pageController;
  int _activeAnatomyIndex = 0;
  
  // Scrubbing State
  int? _manualStrokeLimit;
  bool _isPlaying = true;

  // Lazy Load State
  Flashcard? _hydratedCard;
  bool _isLoadingStrokes = true;

  // Personal Notes
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadAnatomyData();
    _hydrateStrokes();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notesController.text = prefs.getString('notes_${widget.card.hanzi}') ?? '';
    });
  }

  Future<void> _saveNotes(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notes_${widget.card.hanzi}', value);
  }

  @override
  void dispose() {
    _notesController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _hydrateStrokes() async {
    final updatedCard = await ref.read(flashcardControllerProvider.notifier).loadStrokesFor(widget.card);
    if (mounted) {
      setState(() {
        _hydratedCard = updatedCard;
        _isLoadingStrokes = false;
      });
    }
  }

  Future<void> _loadAnatomyData() async {
    try {
      final metadataString = await rootBundle.loadString('assets/data/hanzi_metadata.json');
      final hanziMeta = json.decode(metadataString);
      final radicalString = await rootBundle.loadString('assets/data/radicals.json');
      final radicalData = json.decode(radicalString)['radicals'];
      
      if (mounted) setState(() => _fullHanziMeta = hanziMeta);

      // --- HSK 2 BUNDLE HOOK ---
      Map<String, dynamic> hsk2Meta = {};
      try {
        final hsk2String = await rootBundle.loadString('assets/data/hsk2_bundle.json');
        hsk2Meta = json.decode(hsk2String)['metadata'] ?? {};
      } catch (e) { /* ignore */ }
      // -------------------------

      final chars = widget.card.hanzi.split('');
      final List<Map<String, dynamic>> foundComponents = [];

      for (var char in chars) {
        var meta = hanziMeta[char];
        
        // Fallback to HSK 2 Bundle if not in standard metadata
        if (meta == null && hsk2Meta.containsKey(char)) {
          meta = hsk2Meta[char];
        }

        if (meta != null) {
          final String radicalChar = meta['radical'];
          if (radicalData.containsKey(radicalChar)) {
            foundComponents.add({
              'char': char,
              'radical': radicalChar,
              'info': radicalData[radicalChar],
              'decomposition': meta['decomposition'],
            });
          }
        }
      }
      if (mounted) {
        setState(() {
          _anatomyComponents.clear();
          _anatomyComponents.addAll(foundComponents);
        });
      }
    } catch (e) { /* silent fail */ }
  }

  void _showRadicalDetails(Map<String, dynamic> comp) {
    if (_fullHanziMeta == null) return;
    final radicalChar = comp['radical'];
    final info = comp['info'];
    
    // Find examples (Limit to 8)
    final examples = _fullHanziMeta!.entries
        .where((e) => e.value['radical'] == radicalChar && e.key != comp['char'])
        .map((e) => e.key)
        .take(8)
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(radicalChar, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.red)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(info['meaning'], style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text("EXAMPLES IN HSK 1", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.indigo)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: examples.map((char) => Chip(
                label: Text(char, style: const TextStyle(fontSize: 18)),
                backgroundColor: Colors.indigo.withValues(alpha: 0.1),
              )).toList(),
            ),
            if (examples.isEmpty) const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("No other HSK 1 characters use this radical.", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    // 🚀 LIVE SYNC: Watch the controller state to get the LATEST stats from DB
    final allCards = ref.watch(flashcardControllerProvider).value ?? [];
    final globalCard = allCards.firstWhere(
      (c) => c.id == widget.card.id, 
      orElse: () => widget.card
    );
    
    // Fix: Prioritize the version that has stroke data.
    final Flashcard currentCard = (globalCard.strokePaths.isEmpty && _hydratedCard != null && _hydratedCard!.strokePaths.isNotEmpty)
        ? _hydratedCard!
        : (globalCard.strokePaths.isEmpty && _hydratedCard != null) ? _hydratedCard! : globalCard;
    
    final double masteryProgress = (currentCard.streak / 5.0).clamp(0.0, 1.0);

    final bool inLibrary = allCards.any((c) => c.hanzi == widget.card.hanzi);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Character Reference"),
      ),
      endDrawer: CharacterChatDrawer(hanzi: widget.card.hanzi),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton.extended(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.auto_awesome),
            label: const Text("Ask Tutor"),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          );
        }
      ),
      extendBodyBehindAppBar: true,
      body: CalligraphyBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        SizedBox(
                          height: 180,
                          width: 180,
                          child: _isLoadingStrokes 
                            ? const Center(child: CircularProgressIndicator(color: Colors.indigo))
                            : DrawingCanvas(
                                strokePaths: currentCard.strokePaths,
                                medianPaths: currentCard.medianPaths,
                                showAnimation: _isPlaying,
                                strokeLimit: _manualStrokeLimit,
                                readOnly: true,
                                showGrade: false,
                                autoCenter: true,
                                autoActiveChar: true,
                                isFlipped: currentCard.isFlipped,
                              ),
                        ),
                        MasterySeal(
                          progress: masteryProgress,
                          isMastered: currentCard.isMastered,
                          size: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildStrokeTimeline(isDark),
                    const SizedBox(height: 24),
                    Text(
                      currentCard.hanzi,
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF2C2C2C),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PinyinText(
                          text: currentCard.pinyin,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.volume_up, color: Colors.indigo, size: 24),
                          onPressed: () => ref.read(audioServiceProvider).playCharacter(currentCard.hanzi),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (!inLibrary)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final newCard = Flashcard(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        hanzi: currentCard.hanzi,
                        pinyin: currentCard.pinyin,
                        definition: currentCard.definition,
                        hskLevel: currentCard.hskLevel,
                        strokePaths: const [],
                        nextReviewDate: DateTime.now(),
                        interval: 0,
                        easeFactor: 2.5,
                        streak: 0,
                      );
                      ref.read(flashcardControllerProvider.notifier).addFlashcard(newCard);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to Study Deck!'), backgroundColor: Colors.green),
                      );
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text("Add to Study Deck"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              if (_anatomyComponents.isNotEmpty) _buildAnatomySection(context, isDark),
              const SizedBox(height: 16),
              _buildInfoSection(
                context,
                title: "Definition",
                content: currentCard.definition,
                icon: Icons.translate,
              ),
              const SizedBox(height: 16),
              _buildPersonalNotesSection(context, isDark),
              const SizedBox(height: 16),
              _buildCommonWordsSection(context, isDark),
              const SizedBox(height: 16),
              _buildAiContextSection(context, isDark),
              const SizedBox(height: 16),
              _buildInfoSection(
                context,
                title: "Scholarly Progress",
                icon: Icons.auto_graph,
                child: Column(
                  children: [
                    _buildStatRow("Mastery Level", "${(masteryProgress * 100).toInt()}%"),
                    _buildStatRow("Practice Attempts", "${currentCard.attempts}"),
                    _buildStatRow("Successful Writes", "${currentCard.successCount}"),
                    if (currentCard.lastAttemptDate != null)
                      _buildStatRow("Last Studied", DateFormat('MMM d, yyyy').format(currentCard.lastAttemptDate!)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewScreen(card: currentCard)),
                      ),
                      icon: const Icon(Icons.brush, color: Colors.white),
                      label: const Text("START PRACTICE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.auto_awesome_motion),
                      label: const Text("BACK TO LIBRARY", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.indigo,
                        side: const BorderSide(color: Colors.indigo, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStrokeTimeline(bool isDark) {
    if (_isLoadingStrokes) return const SizedBox(height: 48);
    final currentCard = _hydratedCard ?? widget.card;
    final validStrokes = currentCard.strokePaths.where((s) => s != '__CHAR_SEPARATOR__').toList();
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => setState(() {
              _isPlaying = !_isPlaying;
              if (_isPlaying) _manualStrokeLimit = null;
            }),
            icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle, color: Colors.indigo, size: 32),
          ),
          const SizedBox(width: 8),
          ...List.generate(validStrokes.length, (index) {
            final int strokeNum = index + 1;
            final bool isSelected = _manualStrokeLimit == strokeNum;
            return GestureDetector(
              onTap: () => setState(() {
                _manualStrokeLimit = strokeNum;
                _isPlaying = false;
              }),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 28, height: 28,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.indigo : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
                ),
                child: Center(
                  child: Text(
                    "$strokeNum",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.indigo,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAnatomySection(BuildContext context, bool isDark) {
    if (_anatomyComponents.length == 1) return _buildAnatomyCard(_anatomyComponents.first, isDark);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _anatomyComponents.asMap().entries.map((entry) {
            final int idx = entry.key;
            final String char = entry.value['char'];
            final bool isActive = _activeAnatomyIndex == idx;
            return GestureDetector(
              onTap: () {
                setState(() => _activeAnatomyIndex = idx);
                _pageController.animateToPage(idx, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? Colors.indigo : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
                ),
                child: Text(char, style: TextStyle(color: isActive ? Colors.white : Colors.indigo, fontWeight: FontWeight.bold)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _anatomyComponents.length,
            onPageChanged: (idx) => setState(() => _activeAnatomyIndex = idx),
            itemBuilder: (context, idx) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildAnatomyCard(_anatomyComponents[idx], isDark),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnatomyCard(Map<String, dynamic> comp, bool isDark) {
    return GestureDetector(
      onTap: () => _showRadicalDetails(comp),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? Colors.indigo.withValues(alpha: 0.1) : Colors.indigo.shade50.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.architecture, size: 18, color: Colors.indigo),
                    const SizedBox(width: 8),
                    Text("${comp['char']} ANATOMY", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.indigo, letterSpacing: 1.0)),
                  ],
                ),
                const Icon(Icons.info_outline, size: 16, color: Colors.indigo),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                  ),
                  child: Center(child: Text(comp['radical'], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFB22222)))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Radical: ${comp['info']['name']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      CrossReferenceText(
                        comp['info']['meaning'],
                        style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (comp['info']['mnemonic'] != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, size: 16, color: Colors.amber),
                    const SizedBox(width: 8),
                    Expanded(child: CrossReferenceText(comp['info']['mnemonic'], style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic))),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalNotesSection(BuildContext context, bool isDark) {
    return _buildInfoSection(
      context,
      title: "Personal Notes",
      icon: Icons.edit_note,
      child: TextField(
        controller: _notesController,
        onChanged: _saveNotes,
        maxLines: null,
        minLines: 3,
        style: TextStyle(fontSize: 16, color: isDark ? Colors.white : Colors.black87),
        decoration: InputDecoration(
          hintText: "Add your own mnemonics or notes here...",
          hintStyle: TextStyle(color: isDark ? Colors.white38 : Colors.black38),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo.withValues(alpha: 0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.indigo.withValues(alpha: 0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.indigo, width: 2),
          ),
          filled: true,
          fillColor: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.indigo.shade50.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildCommonWordsSection(BuildContext context, bool isDark) {
    if (widget.card.hanzi.length > 1) return const SizedBox.shrink(); 
    
    final commonWordsAsync = ref.watch(commonWordsProvider(widget.card.hanzi));
    
    return commonWordsAsync.when(
      data: (words) {
        if (words.isEmpty) return const SizedBox.shrink();
        return _buildInfoSection(
          context,
          title: "Common Words",
          icon: Icons.hub,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: words.map((w) => ActionChip(
              label: Text("${w.hanzi} (${w.pinyin})", style: const TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: isDark ? Colors.indigo.shade900.withValues(alpha: 0.3) : Colors.indigo.shade50,
              side: BorderSide.none,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CharacterDetailScreen(card: w)));
              },
            )).toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text("Error: $e"),
    );
  }

  Widget _buildAiContextSection(BuildContext context, bool isDark) {
    final aiContextAsync = ref.watch(characterContextProvider(widget.card));
    
    return aiContextAsync.when(
      data: (contextData) {
        if (contextData == null) return const SizedBox.shrink();
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection(
              context,
              title: "AI Memory Hook",
              icon: Icons.lightbulb,
              content: contextData.mnemonic,
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              context,
              title: "Example Sentences",
              icon: Icons.format_quote,
              child: Column(
                children: contextData.sentences.map((sentence) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text(sentence.chinese, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                            IconButton(
                              icon: const Icon(Icons.volume_up, size: 20, color: Colors.indigo),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => ref.read(audioServiceProvider).playCharacter(sentence.chinese),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(sentence.pinyin, style: const TextStyle(fontSize: 14, color: Colors.indigo)),
                        const SizedBox(height: 8),
                        StatefulBuilder(
                          builder: (context, setState) {
                            bool isRevealed = false;
                            return GestureDetector(
                              onTap: () => setState(() => isRevealed = true),
                              child: Stack(
                                children: [
                                  Text(
                                    sentence.english, 
                                    style: TextStyle(
                                      fontSize: 14, 
                                      color: isDark ? Colors.white70 : Colors.black87, 
                                      fontStyle: FontStyle.italic
                                    )
                                  ),
                                  if (!isRevealed)
                                    Positioned.fill(
                                      child: ClipRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                                          child: Container(
                                            color: Colors.transparent,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Tap to reveal",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: isDark ? Colors.white : Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ),
            if (contextData.lookAlikes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildInfoSection(
                context,
                title: "Ghost Characters",
                icon: Icons.warning_amber_rounded,
                child: Column(
                  children: contextData.lookAlikes.map((lookAlike) => Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(lookAlike.character, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                              const SizedBox(width: 8),
                              Text("(${lookAlike.pinyin})", style: const TextStyle(fontSize: 16, color: Colors.deepOrange)),
                              const Spacer(),
                              Text(lookAlike.english, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(lookAlike.difference, style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87)),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ],
        );
      },
      loading: () => _buildInfoSection(
        context,
        title: "AI Smart Context",
        icon: Icons.auto_awesome,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(color: Colors.indigo),
          ),
        ),
      ),
      error: (e, st) => const SizedBox.shrink(),
    );
  }

  Widget _buildInfoSection(BuildContext context, {required String title, String? content, required IconData icon, Widget? child}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.indigo),
              const SizedBox(width: 8),
              Text(title.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 12),
          if (content != null) CrossReferenceText(content, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          if (child != null) child,
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
        ],
      ),
    );
  }
}