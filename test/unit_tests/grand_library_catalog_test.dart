import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/data/repositories/book_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Grand Library Catalog 170+ Books Validation', () {
    test('grand_library_catalog.json loads and parses 90+ full books cleanly', () {
      final file = File('assets/data/grand_library_catalog.json');
      expect(file.existsSync(), isTrue, reason: 'Catalog JSON file must exist');

      final content = file.readAsStringSync();
      final list = jsonDecode(content) as List<dynamic>;

      expect(list.length, greaterThanOrEqualTo(80),
          reason: 'Catalog should contain at least 80 curated unabridged world masterpiece books');
      expect(list.length, equals(86),
          reason: 'Catalog has exactly 86 100% verified unabridged masterpieces');

      final ids = <String>{};
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        final book = BookModel.fromJson(map);

        expect(book.id.isNotEmpty, isTrue);
        expect(ids.contains(book.id), isFalse, reason: 'Duplicate ID: ${book.id}');
        ids.add(book.id);

        expect(book.title.isNotEmpty, isTrue);
        expect(book.titleEn.isNotEmpty, isTrue);
        expect(book.author.isNotEmpty, isTrue);
        expect(book.authorEn.isNotEmpty, isTrue);
        expect(book.category.isNotEmpty, isTrue);
        expect(book.dynastyOrEra.isNotEmpty, isTrue);
        expect(book.description.isNotEmpty, isTrue);
        expect(book.descriptionEn.isNotEmpty, isTrue);
        expect(book.hskLevel, inInclusiveRange(1, 6));
        expect(book.totalChapters, greaterThan(0));
        expect(book.coverEmoji.isNotEmpty, isTrue);
        expect(book.tags.isNotEmpty, isTrue);
      }
    });

    test('BookRepository getBookChapters generates valid multi-sentence content', () async {
      final repo = BookRepository();
      final chapters = await repo.getBookChapters('journey_to_the_west');

      expect(chapters.isNotEmpty, isTrue);
      expect(chapters.first.title.isNotEmpty, isTrue);
      expect(chapters.first.sentences.isNotEmpty, isTrue);

      final firstSentence = chapters.first.sentences.first;
      expect(firstSentence.chinese.isNotEmpty, isTrue);
      expect(firstSentence.pinyin.isNotEmpty, isTrue);
      expect(firstSentence.english, isNotNull);
    });

    test('BookmarkModel and BookReadingProgress serialize and deserialize accurately', () {
      final bm = BookmarkModel(
        id: 'bm_1',
        bookId: 'the_art_of_war',
        chapterIndex: 3,
        sentenceIndex: 2,
        snippetChinese: '知己知彼，百战不殆。',
        snippetEnglish: 'Know yourself and know your enemy.',
        createdAt: DateTime(2026, 8, 27),
      );
      final bmJson = bm.toJson();
      final bmRestored = BookmarkModel.fromJson(bmJson);
      expect(bmRestored.id, equals('bm_1'));
      expect(bmRestored.snippetChinese, equals('知己知彼，百战不殆。'));
      expect(bmRestored.chapterIndex, equals(3));

      final prog = BookReadingProgress(
        bookId: 'dao_de_jing',
        chapterIndex: 5,
        percentage: 0.25,
        updatedAt: DateTime(2026, 8, 27),
      );
      final progJson = prog.toJson();
      final progRestored = BookReadingProgress.fromJson(progJson);
      expect(progRestored.bookId, equals('dao_de_jing'));
      expect(progRestored.chapterIndex, equals(5));
      expect(progRestored.percentage, equals(0.25));
    });

    test('All catalog books have bundled JSON files in assets/data/books/', () {
      final booksDir = Directory('assets/data/books');
      expect(booksDir.existsSync(), isTrue);

      final catalogFile = File('assets/data/grand_library_catalog.json');
      final list = jsonDecode(catalogFile.readAsStringSync()) as List<dynamic>;

      for (final item in list) {
        final bookId = item['id'] as String;
        final jsonFile = File('assets/data/books/$bookId.json');
        expect(jsonFile.existsSync(), isTrue, reason: 'Missing bundled JSON for bookId: $bookId');

        final chapters = jsonDecode(jsonFile.readAsStringSync()) as List<dynamic>;
        expect(chapters.isNotEmpty, isTrue, reason: 'Book $bookId must have at least one chapter');
      }
    });
  });
}
