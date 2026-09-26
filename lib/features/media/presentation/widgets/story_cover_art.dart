import 'package:flutter/material.dart';

import 'package:hanzi_master/features/media/domain/models/library_story.dart';

/// The cover of a library story, drawn with the app's book-cover vocabulary.
///
/// Why this exists: the first screen of a story used to show a flat, 300px band
/// of `assets/images/ai_hub_ink_mountains.png` — the *same* monochrome mountain
/// for a story about dumplings and tangyuan as for one about the Terracotta
/// Army. Two things were wrong with that: the artwork had no connection to the
/// story, and the screen did not look like the rest of the reading experience.
///
/// It now resolves, in order:
///
/// 1. the story's own image ([LibraryStory.imageUrl]) — a network cover from the
///    feed, or a bundled asset;
/// 2. the **Mandarin Bean cover shipped with the app**, derived from the article
///    slug: `https://mandarinbean.com/dumplings-and-tangyuan/` resolves to
///    `assets/images/mandarin_bean/dumplings-and-tangyuan.jpg`. 134 of the 150
///    bundled stories have one; the data simply never pointed at them;
/// 3. a **topic-aware** calligraphic card (gradient + glyph by category), so a
///    food story can never fall back to a mountain range.
///
/// The composition matches [CalligraphicBookCover]: a portrait card with a
/// spine, a soft shadow and a bottom scrim, so a story and a book read as the
/// same kind of object.
class StoryCoverArt extends StatelessWidget {
  const StoryCoverArt({
    super.key,
    required this.story,
    this.width = 135,
    this.height = 190,
    this.showSourceBadge = true,
  });

  final LibraryStory story;
  final double width;
  final double height;

  /// Shows the source name ("Mandarin Bean") on the bottom scrim.
  final bool showSourceBadge;

  /// The bundled Mandarin Bean cover for an article URL, or null when the link
  /// is not an article URL (poetry ids, `local_…`, `custom_…`).
  static String? bundledCoverAsset(String link) {
    final Uri? uri = Uri.tryParse(link);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) return null;
    final List<String> segments =
        uri.pathSegments.where((String s) => s.isNotEmpty).toList();
    if (segments.isEmpty) return null;
    final String slug = segments.last.toLowerCase();
    if (slug.isEmpty) return null;
    return 'assets/images/mandarin_bean/$slug.jpg';
  }

  /// A single glyph that belongs to the story's subject, used only when there is
  /// no artwork at all.
  static String topicGlyph(String category) {
    final String c = category.toLowerCase();
    if (c.contains('food') || c.contains('dining') || c.contains('cooking')) {
      return '食';
    }
    if (c.contains('history') || c.contains('ancient')) return '史';
    if (c.contains('idiom') || c.contains('proverb') || c.contains('culture')) {
      return '文';
    }
    if (c.contains('nature') || c.contains('travel') || c.contains('place')) {
      return '山';
    }
    if (c.contains('science') || c.contains('technology')) return '科';
    if (c.contains('fairy') || c.contains('folk') || c.contains('legend')) {
      return '仙';
    }
    if (c.contains('beginner') || c.contains('language')) return '语';
    return '书';
  }

  /// Warm hues for food, jade for history, ink for everything else — the same
  /// idea as the genre gradients on the book covers.
  static List<Color> topicGradient(String category) {
    final String c = category.toLowerCase();
    if (c.contains('food') || c.contains('dining') || c.contains('cooking')) {
      return <Color>[const Color(0xFF8B1E1E), const Color(0xFF3A0C0C)];
    }
    if (c.contains('history') || c.contains('ancient')) {
      return <Color>[const Color(0xFF1E3A2B), const Color(0xFF0F2218)];
    }
    if (c.contains('science') || c.contains('technology')) {
      return <Color>[const Color(0xFF233142), const Color(0xFF111B26)];
    }
    if (c.contains('fairy') || c.contains('folk') || c.contains('legend')) {
      return <Color>[const Color(0xFF38234D), const Color(0xFF1B0F29)];
    }
    if (c.contains('idiom') || c.contains('proverb') || c.contains('culture')) {
      return <Color>[const Color(0xFF52221B), const Color(0xFF2A100C)];
    }
    return <Color>[const Color(0xFF2C2B28), const Color(0xFF16150F)];
  }

  /// The cover for a story as an [ImageProvider], or null when it has none.
  ///
  /// Screens that frame the cover themselves (the library grid, the story of the
  /// day hero) use this so the *resolution order* lives in one place: the story's
  /// own URL first, then the Mandarin Bean artwork bundled with the app. They
  /// keep their own framing and fall back to [topicGradient] when this returns
  /// null.
  static ImageProvider<Object>? resolveProvider(LibraryStory story) {
    // Poems are drawn, not photographed: their bundled artwork is
    // AI-generated and deliberately not shown - the poem cover is composed in
    // code instead, so this returns null to let that design take over.
    if (story.link.startsWith('poetry_') ||
        story.link.startsWith('tang_poetry_')) {
      return null;
    }
    final String? explicit = story.imageUrl;
    if (explicit != null && explicit.isNotEmpty) {
      if (explicit.startsWith('http')) return NetworkImage(explicit);
      return AssetImage(explicit);
    }
    final String? asset = bundledCoverAsset(story.link);
    if (asset == null) return null;
    return AssetImage(asset);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2430) : const Color(0xFFE8E0D2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
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
            children: <Widget>[
              _buildArtwork(context),
// Spine shading: the same 3D book illusion as the catalogue.
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 12,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.black.withValues(alpha: 0.4),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
if (showSourceBadge && story.sourceName.isNotEmpty) ...<Widget>[
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 26,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 8,
                  bottom: 6,
                  child: Text(
                    story.sourceName,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// The story's own artwork, whatever form it arrives in.
  Widget _buildArtwork(BuildContext context) {
    final String? explicit = story.imageUrl;
    if (explicit != null && explicit.isNotEmpty) {
      if (explicit.startsWith('http')) {
        return Image.network(
          explicit,
          fit: BoxFit.cover,
          // A cover that fails to load must not leave a bare grey box: fall back
          // to the topic card, never to a generic landscape.
          errorBuilder: (_, __, ___) => _buildTopicFallback(context),
          loadingBuilder:
              (BuildContext context, Widget child, ImageChunkEvent? progress) =>
                  progress == null ? child : _buildTopicFallback(context),
        );
      }
      return Image.asset(
        explicit,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildBundledOrFallback(context),
      );
    }
    return _buildBundledOrFallback(context);
  }

  /// The Mandarin Bean cover bundled with the app, when the story has one.
  Widget _buildBundledOrFallback(BuildContext context) {
    final String? asset = bundledCoverAsset(story.link);
    if (asset == null) return _buildTopicFallback(context);
    return Image.asset(
      asset,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildTopicFallback(context),
    );
  }

  /// Last resort: a card that at least belongs to the story's subject.
  Widget _buildTopicFallback(BuildContext context) {
    return DecoratedBox(
      key: ValueKey<String>('story-cover-fallback-${story.category}'),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: topicGradient(story.category),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          topicGlyph(story.category),
          style: TextStyle(
            fontSize: height * 0.38,
            height: 1,
            color: const Color(0xFFD4AF37).withValues(alpha: 0.55),
          ),
        ),
      ),
    );
  }
}
