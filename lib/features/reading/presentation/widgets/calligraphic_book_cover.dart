import 'package:flutter/material.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';

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
    final displayTitle = book.title.length > 6 ? '${book.title.substring(0, 5)}…' : book.title;

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
                  fontFamily: 'serif',
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
                      fontFamily: 'serif',
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imagePath = 'assets/images/books/${book.id}.jpg';

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
            // 1. True Book Cover Image
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildCalligraphicFallback(context, isDark),
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

            // Top gradient overlay for HSK badge readability
            if (showBadge)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 38,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.55),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
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

            // 3. HSK Badge (Top Right)
            if (showBadge)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.7),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    'HSK ${book.hskLevel}',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFDF78),
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
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
