import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Design system contract for the Web Explorer hero card in MediaHubScreen.
///
/// Ensures the card adheres to the "Zen & Ink" aesthetic and the Book / Video screen
/// card vocabulary (warm paper background, hairline borders, calligraphic watermarks,
/// refined badging) instead of dark gradients or neon glows.
void main() {
  late String source;

  setUpAll(() {
    final file = File(
      'lib/features/media/presentation/screens/media_hub_screen.dart',
    );
    expect(file.existsSync(), isTrue,
        reason: 'media_hub_screen.dart must exist');
    source = file.readAsStringSync();
  });

  test('hero card uses AppTheme.cardBgOf(context) rather than dark gradients', () {
    expect(source.contains('AppTheme.cardBgOf(context)'), isTrue,
        reason: 'The card must adapt dynamically to light/dark mode via AppTheme.cardBgOf');
    expect(source.contains('0xFF24252A'), isFalse,
        reason: 'Legacy pitch-black background color must be removed');
    expect(source.contains('0xFF16171A'), isFalse,
        reason: 'Legacy pitch-black gradient stop must be removed');
  });

  test('hero card removes neon amber glow and borders', () {
    expect(source.contains('0xFFFFB300'), isFalse,
        reason: 'Legacy neon amber radial glow must be eliminated');
    expect(source.contains('0xFFFFD54F'), isFalse,
        reason: 'Legacy neon amber borders and icons must be eliminated');
  });

  test('hero card includes subtle calligraphic Hanzi watermark', () {
    expect(source.contains("'网'"), isTrue,
        reason: 'Web Explorer card should feature an elegant calligraphic watermark');
  });

  test('hero card uses tactile micro-haptics on press', () {
    expect(source.contains('HapticsManager.light()'), isTrue,
        reason: 'Card tap must trigger subtle Zen haptic feedback');
  });

  test('hero card uses refined Live Overlay badge with AppTheme.accentFire', () {
    expect(source.contains('AppTheme.accentFire'), isTrue,
        reason: 'Card badge should use standard AppTheme.accentFire styling');
  });
}
