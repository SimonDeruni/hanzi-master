import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/media/presentation/widgets/story_cover_art.dart';

LibraryStory _story({
  required String link,
  String? imageUrl,
  String category = 'Food & Dining',
  String title = 'Dumplings and Tangyuan',
}) {
  return LibraryStory(
    title: title,
    titleEn: title,
    sourceName: 'Mandarin Bean',
    link: link,
    imageUrl: imageUrl,
    summary: '中国人喜欢吃特别是在重要的节日里',
    category: category,
    sourceType: StorySourceType.json,
    hskLevel: 5,
  );
}

void main() {
  group('StoryCoverArt cover resolution', () {
    test('derives the bundled Mandarin Bean cover from the article slug', () {
      // 134 of the 150 bundled stories ship their own artwork; the data never
      // referenced it, so every story showed the same ink-wash mountains.
      expect(
        StoryCoverArt.bundledCoverAsset(
            'https://mandarinbean.com/dumplings-and-tangyuan/'),
        'assets/images/mandarin_bean/dumplings-and-tangyuan.jpg',
      );
      expect(
        StoryCoverArt.bundledCoverAsset(
            'https://mandarinbean.com/airport-1-pick-up'),
        'assets/images/mandarin_bean/airport-1-pick-up.jpg',
      );
      // Case is normalised, because the files are lower-case.
      expect(
        StoryCoverArt.bundledCoverAsset(
            'https://mandarinbean.com/Autumn-Outing/'),
        'assets/images/mandarin_bean/autumn-outing.jpg',
      );
    });

    test('returns null for stories that are not articles', () {
      for (final String link in <String>[
        'local_story_1',
        'tang_poetry_静夜思',
        'custom_1730000000000',
        '',
      ]) {
        expect(StoryCoverArt.bundledCoverAsset(link), isNull, reason: link);
      }
    });

    test('the story\'s own image wins, then the bundled cover', () {
      final LibraryStory withUrl = _story(
        link: 'https://mandarinbean.com/dumplings-and-tangyuan/',
        imageUrl: 'https://cdn.example.com/cover.jpg',
      );
      expect(
        (StoryCoverArt.resolveProvider(withUrl)! as NetworkImage).url,
        'https://cdn.example.com/cover.jpg',
      );

      final LibraryStory bundled =
          _story(link: 'https://mandarinbean.com/dumplings-and-tangyuan/');
      expect(
        ((StoryCoverArt.resolveProvider(bundled)!) as AssetImage).assetName,
        'assets/images/mandarin_bean/dumplings-and-tangyuan.jpg',
      );

      final LibraryStory bare = _story(link: 'custom_1730000000000');
      expect(StoryCoverArt.resolveProvider(bare), isNull);
    });

    test('the last-resort art is keyed to the story\'s subject', () {
      // A food story must never carry a mountain range.
      expect(StoryCoverArt.topicGlyph('Food & Dining'), '食');
      expect(StoryCoverArt.topicGlyph('History'), '史');
      expect(StoryCoverArt.topicGlyph('Science & Technology'), '科');
      expect(StoryCoverArt.topicGlyph('Contemporary Stories'), '书');

      // …and its hues differ from a history story's.
      expect(
        StoryCoverArt.topicGradient('Food & Dining'),
        isNot(StoryCoverArt.topicGradient('History')),
      );
    });

    testWidgets('the cover card shows the bundled artwork, never the mountains',
        (tester) async {
      final LibraryStory dumplings =
          _story(link: 'https://mandarinbean.com/dumplings-and-tangyuan/');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(child: StoryCoverArt(story: dumplings)),
          ),
        ),
      );
      await tester.pump();

      final Image cover = tester.widget<Image>(find.byType(Image).first);
      expect(
        (cover.image as AssetImage).assetName,
        'assets/images/mandarin_bean/dumplings-and-tangyuan.jpg',
      );
      expect(find.text('Mandarin Bean'), findsOneWidget);
      // The generic landscape is gone for good.
      expect(
        find.byWidgetPredicate((Widget w) =>
            w is Image &&
            w.image is AssetImage &&
            (w.image as AssetImage).assetName.contains('ai_hub_ink_mountains')),
        findsNothing,
      );
    });

    testWidgets('a story with no artwork falls back to its own subject card',
        (tester) async {
      final LibraryStory orphan = _story(
        link: 'custom_1730000000000',
        category: 'Food & Dining',
        title: 'Handmade Dumplings',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(child: StoryCoverArt(story: orphan)),
          ),
        ),
      );
      await tester.pump();

      expect(
        find.byKey(
            const ValueKey<String>('story-cover-fallback-Food & Dining')),
        findsOneWidget,
      );
      expect(find.text('食'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });
  });
}
