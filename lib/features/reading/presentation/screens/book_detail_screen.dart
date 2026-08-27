import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

class BookDetailScreen extends ConsumerWidget {
  final BookModel book;
  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);

    final chaptersAsync = ref.watch(bookChaptersProvider(book.id));
    final currentProgress = ref.watch(bookProgressProvider(book.id));

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_outlined, size: 22, color: primaryText),
            onPressed: () {
              HapticsManager.light();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Book link copied to clipboard!')),
              );
            },
          ),
        ],
      ),
      body: chaptersAsync.when(
        data: (chapters) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Book Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Calligraphic Book Cover
                      CalligraphicBookCover(
                        book: book,
                        width: 135,
                        height: 190,
                      ),
                      const SizedBox(height: 16),

                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.titleEn,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Tags Row
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        children: [
                          _buildBadge('HSK ${book.hskLevel}', isDark ? Colors.amber.shade400 : const Color(0xFF8B0000)),
                          _buildBadge(book.category, isDark ? Colors.blue.shade300 : Colors.indigo.shade700),
                          _buildBadge(book.dynastyOrEra, isDark ? Colors.green.shade300 : Colors.teal.shade700),
                          _buildBadge('${chapters.length} 回 / Chapters', isDark ? Colors.purple.shade300 : Colors.deepPurple.shade700),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Author & Historical Background Card
                      Container(
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
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isDark ? Colors.amber.withValues(alpha: 0.15) : const Color(0xFF8B0000).withValues(alpha: 0.08),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 22,
                                    color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${book.author} · ${book.authorEn}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: primaryText,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${book.dynastyOrEra} · ${book.category}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '本作是 ${book.author} 的代表性传世巨著，在世界与中华文学史上具有深远的历史影响与文学造诣。',
                              style: TextStyle(
                                fontSize: 14.5,
                                height: 1.55,
                                color: isDark ? Colors.white70 : const Color(0xFF2C2C2E),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'An immortal classic by ${book.authorEn} (${book.dynastyOrEra}), celebrated globally for its profound philosophical insight, timeless narrative power, and cultural significance.',
                              style: TextStyle(
                                fontSize: 13.5,
                                height: 1.45,
                                color: isDark ? Colors.white54 : Colors.black54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Synopsis Card
                      Container(
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
                                Icon(Icons.auto_stories, size: 20, color: isDark ? Colors.amber.shade400 : const Color(0xFF8B0000)),
                                const SizedBox(width: 8),
                                Text(
                                  'Synopsis · 作品概述',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              book.description,
                              style: TextStyle(
                                fontSize: 15.5,
                                height: 1.6,
                                color: isDark ? Colors.white70 : const Color(0xFF1A1A1B),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              book.descriptionEn,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: isDark ? Colors.white54 : Colors.black54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Divider(color: isDark ? Colors.white12 : Colors.black12),
                            const SizedBox(height: 8),
                            // Thematic Highlights
                            Row(
                              children: [
                                Icon(Icons.psychology_outlined, size: 16, color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000)),
                                const SizedBox(width: 6),
                                Text(
                                  '核心思想与阅读价值 · Core Themes',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '全篇通过跌宕起伏的叙事艺术，探讨了人性抉择、道德伦理与精神追求，是语言学习与人文修养的必读典范。',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: isDark ? Colors.white60 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'A timeless exploration of morality, resilience, and human destiny—ideal for deep language immersion and cultural enlightenment.',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.35,
                                color: isDark ? Colors.white38 : Colors.black45,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Action Button (Start / Continue Reading)
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            HapticsManager.heavy();
                            final initialIndex = (currentProgress - 1).clamp(0, chapters.length - 1);
                            Navigator.of(context).push(
                              SwipeBackPageRoute(
                                builder: (_) => BookReaderScreen(
                                  book: book,
                                  chapters: chapters,
                                  initialChapterIndex: initialIndex,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? Colors.amber.shade700 : const Color(0xFF1A1A1B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                currentProgress > 1 ? Icons.auto_stories : Icons.play_arrow_rounded,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                currentProgress > 1
                                    ? '继续阅读第 $currentProgress 回 · Continue Chapter $currentProgress'
                                    : '开始阅读第一回 · Start Reading',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (book.audioStreamUrl != null) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              HapticsManager.medium();
                              final initialIndex = (currentProgress - 1).clamp(0, chapters.length - 1);
                              Navigator.of(context).push(
                                SwipeBackPageRoute(
                                  builder: (_) => BookReaderScreen(
                                    book: book,
                                    chapters: chapters,
                                    initialChapterIndex: initialIndex,
                                    autoStartHumanAudio: true,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.podcasts, size: 18, color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000)),
                            label: Text(
                              '🎙️ 畅听真人原声 · Listen Open Human Audio (Archive.org)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.amber.shade200 : const Color(0xFF8B0000),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDark ? Colors.amber.shade700 : const Color(0xFF8B0000),
                                width: 1.2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),

                      // Table of Contents Header
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Table of Contents · 目录 (${chapters.length} Chapters)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Chapter List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ch = chapters[index];
                      final isCurrent = ch.chapterIndex == currentProgress;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? (isDark ? Colors.amber.withValues(alpha: 0.15) : const Color(0xFFF2ECE1))
                              : cardBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isCurrent
                                ? (isDark ? Colors.amber.shade500 : const Color(0xFF8B0000))
                                : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
                            width: isCurrent ? 1.5 : 1.0,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            HapticsManager.medium();
                            Navigator.of(context).push(
                              SwipeBackPageRoute(
                                builder: (_) => BookReaderScreen(
                                  book: book,
                                  chapters: chapters,
                                  initialChapterIndex: index,
                                ),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            radius: 16,
                            backgroundColor: isCurrent
                                ? (isDark ? Colors.amber.shade700 : const Color(0xFF8B0000))
                                : (isDark ? Colors.white12 : Colors.black12),
                            child: Text(
                              '${ch.chapterIndex}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isCurrent ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                              ),
                            ),
                          ),
                          title: Text(
                            ch.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryText,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              ch.titleEn,
                              style: TextStyle(
                                fontSize: 12.5,
                                color: isDark ? Colors.amber.shade300 : const Color(0xFF8B0000),
                                fontStyle: FontStyle.italic,
                                height: 1.3,
                              ),
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        ),
                      );
                    },
                    childCount: chapters.length,
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading chapters: $e')),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
