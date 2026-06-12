import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/flashcard.dart';

class GlobalDictionaryRepository {
  Database? _db;

  Future<void> init() async {
    if (_db != null) return;

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbDir = await getApplicationSupportDirectory();
    final dbPath = join(dbDir.path, "dictionary.db");

    // Copy from assets if it doesn't exist
    if (!await File(dbPath).exists()) {
      try {
        final data = await rootBundle.load("assets/data/dictionary.db");
        final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(dbPath).writeAsBytes(bytes, flush: true);
      } catch (e) {
        throw Exception("Failed to load global dictionary: $e");
      }
    }

    _db = await databaseFactory.openDatabase(dbPath);
  }

  Future<Either<String, List<Flashcard>>> search(String query) async {
    if (_db == null) return const Left("Global Dictionary not initialized");
    if (query.trim().isEmpty) return const Right([]);

    final q = query.trim().toLowerCase();
    
    // Check if it's pinyin (only ascii characters)
    final isPinyin = RegExp(r'^[a-z\s]+$').hasMatch(q);
    
    // Check if it's hanzi
    final isHanzi = RegExp(r'[\u4e00-\u9fa5]').hasMatch(q);

    String sqlQuery;
    List<dynamic> args;

    if (isPinyin) {
      final pinyinSearch = q.replaceAll(' ', '');
      sqlQuery = 'SELECT * FROM words WHERE pinyin_no_tones LIKE ? LIMIT 50';
      args = ['$pinyinSearch%'];
    } else if (isHanzi) {
      sqlQuery = 'SELECT * FROM words WHERE simplified LIKE ? OR traditional LIKE ? LIMIT 50';
      args = ['%$q%', '%$q%'];
    } else {
      // Assume English definition search
      sqlQuery = 'SELECT * FROM words WHERE definition LIKE ? LIMIT 50';
      args = ['%$q%'];
    }

    try {
      final results = await _db!.rawQuery(sqlQuery, args);
      
      final List<Flashcard> cards = results.map<Flashcard>((row) {
        return Flashcard(
          id: 'global_${row['id']}',
          hanzi: row['simplified'] as String,
          pinyin: row['pinyin'] as String,
          definition: row['definition'] as String,
          hskLevel: 0,
          strokePaths: const [],
          nextReviewDate: DateTime.now(),
          interval: 0,
          easeFactor: 2.5,
          streak: 0,
        );
      }).toList();

      return Right(cards);
    } catch (e) {
      return Left("Search failed: $e");
    }
  }
}
