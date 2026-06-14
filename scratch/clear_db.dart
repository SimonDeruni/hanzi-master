import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  final path = Directory.current.path + '/.dart_tool/sqflite'; // wait, hive is usually in getApplicationDocumentsDirectory but for windows we use getApplicationSupportDirectory or we can just delete the hive files in AppData.
}
