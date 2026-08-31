/// Verifies that all localization keys in the ARB template file (app_en.arb)
/// are present in the generated Dart files (app_localizations.dart and
/// app_localizations_en.dart).
///
/// Run with: dart tools/verify_localization_keys.dart
///
/// Exit code:
///   0 - all keys match
///   1 - some keys are missing or mismatched
library;

import 'dart:convert';
import 'dart:io';

void main() {
  final baseDir = Directory.current.path;
  final arbPath = '$baseDir/lib/l10n/app_en.arb';
  final dartClassPath = '$baseDir/lib/l10n/app_localizations.dart';
  final dartImplPath = '$baseDir/lib/l10n/app_localizations_en.dart';

  final arbFile = File(arbPath);
  final dartClassFile = File(dartClassPath);
  final dartImplFile = File(dartImplPath);

  if (!arbFile.existsSync()) {
    stderr.writeln('ERROR: ARB file not found at $arbPath');
    exit(1);
  }
  if (!dartClassFile.existsSync()) {
    stderr.writeln('ERROR: Dart abstract class not found at $dartClassPath');
    exit(1);
  }
  if (!dartImplFile.existsSync()) {
    stderr.writeln('ERROR: Dart implementation not found at $dartImplPath');
    exit(1);
  }

  // Parse ARB keys (excluding @metadata keys)
  final arbContent = jsonDecode(arbFile.readAsStringSync()) as Map<String, dynamic>;
  final arbKeys = arbContent.keys.where((k) => !k.startsWith('@')).toSet();

  // Parse Dart abstract class getters and methods
  final dartClassContent = dartClassFile.readAsStringSync();
  final dartImplContent = dartImplFile.readAsStringSync();

  // Extract keys from Dart files - match both `String get keyName` and `String keyName(...`
  final dartClassKeys = _extractDartKeys(dartClassContent);
  final dartImplKeys = _extractDartKeys(dartImplContent);

  // Check for missing keys in Dart class
  final missingInClass = arbKeys.difference(dartClassKeys);
  // Check for extra keys in Dart class (unknown)
  final extraInClass = dartClassKeys.difference(arbKeys);
  // Check for missing keys in English implementation
  final missingInEn = arbKeys.difference(dartImplKeys);
  // Check for extra keys in English implementation
  final extraInEn = dartImplKeys.difference(arbKeys);

  int errors = 0;

  if (missingInClass.isNotEmpty) {
    stderr.writeln('ERROR: ${missingInClass.length} key(s) in ARB but missing from abstract class:');
    for (final key in missingInClass..toList()..sort()) {
      stderr.writeln('  - $key');
    }
    errors++;
  } else {
    print('✓ All ${arbKeys.length} ARB keys present in abstract class');
  }

  if (extraInClass.isNotEmpty) {
    print('INFO: ${extraInClass.length} extra key(s) in abstract class not in ARB:');
    for (final key in extraInClass..toList()..sort()) {
      print('  - $key');
    }
  }

  if (missingInEn.isNotEmpty) {
    stderr.writeln('ERROR: ${missingInEn.length} key(s) in ARB but missing from English implementation:');
    for (final key in missingInEn..toList()..sort()) {
      stderr.writeln('  - $key');
    }
    errors++;
  } else {
    print('✓ All ${arbKeys.length} ARB keys present in English implementation');
  }

  if (extraInEn.isNotEmpty) {
    print('INFO: ${extraInEn.length} extra key(s) in English impl not in ARB:');
    for (final key in extraInEn..toList()..sort()) {
      print('  - $key');
    }
  }

  if (errors > 0) {
    stderr.writeln('\nFAILED: $errors class of key mismatch(es) found.');
    stderr.writeln('Run `flutter gen-l10n` to regenerate Dart files from ARB sources.');
    exit(1);
  }

  print('\n✓ All keys verified successfully!');
  exit(0);
}

Set<String> _extractDartKeys(String content) {
  final keys = <String>{};
  final regExp = RegExp(r'String\s+(get\s+)?(\w+)\s*([(]|=>)');
  for (final match in regExp.allMatches(content)) {
    keys.add(match.group(2)!);
  }
  return keys;
}