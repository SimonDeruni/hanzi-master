import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Locales whose translations expand a label the most against English.
///
/// Measured from `lib/l10n/app_*.arb` (p95 expansion versus English):
/// Russian 2.08x, Vietnamese 2.08x, Thai 2.00x, Italian 2.00x,
/// Portuguese 1.94x, French 1.93x, Spanish 1.90x, German 1.86x,
/// Indonesian 1.86x, Arabic 1.80x, Hindi 1.79x.
/// Japanese and Korean *shrink* in character count but use full-width glyphs,
/// so they are kept in the matrix as well.
const List<String> kExpansionLocales = <String>[
  'de',
  'fr',
  'ru',
  'vi',
  'th',
  'it',
  'es',
  'pt',
  'ar',
  'hi',
  'ja',
  'ko',
];

/// The tightest viewports we still support (320x568 = iPhone SE 1st gen).
const List<Size> kTightViewports = <Size>[
  Size(390, 844),
  Size(320, 568),
];

/// Text scales to survive: 1.0 = default, 2.0 = largest accessibility setting.
const List<double> kTextScales = <double>[1.0, 2.0];

/// Fails the test when the framework reported a layout overflow.
///
/// This intentionally replaces the older pattern of calling `takeException()`
/// and ignoring "RenderFlex overflowed": a clipped or out-of-bounds label is a
/// real user-visible defect in at least one supported language, so it must fail
/// the build rather than be swallowed.
void expectNoOverflow(WidgetTester tester, {String? reason}) {
  final Object? error = tester.takeException();
  if (error == null) {
    return;
  }
  final String description = error.toString();
  final bool isOverflow = description.contains('overflowed') ||
      description.contains('RenderFlex') ||
      description.contains('RenderBox overflow');
  if (isOverflow) {
    fail('Layout overflow${reason == null ? '' : ' ($reason)'}:\n$description');
  }
  throw error; // Any unrelated framework error is surfaced untouched.
}

/// Pumps [builder] inside a fully localized app with a controlled size,
/// locale and text scale, then asserts that nothing overflowed.
Future<void> pumpLocalizedScreen(
  WidgetTester tester, {
  required WidgetBuilder builder,
  required String locale,
  Size size = const Size(390, 844),
  double textScale = 1.0,
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(locale),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // Forcing min == max pins the scale so the matrix is deterministic.
      builder: (BuildContext context, Widget? child) =>
          MediaQuery.withClampedTextScaling(
        minScaleFactor: textScale,
        maxScaleFactor: textScale,
        child: child!,
      ),
      // Builder gives the widget a context that already has AppLocalizations.
      home: Builder(builder: builder),
    ),
  );
  await tester.pumpAndSettle();
}

/// Pumps [builder] across the worst-case locale / text scale / viewport matrix.
///
/// Kept deliberately small (20 pumps by default) so it stays fast enough to run
/// on every change while still covering the languages that break layouts.
Future<void> expectNoOverflowAcrossLocales(
  WidgetTester tester,
  WidgetBuilder builder, {
  List<String> locales = const <String>['de', 'fr', 'ru', 'vi', 'th'],
  List<Size> viewports = kTightViewports,
  List<double> textScales = kTextScales,
}) async {
  for (final String locale in locales) {
    for (final Size viewport in viewports) {
      for (final double scale in textScales) {
        await pumpLocalizedScreen(
          tester,
          builder: builder,
          locale: locale,
          size: viewport,
          textScale: scale,
        );
        expectNoOverflow(
          tester,
          reason: '$locale @ ${viewport.width.toInt()}x'
              '${viewport.height.toInt()} at ${scale}x text scale',
        );
      }
    }
  }
}
