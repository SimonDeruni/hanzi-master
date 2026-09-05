import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';

void main() {
  group('Book catalog localization', () {
    test('uses localized metadata with regional-locale and English fallbacks',
        () {
      const book = BookModel(
        id: 'journey_to_the_west',
        title: '西游记',
        titleEn: 'Journey to the West',
        localizedTitles: {'fr': "Voyage vers l'Ouest"},
        author: '吴承恩',
        authorEn: "Wu Cheng'en",
        category: 'Chinese Epics',
        description: 'Description',
        descriptionEn: 'Description',
        dynastyOrEra: 'Ming Dynasty',
        hskLevel: 4,
        totalChapters: 100,
        coverEmoji: '🐒',
        tags: ['Mythology'],
      );

      expect(book.localizedTitle('fr-FR'), "Voyage vers l'Ouest");
      expect(book.localizedTitle('de'), 'Journey to the West');
      expect(book.localizedAuthor('fr'), "Wu Cheng'en");
    });

    test('localized metadata survives JSON parsing and serialization', () {
      final book = BookModel.fromJson(const {
        'id': 'romance_of_three_kingdoms',
        'title': '三国演义',
        'titleEn': 'Romance of the Three Kingdoms',
        'localizedTitles': {'fr': 'Le Roman des Trois Royaumes'},
        'author': '罗贯中',
        'authorEn': 'Luo Guanzhong',
        'localizedAuthors': {'fr': 'Luo Guanzhong'},
        'category': 'Chinese Epics',
        'description': 'Description',
        'descriptionEn': 'Description',
        'dynastyOrEra': 'Ming Dynasty',
        'hskLevel': 5,
        'totalChapters': 120,
        'coverEmoji': '⚔️',
        'tags': ['History'],
      });

      expect(book.localizedTitle('fr'), 'Le Roman des Trois Royaumes');
      expect(book.toJson()['localizedTitles'], {
        'fr': 'Le Roman des Trois Royaumes',
      });
      expect(book.toJson()['localizedAuthors'], {'fr': 'Luo Guanzhong'});
    });

    test('reported classics include French catalog titles', () {
      final catalog = jsonDecode(
        File('assets/data/grand_library_catalog.json').readAsStringSync(),
      ) as List<dynamic>;
      final books = {
        for (final entry in catalog)
          (entry as Map<String, dynamic>)['id'] as String:
              BookModel.fromJson(entry),
      };

      expect(
        books['journey_to_the_west']!.localizedTitle('fr'),
        "Voyage vers l'Ouest",
      );
      expect(
        books['romance_of_three_kingdoms']!.localizedTitle('fr'),
        'Le Roman des Trois Royaumes',
      );
    });

    test('reported static English labels are not hard-coded in the screen', () {
      final source = File(
        'lib/features/reading/presentation/screens/book_catalog_screen.dart',
      ).readAsStringSync();

      expect(
          source, isNot(contains('Search 96 full novels, authors, epics...')));
      expect(source, isNot(contains("'Continue Reading'")));
      expect(source, isNot(contains('Books & Audiobooks')));
      expect(source, isNot(contains("'Ch. \${item.progress.chapterIndex}'")));
      expect(source, contains('item.book.title,'));
      expect(source, contains('item.book.localizedTitle(localeCode),'));
    });
  });
}
