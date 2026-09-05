import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/book_model.dart';

typedef BookDirectoryProvider = Future<Directory> Function();

class BookDownloadService {
  static const String _configuredBaseUrl = String.fromEnvironment(
    'BOOK_CONTENT_BASE_URL',
    defaultValue: 'https://hanzi-master-books.web.app',
  );

  final http.Client _client;
  final BookDirectoryProvider _supportDirectoryProvider;
  final String baseUrl;

  BookDownloadService({
    http.Client? client,
    BookDirectoryProvider? supportDirectoryProvider,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _supportDirectoryProvider =
            supportDirectoryProvider ?? getApplicationSupportDirectory,
        baseUrl =
            (baseUrl ?? _configuredBaseUrl).replaceAll(RegExp(r'/+$'), '');

  Future<File> _bookFile(String bookId) async {
    final safeBookId = _validateBookId(bookId);
    final supportDirectory = await _supportDirectoryProvider();
    return File(path.join(
        supportDirectory.path, 'downloaded_books', '$safeBookId.json'));
  }

  Future<bool> isDownloaded(String bookId) async {
    final file = await _bookFile(bookId);
    if (!await file.exists()) return false;
    try {
      _decodeAndValidate(await file.readAsString(), bookId);
      return true;
    } catch (_) {
      await file.delete().catchError((_) => file);
      return false;
    }
  }

  Future<List<BookChapter>> load(String bookId) async {
    final file = await _bookFile(bookId);
    if (!await file.exists()) {
      throw StateError('Book has not been downloaded.');
    }
    return _decodeAndValidate(await file.readAsString(), bookId);
  }

  Future<void> download(
    String bookId, {
    void Function(double progress)? onProgress,
  }) async {
    final safeBookId = _validateBookId(bookId);
    final request = http.Request('GET', Uri.parse('$baseUrl/$safeBookId.json'));
    final response = await _client.send(request);
    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(
        'Download failed (HTTP ${response.statusCode}).',
        uri: request.url,
      );
    }

    final file = await _bookFile(safeBookId);
    await file.parent.create(recursive: true);
    final temporaryFile = File('${file.path}.download');
    final sink = temporaryFile.openWrite();
    var received = 0;
    try {
      await for (final chunk in response.stream) {
        sink.add(chunk);
        received += chunk.length;
        if (response.contentLength case final total? when total > 0) {
          onProgress?.call((received / total).clamp(0, 1));
        }
      }
      await sink.flush();
      await sink.close();
      _decodeAndValidate(await temporaryFile.readAsString(), safeBookId);
      if (await file.exists()) await file.delete();
      await temporaryFile.rename(file.path);
      onProgress?.call(1);
    } catch (_) {
      await sink.close().catchError((_) {});
      if (await temporaryFile.exists()) await temporaryFile.delete();
      rethrow;
    }
  }

  Future<void> remove(String bookId) async {
    final file = await _bookFile(bookId);
    if (await file.exists()) await file.delete();
    final temporaryFile = File('${file.path}.download');
    if (await temporaryFile.exists()) await temporaryFile.delete();
  }

  static List<BookChapter> decodeAndValidateForTest(
    String jsonString,
    String bookId,
  ) =>
      _decodeAndValidate(jsonString, bookId);

  static List<BookChapter> _decodeAndValidate(
    String jsonString,
    String bookId,
  ) {
    final decoded = jsonDecode(jsonString);
    if (decoded is! List || decoded.isEmpty) {
      throw const FormatException('Book file contains no chapters.');
    }
    final chapters = decoded
        .map((item) => BookChapter.fromJson(
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>)))
        .toList();
    for (final chapter in chapters) {
      if (chapter.bookId != bookId ||
          chapter.id.isEmpty ||
          chapter.chapterIndex < 1 ||
          chapter.sentences.isEmpty) {
        throw const FormatException('Book file has invalid chapter data.');
      }
    }
    return chapters;
  }

  static String _validateBookId(String bookId) {
    if (!RegExp(r'^[a-z0-9_]+$').hasMatch(bookId)) {
      throw ArgumentError.value(bookId, 'bookId', 'Invalid book identifier');
    }
    return bookId;
  }
}
