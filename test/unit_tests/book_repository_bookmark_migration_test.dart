import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/data/repositories/book_repository.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory =
        await Directory.systemTemp.createTemp('bookmark-test-');
    Hive.init(temporaryDirectory.path);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final key = String.fromCharCodes(message!.buffer.asUint8List());
      final file = File(key);
      if (!file.existsSync()) return null;
      final bytes = file.readAsBytesSync();
      return ByteData.sublistView(bytes);
    });
  });

  tearDown(() async {
    await Hive.close();
    await temporaryDirectory.delete(recursive: true);
  });

  test('legacy poetry bookmark IDs are migrated and new writes canonicalized',
      () async {
    // A bookmark written in the one-poem-per-book era points at the poem as if it
    // were a book (`tang_poetry_静夜思`). Two migrations have run since: the poem
    // became a chapter of its poet's collection, so the record lands on 李白's
    // **collection** id, not on the bare poem id - which is what keeps the reader
    // opening the right book with the right chapter selected.
    final libraryId = poetryAuthorBookId('李白');
    final box = await Hive.openBox<dynamic>('grand_library_bookmarks_v1');
    final createdAt = DateTime.utc(2026, 1, 1);
    await box.put('legacy', {
      'id': 'legacy',
      'bookId': 'tang_poetry_静夜思',
      'chapterIndex': 1,
      'sentenceIndex': 0,
      'snippetChinese': '床前明月光',
      'snippetEnglish': '',
      'createdAt': createdAt.toIso8601String(),
    });

    final repository = BookRepository();
    await repository.init();
    expect((box.get('legacy') as Map)['bookId'], libraryId);
    expect(repository.getBookmarks(libraryId), hasLength(1));

    await repository.saveBookmark(BookmarkModel(
      id: 'new',
      bookId: 'tang_poetry_静夜思',
      chapterIndex: 1,
      sentenceIndex: 1,
      snippetChinese: '低头思故乡',
      snippetEnglish: '',
      createdAt: createdAt,
    ));
    expect((box.get('new') as Map)['bookId'], libraryId);

    await repository.init();
    expect(repository.getBookmarks('tang_poetry_静夜思'), hasLength(2));
  });
}
