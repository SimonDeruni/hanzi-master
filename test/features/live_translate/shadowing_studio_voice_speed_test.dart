import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('native Azure playback uses the saved voice speed setting', () {
    final source = File(
      'lib/features/live_translate/presentation/screens/shadowing_studio_screen.dart',
    ).readAsStringSync();

    expect(source, contains('ref.read(settingsProvider).speechRate'));
    expect(
      source,
      contains('speechRate: speechRate'),
      reason:
          'Passing an explicit rate also selects the rate-aware Azure cache key.',
    );
  });
}
