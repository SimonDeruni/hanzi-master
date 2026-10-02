import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/network_notice.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:http/http.dart' as http;

/// Hosts the app's **real** localization delegates and captures the `BuildContext`
/// underneath them, so the notice is asserted against the shipped 14-locale
/// catalogue rather than a stub.
Future<BuildContext> _pumpLocalized(WidgetTester tester, Locale locale) async {
  late BuildContext captured;
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (BuildContext context) {
          captured = context;
          return const Scaffold(body: SizedBox.shrink());
        },
      ),
    ),
  );
  return captured;
}

void main() {
  setUp(() {
    // The offline tone buzzes a refusal on the way in, and `HapticsManager`
    // spaces its beats with `Future.delayed` - which surfaces as a pending
    // timer in a widget test. The haptic is not what is under test here.
    HapticsManager.setEnabled(false);
  });

  tearDown(() {
    HapticsManager.setEnabled(true);
    ZenToast.dismiss();
  });

  group('NetworkNotice.message', () {
    testWidgets('speaks the learner\'s own language, not English',
        (WidgetTester tester) async {
      final BuildContext context = await _pumpLocalized(tester, const Locale('de'));

      // The German catalogue's own sentence: proof the notice is wired to the
      // real translations rather than a hardcoded English string that happens
      // to be right in one locale.
      expect(NetworkNotice.message(context), contains('Keine Internetverbindung'));
    });

    testWidgets('falls back to English when no localizations are in scope',
        (WidgetTester tester) async {
      // `describe`/`message` are called from `catch` blocks, and a bare
      // widget-test harness has no delegate - the notice must not throw there.
      expect(NetworkNotice.messageOf(null), NetworkNotice.englishFallback);
    });
  });

  group('NetworkNotice.describe', () {
    testWidgets('blames the connection only when it is the connection',
        (WidgetTester tester) async {
      final BuildContext context =
          await _pumpLocalized(tester, const Locale('en'));

      expect(
        NetworkNotice.describe(context, Exception('Gemini API Error 500'),
            fallback: 'Could not load this shelf'),
        'Could not load this shelf',
        reason: 'A server-side failure is not the learner\'s wifi',
      );

      expect(
        NetworkNotice.describe(
            context, http.ClientException('Connection refused'),
            fallback: 'Could not load this shelf'),
        contains('No internet connection'),
      );
    });
  });

  group('NetworkNotice.showIfOffline', () {
    testWidgets('stays silent for a failure the network did not cause',
        (WidgetTester tester) async {
      final BuildContext context =
          await _pumpLocalized(tester, const Locale('en'));

      expect(
        NetworkNotice.showIfOffline(context, Exception('Gemini API Error 500')),
        isFalse,
      );
      await tester.pump();
      expect(find.byIcon(Icons.wifi_off_rounded), findsNothing);
    });

    testWidgets('raises the wifi toast for a dead socket',
        (WidgetTester tester) async {
      final BuildContext context =
          await _pumpLocalized(tester, const Locale('en'));

      expect(
        NetworkNotice.showIfOffline(
            context, http.ClientException('Connection refused')),
        isTrue,
      );
      await tester.pump();
      await tester.pump(ZenMotion.swap);

      // The wifi glyph, not the generic alert: a learner should be able to tell
      // "turn your network on" from "that didn't work" at a glance.
      expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
      expect(find.textContaining('No internet connection'), findsOneWidget);

      ZenToast.dismiss();
      await tester.pumpAndSettle();
    });
  });
}
