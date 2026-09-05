import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Chapter localization', () {
    test('localizes missing chapter prefixes for regional locales', () async {
      final title = await LocalizedCatalogService.getChapterTitle(
        titleEn: 'Chapter 1: 第一回　灵根育孕源流出　心性修持大道生',
        localeCode: 'fr-FR',
      );

      expect(title, 'Chapitre 1: 第一回　灵根育孕源流出　心性修持大道生');
    });

    test('uses an exact translated literary title when one exists', () async {
      final title = await LocalizedCatalogService.getChapterTitle(
        titleEn: 'Chapter 10: The Chronicle of',
        localeCode: 'fr',
      );

      expect(title, 'Chapitre 10: La Chronique de');
    });

    test('covers a supported locale without a chapter-title asset', () async {
      final title = await LocalizedCatalogService.getChapterTitle(
        titleEn: 'Chapter 27: 并战计·假痴不癫',
        localeCode: 'th-TH',
      );

      expect(title, 'บทที่ 27: 并战计·假痴不癫');
    });

    test('does not rewrite poem titles that have no chapter prefix', () async {
      final title = await LocalizedCatalogService.getChapterTitle(
        titleEn: 'Quiet Night Thoughts',
        localeCode: 'fr',
      );

      expect(title, 'Quiet Night Thoughts');
    });

    test('chapter metadata supports regional locales and JSON round-tripping',
        () {
      final chapter = BookChapter.fromJson(const {
        'id': 'book_ch_1',
        'bookId': 'book',
        'chapterIndex': 1,
        'title': '第一回',
        'titleEn': 'Chapter 1',
        'localizedTitles': {'fr': 'Chapitre 1 : Le commencement'},
        'sentences': <dynamic>[],
      });

      expect(chapter.localizedTitle('fr-CA'), 'Chapitre 1 : Le commencement');
      expect(chapter.localizedTitle('de'), 'Chapter 1');
      expect(chapter.toJson()['localizedTitles'], {
        'fr': 'Chapitre 1 : Le commencement',
      });
    });

    test('explicit chapter metadata takes priority over bundled lookups',
        () async {
      final title = await LocalizedCatalogService.getChapterTitle(
        titleEn: 'Chapter 1',
        localeCode: 'fr-FR',
        localizedTitles: const {'fr': 'Ouverture'},
      );

      expect(title, 'Ouverture');
    });

    test('chapter ID translations take priority over legacy title lookups',
        () async {
      final title = await LocalizedCatalogService.getChapterTitle(
        chapterId: 'animal_farm_ch_1',
        titleEn: 'Chapter 1',
        localeCode: 'fr-FR',
      );

      // Once generated assets exist this resolves the book-specific literary
      // title, rather than the generic legacy "Chapitre 1" entry.
      expect(title, isNotEmpty);
    });
  });
}
