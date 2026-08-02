import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../domain/models/library_story.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../reading/presentation/providers/story_controller.dart';
import '../../../reading/presentation/screens/story_reader_screen.dart';
import 'web_browser_screen.dart';
import '../../../../shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

class StorySummaryScreen extends ConsumerStatefulWidget {
  final LibraryStory story;

  const StorySummaryScreen({super.key, required this.story});

  @override
  ConsumerState<StorySummaryScreen> createState() => _StorySummaryScreenState();
}

class _StorySummaryScreenState extends ConsumerState<StorySummaryScreen> {
  late StoryBlueprint _blueprint;
  String? _enrichedSummary;
  bool _isEnriching = false;

  static final List<String> _placeholders = [
    'A classic Tang Dynasty poem',
    'A classic Tang Dynasty poem by',
    '经典唐诗',
  ];

  bool _isPlaceholder(String text) {
    return _placeholders.any((p) => text.startsWith(p)) || text.length < 60;
  }

  @override
  void initState() {
    super.initState();
    _blueprint = StoryBlueprint(
      id: widget.story.link,
      title: widget.story.title,
      topic: widget.story.title,
      category: widget.story.category,
      imageUrl: widget.story.imageUrl ?? 'assets/images/ai_hub_ink_mountains.png',
      tags: [widget.story.category],
    );
    
    // Start loading the story immediately to fetch vocabulary
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.story.link.startsWith('custom_')) {
        ref.read(storyControllerProvider.notifier).loadOrGenerateStory(_blueprint, widget.story.hskLevel);
      } else if (widget.story.link.startsWith('local_') || widget.story.link.startsWith('tang_poetry_')) {
        ref.read(storyControllerProvider.notifier).fetchAndParseLocalStory(_blueprint, widget.story.hskLevel);
      } else {
        ref.read(storyControllerProvider.notifier).fetchAndParseFirebaseStory(_blueprint, widget.story.hskLevel);
      }
    });

    // Enrich placeholder summaries with AI-generated content
    final summaryText = widget.story.summaryEn ?? widget.story.summary;
    if (_isPlaceholder(summaryText) && widget.story.link.startsWith('tang_poetry_')) {
      _enrichSummary();
    }
  }

  Future<void> _enrichSummary() async {
    setState(() => _isEnriching = true);
    try {
      // Load the Tang poetry JSON to get the full poem text
      final jsonString = await rootBundle.loadString('assets/data/tang_poetry_en.json');
      final data = json.decode(jsonString) as List<dynamic>;
      final entry = data.firstWhere(
        (d) => (d['link'] ?? 'tang_poetry_${d['title']}') == widget.story.link,
        orElse: () => null,
      );
      if (entry == null) return;

      final rawText = entry['rawText'] as String? ?? '';
      if (rawText.isEmpty) return;

      final gemini = ref.read(geminiServiceProvider);
      final result = await gemini.generateDetailedSummary(
        widget.story.titleEn ?? widget.story.title,
        rawText,
        gemini.targetLanguage,
      );
      if (result.isNotEmpty && mounted) {
        setState(() => _enrichedSummary = result);
      }
    } catch (e) {
      debugPrint('Error enriching summary: $e');
    } finally {
      if (mounted) setState(() => _isEnriching = false);
    }
  }

  void _startReading() {
    Navigator.push(
      context,
      SwipeBackPageRoute(
        builder: (context) => StoryReaderScreen(
          blueprint: _blueprint,
          hskLevel: widget.story.hskLevel,
        ),
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Image.asset(
      'assets/images/ai_hub_ink_mountains.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: 300,
      color: Colors.black.withValues(alpha: 0.4),
      colorBlendMode: BlendMode.darken,
    );
  }

  @override
  Widget build(BuildContext context) {
    final storyState = ref.watch(storyControllerProvider);
    final displayImageUrl = widget.story.imageUrl ?? 'assets/images/ai_hub_ink_mountains.png';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0), // Zen Paper / Carbon Ink
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: const Color(0xFF1A1A1B),
                foregroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: displayImageUrl.startsWith('http')
                    ? Image.network(
                        displayImageUrl,
                        fit: BoxFit.cover,
                        color: Colors.black.withValues(alpha: 0.4),
                        colorBlendMode: BlendMode.darken,
                        errorBuilder: (_, __, ___) => _buildFallbackImage(),
                      )
                    : Image.asset(
                        displayImageUrl,
                        fit: BoxFit.cover,
                        color: Colors.black.withValues(alpha: 0.4),
                        colorBlendMode: BlendMode.darken,
                        errorBuilder: (_, __, ___) => _buildFallbackImage(),
                      ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HSK Badge & Category
                      Row(
                        children: [
                          if (widget.story.hskLevel > 0) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF8B0000), // Deep red
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'HSK ${widget.story.hskLevel}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (widget.story.hskLevel == 0) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1B), // Deep ink
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Native',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.2)
                                    : const Color(0xFF1A1A1B).withValues(alpha: 0.2),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.story.category,
                              style: TextStyle(
                                color: isDark ? Colors.white70 : const Color(0xFF1A1A1B),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Titles
                      TappableHanziText(
                        widget.story.titleEn ?? widget.story.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSerifSC',
                          color: Color(0xFF1A1A1B),
                          height: 1.2,
                        ),
                      ),
                      if (widget.story.titleEn != null) ...[
                        const SizedBox(height: 8),
                        TappableHanziText(
                          widget.story.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'NotoSerifSC',
                            color: const Color(0xFF1A1A1B).withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                      const SizedBox(height: 32),
                      
                      // Summary
                      Row(
                        children: [
                          const Text(
                            'Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSerifSC',
                              color: Color(0xFF1A1A1B),
                            ),
                          ),
                          if (_isEnriching) ...[
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: const Color(0xFF1A1A1B).withValues(alpha: 0.4),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      TappableHanziText(
                        _enrichedSummary ?? widget.story.summaryEn ?? widget.story.summary,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.75)
                              : const Color(0xFF1A1A1B).withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Key Words
                      const Text(
                        'Key Words',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSerifSC',
                          color: Color(0xFF1A1A1B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildKeyWords(storyState),
                      
                      // Bottom padding for the FAB
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Floating Action Button
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: widget.story.link.startsWith('http')
              ? Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B0000).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ]
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        SwipeBackPageRoute(
                          builder: (_) => WebBrowserScreen(
                            initialUrl: widget.story.link,
                            autoReadingMode: true,
                            isStoryMode: true,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000), // Deep red
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Open Original Website',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.open_in_new_rounded, size: 20),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B0000).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ]
                  ),
                  child: ElevatedButton(
                    onPressed: _startReading,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000), // Deep red
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Start Reading',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.menu_book_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyWords(StoryState storyState) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (storyState.isLoading && storyState.currentStory == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: CircularProgressIndicator(color: Color(0xFF8B0000)),
        ),
      );
    }
    
    if (storyState.currentStory == null) {
      return Text(
        'Could not load vocabulary.',
        style: TextStyle(color: const Color(0xFF1A1A1B).withValues(alpha: 0.5)),
      );
    }
    
    // Extract vocabulary from sentences and deduplicate
    final Set<String> seenHanzi = {};
    final vocabList = storyState.currentStory!.sentences
        .expand((s) => s.words)
        .where((word) {
          // Filter out punctuation and non-Chinese characters
          if (!RegExp(r'[\u4e00-\u9fa5]').hasMatch(word.hanzi)) return false;
          
          if (seenHanzi.contains(word.hanzi)) return false;
          seenHanzi.add(word.hanzi);
          return true;
        })
        .toList();

    if (vocabList.isEmpty) {
      return Text(
        'No key words found for this story.',
        style: TextStyle(color: const Color(0xFF1A1A1B).withValues(alpha: 0.5)),
      );
    }
    
    // Sort to prioritize multi-character words (idioms, names, compounds) over single characters
    vocabList.sort((a, b) {
      if (a.hanzi.length != b.hanzi.length) {
        return b.hanzi.length.compareTo(a.hanzi.length);
      }
      return 0;
    });
    
    // Take up to 8 keywords for the preview
    final previewVocab = vocabList.take(8).toList();
    
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: previewVocab.map((word) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFF1A1A1B).withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.03),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TappableHanziText(
                word.hanzi,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSerifSC',
                  color: Color(0xFF1A1A1B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                word.pinyin,
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF1A1A1B).withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                word.meaning,
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF1A1A1B).withValues(alpha: 0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
