import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/data/services/book_download_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  const bookId = 'test_book';

  test('accepts a non-empty book whose chapters match the requested book', () {
    final chapters = BookDownloadService.decodeAndValidateForTest(
      jsonEncode([
        {
          'id': 'test_book_ch_1',
          'bookId': bookId,
          'chapterIndex': 1,
          'title': '第一章',
          'titleEn': 'Chapter 1',
          'sentences': [
            {'chinese': '你好', 'pinyin': 'nǐ hǎo', 'english': 'Hello'}
          ],
        }
      ]),
      bookId,
    );

    expect(chapters, hasLength(1));
    expect(chapters.single.sentences.single.chinese, '你好');
  });

  test('rejects content belonging to another book', () {
    expect(
      () => BookDownloadService.decodeAndValidateForTest(
        '[{"id":"other_ch_1","bookId":"other","chapterIndex":1,'
        '"title":"Chapter","titleEn":"Chapter","sentences":[{"chinese":"x"}]}]',
        bookId,
      ),
      throwsFormatException,
    );
  });

  test('rejects empty chapter content', () {
    expect(
      () => BookDownloadService.decodeAndValidateForTest('[]', bookId),
      throwsFormatException,
    );
  });

  test('downloads, loads, and removes a book', () async {
    final directory = await Directory.systemTemp.createTemp('book-download-');
    final payload = jsonEncode([
      {
        'id': 'test_book_ch_1',
        'bookId': bookId,
        'chapterIndex': 1,
        'title': '第一章',
        'titleEn': 'Chapter 1',
        'sentences': [
          {'chinese': '你好', 'pinyin': 'nǐ hǎo', 'english': 'Hello'}
        ],
      }
    ]);
    final service = BookDownloadService(
      client: MockClient((request) async {
        expect(request.url.toString(), 'https://books.example/test_book.json');
        // `http.Response` encodes with latin1 unless a charset is declared, and
        // this payload is Chinese - so state the encoding the real CDN serves.
        return http.Response(
          payload,
          200,
          headers: const {'content-type': 'application/json; charset=utf-8'},
        );
      }),
      supportDirectoryProvider: () async => directory,
      baseUrl: 'https://books.example/',
    );

    try {
      expect(await service.isDownloaded(bookId), isFalse);
      await service.download(bookId);
      expect(await service.isDownloaded(bookId), isTrue);
      expect((await service.load(bookId)).single.bookId, bookId);

      await service.remove(bookId);
      expect(await service.isDownloaded(bookId), isFalse);
      await expectLater(service.load(bookId), throwsA(isA<StateError>()));
    } finally {
      await directory.delete(recursive: true);
    }
  });
}
