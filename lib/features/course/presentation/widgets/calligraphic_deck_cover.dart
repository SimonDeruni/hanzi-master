import 'package:flutter/material.dart';

class CalligraphicDeckCover extends StatelessWidget {
  final String title;
  final String titleHanzi;
  final String watermarkHanzi;
  final List<Color> gradientColors;
  final String badgeText;
  final Color? badgeColor;
  final bool isInstalled;
  final double width;
  final double height;

  const CalligraphicDeckCover({
    super.key,
    required this.title,
    required this.titleHanzi,
    required this.watermarkHanzi,
    required this.gradientColors,
    required this.badgeText,
    this.badgeColor,
    this.isInstalled = false,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final displayHanzi = titleHanzi.isNotEmpty
        ? (titleHanzi.length > 5 ? '${titleHanzi.substring(0, 4)}…' : titleHanzi)
        : (title.length > 5 ? '${title.substring(0, 4)}…' : title);

    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Stack(
          children: [
            // 1. Left Book Spine Accent with Traditional Binding Stitches
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              width: 14,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.28),
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
                      width: 7,
                      height: 2,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 2. Background Hanzi Watermark
            Positioned(
              right: -8,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: Text(
                  watermarkHanzi.isNotEmpty ? watermarkHanzi : '字',
                  style: const TextStyle(
                    fontSize: 90,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontFamily: 'NotoSerifSC',
                  ),
                ),
              ),
            ),

            // 3. Center Calligraphic Plaque (Xuan Parchment with Emperor's Gold Border)
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 18, right: 10, top: 12, bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F6EE),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.75),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayHanzi,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A1B),
                        letterSpacing: 1.2,
                        fontFamily: 'NotoSerifSC',
                        height: 1.15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B0000).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8B0000),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. Badge — Top Right (e.g. "50 词" or "HSK 1")
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: (badgeColor ?? Colors.black).withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 0.6,
                  ),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),

            // 5. Installed Checkmark Badge — Top Left (beside spine)
            if (isInstalled)
              Positioned(
                top: 8,
                left: 18,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, size: 10, color: Colors.white),
                      SizedBox(width: 2),
                      Text(
                        'SAVED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
