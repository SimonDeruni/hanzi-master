import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import '../../../../features/vision/presentation/screens/ar_lens_screen.dart';
import '../../../../core/services/ocr_service.dart';
import '../../../../core/services/character_lookup_service.dart';
import '../../../flashcards/domain/entities/flashcard.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../course/presentation/screens/lesson_screen.dart';
import '../../../course/presentation/providers/lesson_controller.dart';
import '../../../course/presentation/widgets/mission_briefing_sheet.dart';
import '../../../../core/providers/translation_language_provider.dart';

class UniversalScannerScreen extends ConsumerStatefulWidget {
  final bool returnTextMode;

  const UniversalScannerScreen({super.key, this.returnTextMode = false});

  @override
  ConsumerState<UniversalScannerScreen> createState() => _UniversalScannerScreenState();
}

class _UniversalScannerScreenState extends ConsumerState<UniversalScannerScreen> {
  final OcrService _ocrService = OcrService();
  bool _isScanning = false;
  bool _isLookingUp = false;
  String _rawExtractedText = "";
  List<CharacterInfo> _matchedCharacters = [];

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
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
        await _processExtractedText(extractedText);
      }
    } else {
      setState(() => _isScanning = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.noChineseCharactersFound)),
        );
      }
    }
  }

  Future<void> _processExtractedText(String text) async {
    HapticsManager.success();
    setState(() {
      _isScanning = false;
      _rawExtractedText = text;
      _isLookingUp = true;
    });

    // Extract every individual Chinese character from the scanned text.
    // We also try multi-character words (2-char) for richer matches.
    final lookupService = ref.read(characterLookupServiceProvider);
    await lookupService.init();

    final Set<String> candidates = {};
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (RegExp(r'[\u4E00-\u9FFF]').hasMatch(char)) {
        candidates.add(char);
        // Also try the 2-char word starting here
        if (i + 1 < text.length) {
          candidates.add(text.substring(i, i + 2));
        }
      }
    }

    final results = await lookupService.lookupAll(candidates);

    // Sort: HSK-tagged first (by level), then untagged (level 0) at end
    results.sort((a, b) {
      if (a.hskLevel == 0 && b.hskLevel != 0) return 1;
      if (b.hskLevel == 0 && a.hskLevel != 0) return -1;
      return a.hskLevel.compareTo(b.hskLevel);
    });

    if (mounted) {
      setState(() {
        _matchedCharacters = results;
        _isLookingUp = false;
      });
    }
  }

  Future<void> _createDeck() async {
    if (_matchedCharacters.isEmpty) return;
    HapticsManager.light();

    final controller = ref.read(flashcardControllerProvider.notifier);
    int addedCount = 0;
    final currentCards = ref.read(flashcardControllerProvider).valueOrNull ?? [];

    for (final info in _matchedCharacters) {
      final exists = currentCards.any((c) => c.hanzi == info.hanzi);
      if (!exists) {
        final newCard = Flashcard(
          id: DateTime.now().millisecondsSinceEpoch.toString() + addedCount.toString(),
          hanzi: info.hanzi,
          pinyin: info.pinyin,
          definition: info.definition,
          hskLevel: info.hskLevel,
          strokePaths: const [],
          modeStats: const {},
        );
        await controller.addFlashcard(newCard);
        addedCount++;
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.addedNewCharactersTo)),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _startLesson(CharacterInfo info) async {
    HapticsManager.light();
    final card = Flashcard(
      id: 'ocr_${info.hanzi}',
      hanzi: info.hanzi,
      pinyin: info.pinyin,
      definition: info.definition,
      hskLevel: info.hskLevel,
      strokePaths: const [],
      modeStats: const {},
    );

    final controller = ref.read(flashcardControllerProvider.notifier);
    final hydratedCard = await controller.loadStrokesFor(card);

    if (mounted) {
      final allCards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
      ref.read(allCardsProvider.notifier).state = allCards;
      ref.read(activeWarmupCardsProvider.notifier).state = [hydratedCard ?? card];

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => MissionBriefingSheet(
          targetCard: hydratedCard ?? card,
          warmupCards: [hydratedCard ?? card],
          radicalHanzi: "",
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.universalScanner),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CalligraphyBackground(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildScanButton(
                      icon: Icons.camera_alt,
                      label: l10n.takePhoto,
                      onTap: () => _startScan(true),
                      theme: theme,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildScanButton(
                      icon: Icons.image,
                      label: l10n.gallery,
                      onTap: () => _startScan(false),
                      theme: theme,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildScanButton(
                      icon: Icons.view_in_ar,
                      label: l10n.arLens,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ARLensScreen()),
                        );
                      },
                      theme: theme,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Results Area
            Expanded(
              child: _isScanning || _isLookingUp
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: theme.colorScheme.primary),
                          const SizedBox(height: 16),
                          Text(
                            _isScanning
                                ? l10n.extractingTextAndObjects
                                : l10n.lookingUpCharacters,
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
                          ),
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
                                  l10n.scanATextbookSign,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                                ),
                              ],
                            ),
                          ),
                        )
                      : _buildResultsList(theme, l10n),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
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
              child: Icon(icon, size: 28, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(ThemeData theme, AppLocalizations l10n) {
    if (widget.returnTextMode) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.extractedText, style: theme.textTheme.headlineMedium),
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
                  child: Text(_rawExtractedText, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6)),
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
              label: Text(l10n.useText, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary)),
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
                l10n.noMatchingDictionaryEntries,
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
                l10n.foundNCharacters(_matchedCharacters.length),
                style: theme.textTheme.titleLarge,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _createDeck,
                    style: IconButton.styleFrom(backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1)),
                    icon: Icon(Icons.library_add, color: theme.colorScheme.primary),
                    tooltip: l10n.importAll,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _matchedCharacters.isNotEmpty ? () => _startLesson(_matchedCharacters.first) : null,
                    style: IconButton.styleFrom(backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.1)),
                    icon: Icon(Icons.auto_awesome, color: theme.colorScheme.secondary),
                    tooltip: l10n.practiceAll,
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
              final info = _matchedCharacters[index];
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
                    Text(info.hanzi, style: theme.textTheme.displaySmall?.copyWith(fontSize: 40)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PinyinText(
                            text: info.pinyin,
                            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
                          ),
                          const SizedBox(height: 4),
                          Text(info.definition, style: theme.textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // HSK badge
                    if (info.hskLevel > 0)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'HSK${info.hskLevel}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.play_arrow_rounded, color: theme.colorScheme.secondary),
                        onPressed: () => _startLesson(info),
                        tooltip: l10n.startAscension,
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
