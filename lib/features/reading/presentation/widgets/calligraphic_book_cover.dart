import 'package:flutter/material.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';

class CalligraphicBookCover extends StatelessWidget {
  final BookModel book;
  final double width;
  final double height;
  final bool showBadge;

  const CalligraphicBookCover({
    super.key,
    required this.book,
    this.width = double.infinity,
    this.height = double.infinity,
    this.showBadge = true,
  });

  List<Color> _getGenreGradient(String category, bool isDark) {
    switch (category) {
      case 'Chinese Epics':
        return [const Color(0xFF8B1E1E), const Color(0xFF4A0E0E)];
      case 'Chinese Poetry':
      case 'Tang Poetry':
        return [const Color(0xFF4A1212), const Color(0xFF240606)];
      case 'Ancient Philosophy':
        return [const Color(0xFF1E3A2B), const Color(0xFF0F2218)];
      case 'Supernatural & Folklore':
        return [const Color(0xFF38234D), const Color(0xFF1B0F29)];
      case 'Modern Chinese':
        return [const Color(0xFF36322C), const Color(0xFF1E1A16)];
      case 'French Classics':
        return [const Color(0xFF1E355B), const Color(0xFF0E1E36)];
      case 'German Classics':
        return [const Color(0xFF263D2E), const Color(0xFF122117)];
      case 'Spanish, Italian & Russian Classics':
      case 'Spanish & World':
        return [const Color(0xFF52221B), const Color(0xFF2E100C)];
      case 'English, American & Global Classics':
      case 'English & World':
      default:
        return [const Color(0xFF233142), const Color(0xFF111B26)];
    }
  }

  Widget _buildCalligraphicFallback(BuildContext context, bool isDark) {
    final gradientColors = _getGenreGradient(book.category, isDark);
    final displayTitle =
        book.title.length > 6 ? '${book.title.substring(0, 5)}…' : book.title;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Left Spine Accent
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            width: 14,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                border: Border(
                  right: BorderSide(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (i) => Container(
                    width: 6,
                    height: 2,
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          ),
// Background Hanzi Watermark
          Positioned(
            right: -6,
            bottom: -10,
            child: Opacity(
              opacity: 0.08,
              child: Text(
                book.title.isNotEmpty ? book.title[0] : '书',
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
// Center Calligraphic Plaque
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F6EE),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.65),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A1B),
                      letterSpacing: 1.5,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9E2A2B),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(
                      '典藏',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFF8E7),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The cover for a poem, drawn entirely in code - no photograph.
  ///
  /// The bundled poem artwork is AI-generated, so it is deliberately not used:
  /// instead the cover is an ink wash by era, the poem's own characters set
  /// large, the poet beneath them, and a red seal in the corner. That reads as
  /// a printed Chinese collection and stays sharp at any size.
  Widget _buildPoetryCover(BuildContext context, bool isDark) {
    final List<Color> ink = _getGenreGradient(book.category, isDark);
    final String hanzi = book.title.trim();
    final String byline = (book.author.trim().isNotEmpty
            ? book.author.trim()
            : book.titleEn.trim())
        .trim();
    final bool spacious = width.isFinite && height.isFinite &&
        width >= 96 && height >= 128;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Ink wash, darker at the foot of the cover.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ink.first.withValues(alpha: 0.95),
                ink.last,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // A faint sheet sheen so the ink does not read as a flat block.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.07),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.18),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
        ),
        if (spacious && hanzi.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    hanzi,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.96),
                      fontSize: (width / 5.5).clamp(15.0, 46.0),
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      letterSpacing: 4,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.45),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                if (byline.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    byline,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.62),
                      fontSize: (width / 16).clamp(9.0, 13.0),
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        // The seal: a red stamp, the way a Chinese collection marks its cover.
        Positioned(
          right: spacious ? 10 : 5,
          bottom: spacious ? 10 : 5,
          child: Container(
            width: spacious ? 26 : 14,
            height: spacious ? 26 : 14,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFB3261E),
              borderRadius: BorderRadius.circular(spacious ? 5 : 3),
            ),
            child: Text(
              '詩',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: spacious ? 14 : 8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        // Ink border, so the cover reads as a mounted print.
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.14),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPoetry = book.category.contains('Poetry') ||
        book.id.startsWith('poetry_') ||
        book.id.startsWith('tang_poetry_');
    final imagePath = bookCoverAssetPath(book.id, isPoetry: isPoetry);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2430) : const Color(0xFFE8E0D2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.18),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            isPoetry
                ? _buildPoetryCover(context, isDark)
                : Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildCalligraphicFallback(context, isDark),
                  ),
// 2. Subtle Spine Left Shadow (Tactile 3D book illusion)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 12,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
// Bottom gradient overlay for Chapter badge readability
            if (showBadge)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 38,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.65),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
// 4. Chapters Count (Bottom Right)
            if (showBadge)
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${book.totalChapters} 回',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
