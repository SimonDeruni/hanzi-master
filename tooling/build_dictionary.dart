// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  print('=============================================');
  print('🧠 Building the Omni-Dictionary (CC-CEDICT)');
  print('=============================================\n');

  const String url = 'https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz';
  const String gzPath = 'cedict.gz';
  const String txtPath = 'cedict.txt';
  const String outPath = 'assets/data/omni_dictionary.json';

  // 1. Download the Database
  print('📥 Downloading CC-CEDICT database...');
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      File(gzPath).writeAsBytesSync(response.bodyBytes);
      print('✅ Downloaded successfully.');
    } else {
      print('❌ Failed to download. Status: ${response.statusCode}');
      return;
    }
  } catch (e) {
    print('❌ Download error: $e');
    return;
  }

  // 2. Unzip using OS command (faster than Dart libs for this specific task)
  print('📦 Unzipping database...');
  try {
    // Windows specific unzip using tar (built into modern Windows 10/11)
    final result = await Process.run('tar', ['-xf', gzPath]);
    if (result.exitCode != 0) {
       print('❌ Unzip failed. Make sure tar is available on Windows, or use a manual tool.');
       return;
    }
    // Rename the extracted file (usually cedict_ts.u8) to cedict.txt for easier handling
    final extractedFile = Directory.current.listSync().firstWhere(
      (e) => e.path.contains('cedict_ts.u8') || e.path.endsWith('.u8'),
      orElse: () => File(''),
    );
    if (extractedFile.existsSync()) {
      extractedFile.renameSync(txtPath);
    }
    print('✅ Unzipped successfully.');
  } catch (e) {
    print('❌ Unzip error: $e');
    return;
  }

  // 3. Parse and Compress
  print('🔍 Parsing 100,000+ entries (Optimizing for Mobile)...');
  final File txtFile = File(txtPath);
  final lines = txtFile.readAsLinesSync();
  
  final Map<String, dynamic> dictionary = {};
  int entryCount = 0;

  // Regex to parse CC-CEDICT format: Traditional Simplified [pin1 yin1] /def 1/def 2/
  final RegExp regex = RegExp(r'^(\S+)\s+(\S+)\s+\[(.*?)\]\s+/(.*)/$');

  for (var line in lines) {
    if (line.startsWith('#') || line.trim().isEmpty) continue; // Skip comments

    final match = regex.firstMatch(line);
    if (match != null) {
      // final traditional = match.group(1); // We skip traditional for this MVP to save space
      final simplified = match.group(2)!;
      final pinyin = match.group(3)!;
      
      // Clean up the definition string (replace / with semicolons)
      String definition = match.group(4)!.replaceAll('/', '; ');
      
      // To keep the file size tiny (~3MB), we only save the first definition block if it's huge
      if (definition.length > 100) {
         definition = '${definition.substring(0, 97)}...';
      }

      // If a word has multiple pronunciations/meanings, we just take the first one for the MVP
      // to keep the database strictly key-value for maximum speed.
      if (!dictionary.containsKey(simplified)) {
        dictionary[simplified] = {
          'p': pinyin, // Short keys to save JSON bytes
          'd': definition
        };
        entryCount++;
      }
    }
  }

  print('✅ Parsed $entryCount unique simplified words.');

  // 4. Save the Output
  print('💾 Compressing and saving to $outPath...');
  final jsonOutput = jsonEncode(dictionary);
  final outFile = File(outPath);
  outFile.writeAsStringSync(jsonOutput);
  
  // Cleanup temp files
  try {
    File(gzPath).deleteSync();
    File(txtPath).deleteSync();
  } catch (e) {
    // Ignore cleanup errors
  }

  print('🎉 Omni-Dictionary built successfully!');
  print('   File Size: ${(outFile.lengthSync() / (1024 * 1024)).toStringAsFixed(2)} MB');
  print('=============================================');
}