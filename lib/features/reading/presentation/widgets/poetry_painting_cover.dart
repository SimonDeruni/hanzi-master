import 'package:flutter/material.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';

class PoetryPaintingCover extends StatelessWidget {
  const PoetryPaintingCover({
    super.key,
    required this.book,
    required this.fallbackBuilder,
    this.width = double.infinity,
    this.height = double.infinity,
    this.showBadge = true,
  });

  final BookModel book;
  final WidgetBuilder fallbackBuilder;
  final double width;
  final double height;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final dynasty = poetryDynastyLabel(
      book.id,
      fallback: book.dynastyOrEra.trim(),
    );
    final byline = dynasty.isEmpty ? book.author : '$dynasty · ${book.author}';

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              poetryCoverAssetPath(book.id),
              key: const ValueKey('poetry-painting'),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  fallbackBuilder(context),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.44, 1],
                  colors: [
                    Color(0x33000000),
                    Color(0x11000000),
                    Color(0xD9000000),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 11,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x99000000), Color(0x00000000)],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 12,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSerifSC',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 1.12,
                      shadows: [
                        Shadow(color: Colors.black, blurRadius: 5),
                      ],
                    ),
                  ),
                  if (byline.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      byline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFFF5EAD2),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(color: Colors.black, blurRadius: 4),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showBadge)
              Positioned(
                top: 9,
                right: 9,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8D271F).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0x99F4D79B)),
                  ),
                  child: const Text(
                    '诗',
                    style: TextStyle(
                      color: Color(0xFFFFF4D6),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
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
