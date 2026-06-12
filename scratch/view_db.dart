import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase('assets/data/dictionary.db');
  
  var results = await db.rawQuery('SELECT * FROM words LIMIT 5');
  for (var row in results) {
    print(row);
  }
  
  await db.close();
}
