import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/audiobook_voice_sheet.dart';

import '../support/locale_layout_harness.dart';

/// Records what the picker asks the narrator to speak, and lets a test declare
/// when the line ended.
class _RecordingAudioService extends Fake implements AudioService {
  final StreamController<void> _complete = StreamController<void>.broadcast();
  final List<String> spoken = <String>[];
  final List<String> voiceIds = <String>[];
  int stops = 0;

  @override
  Stream<void> get onPlayerComplete => _complete.stream;

  @override
  Future<bool> playSentence(
    String sentence, {
    String voiceName = 'Fenrir',
    double? speechRate,
    double? playbackRate,
  }) async {
    spoken.add(sentence);
    voiceIds.add(voiceName);
    return true;
  }

  @override
  Future<void> stop() async {
    stops++;
  }

  void finish() => _complete.add(null);

  Future<void> close() => _complete.close();
}

void main() {
  late _RecordingAudioService audio;

  setUp(() => audio = _RecordingAudioService());
  tearDown(() => audio.close());

  Future<void> pumpSheet(
    WidgetTester tester, {
    required List<AudiobookVoiceOption> options,
    String selectedVoiceId = 'Fenrir',
    void Function(AudiobookVoiceOption)? onSelected,
    Future<void> Function(AudiobookVoiceOption)? onPreview,
    Locale locale = const Locale('en'),
    Size size = const Size(390, 844),
  }) async {
    await tester.binding.setSurfaceSize(size);
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          audioServiceProvider.overrideWithValue(audio),
        ],
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: AudiobookVoiceSheet(
              title: 'Choose Audiobook Voice',
              options: options,
              selectedVoiceId: selectedVoiceId,
              onSelected: onSelected ?? (_) {},
              onPreview: onPreview,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<List<AudiobookVoiceOption>> catalogue(
      {bool hasStudioQuota = true}) async {
    final AppLocalizations l10n =
        await AppLocalizations.delegate.load(const Locale('en'));
    return audiobookVoiceOptions(l10n, hasStudioQuota: hasStudioQuota);
  }

  group('AudiobookVoiceSheet', () {
    testWidgets('describes every voice in the listener\'s language only',
        (tester) async {
      // The dialog this replaces printed the provider's own identifiers as
      // subtitles ("zh-CN-XiaoxiaoNeural") and the vendor name in the label
      // ("(Azure)"). Neither may come back.
      await pumpSheet(tester, options: await catalogue());

      for (final String label in <String>[
        'Female, warm',
        'Female, cheerful',
        'Male, upbeat',
        'Male, news-style',
        'Male, sporty',
        'On-device TTS',
      ]) {
        expect(find.text(label), findsOneWidget, reason: label);
      }

      for (final String jargon in <String>[
        'zh-CN',
        'Azure',
        'Neural',
        'Xiaoxiao',
        'Yunxi',
      ]) {
        expect(find.textContaining(jargon), findsNothing, reason: jargon);
      }

      // The audition affordance is explained rather than assumed.
      expect(find.text('Touch ▶ to hear a sample'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow_rounded), findsNWidgets(6));
      // The on-device row is marked as offline-capable, not labelled twice.
      expect(find.byIcon(Icons.offline_bolt_rounded), findsOneWidget);
    });

    testWidgets('auditions a voice and returns to play when the line ends',
        (tester) async {
      await pumpSheet(tester, options: await catalogue());

      await tester.tap(
        find.byKey(const ValueKey<String>('audiobook-voice-preview-Kore')),
      );
      await tester.pump();

      expect(audio.voiceIds, <String>['Kore']);
      expect(audio.spoken.single, AudiobookVoiceSheet.auditionSample);
      expect(find.byIcon(Icons.stop_rounded), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow_rounded), findsNWidgets(5));

      // The engine's completion event resets the row, so the button never has to
      // guess how long a line lasts.
      audio.finish();
      await tester.pump();
      await tester.pump();

      expect(find.byIcon(Icons.stop_rounded), findsNothing);
      expect(find.byIcon(Icons.play_arrow_rounded), findsNWidgets(6));
    });

    testWidgets('tapping the speaking row stops it instead of restarting it',
        (tester) async {
      await pumpSheet(tester, options: await catalogue());

      final Finder preview =
          find.byKey(const ValueKey<String>('audiobook-voice-preview-Kore'));
      await tester.tap(preview);
      await tester.pump();
      await tester.tap(preview);
      await tester.pump();

      expect(audio.stops, 1);
      expect(audio.voiceIds, <String>['Kore']);
    });

    testWidgets('auditioning never changes the stored voice', (tester) async {
      final List<String> selected = <String>[];
      await pumpSheet(
        tester,
        options: await catalogue(),
        onSelected: (AudiobookVoiceOption option) => selected.add(option.id),
      );

      await tester.tap(
        find.byKey(const ValueKey<String>('audiobook-voice-preview-Puck')),
      );
      await tester.pumpAndSettle();

      expect(selected, isEmpty);
      // The check still marks the stored voice, not the audited one.
      expect(
        find.descendant(
          of: find.byKey(const ValueKey<String>('audiobook-voice-Fenrir')),
          matching: find.byIcon(Icons.check_rounded),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const ValueKey<String>('audiobook-voice-Puck')),
          matching: find.byIcon(Icons.check_rounded),
        ),
        findsNothing,
      );
    });

    testWidgets('choosing a voice reports its id', (tester) async {
      final List<String> ids = <String>[];
      await pumpSheet(
        tester,
        options: await catalogue(),
        onSelected: (AudiobookVoiceOption option) => ids.add(option.id),
      );

      await tester.tap(
        find.byKey(const ValueKey<String>('audiobook-voice-Charon')),
      );
      await tester.pumpAndSettle();

      expect(ids, <String>['Charon']);
    });

    testWidgets(
        'a metered voice cannot be auditioned or chosen once the allowance is spent',
        (tester) async {
      final List<String> ids = <String>[];
      await pumpSheet(
        tester,
        options: await catalogue(hasStudioQuota: false),
        onSelected: (AudiobookVoiceOption option) => ids.add(option.id),
      );

      // The situation is explained in words, not in a tooltip.
      expect(
        find.text('Weekly Azure quota reached — switching to local voice'),
        findsOneWidget,
      );
      // Five studio voices are locked; the on-device one is not.
      expect(find.byIcon(Icons.lock_outline), findsNWidgets(5));

      await tester.tap(
        find.byKey(const ValueKey<String>('audiobook-voice-preview-Kore')),
      );
      await tester.tap(
        find.byKey(const ValueKey<String>('audiobook-voice-Kore')),
      );
      await tester.pumpAndSettle();

      expect(audio.spoken, isEmpty);
      expect(ids, isEmpty);

      // The on-device row stays usable, because it costs nothing. It sits below
      // the five locked rows, so it has to be scrolled into view first.
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey<String>('audiobook-voice-local')),
        120,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(
        find.byKey(const ValueKey<String>('audiobook-voice-local')),
      );
      await tester.pumpAndSettle();
      expect(ids, <String>['local']);
    });

    testWidgets(
        'the chosen row wears the app accent and radius, not a Material '
        'colour', (tester) async {
      await pumpSheet(
        tester,
        options: await catalogue(),
        selectedVoiceId: 'Kore',
      );

      final Container selected = tester.widget<Container>(
        find
            .descendant(
              of: find.byKey(const ValueKey<String>('audiobook-voice-Kore')),
              matching: find.byType(Container),
            )
            .first,
      );
      final BoxDecoration decoration = selected.decoration! as BoxDecoration;
      // Cinnabar in light mode, amber in dark: one vocabulary across the app.
      expect((decoration.border! as Border).top.color, AppTheme.accentLight);
      expect(decoration.borderRadius, BorderRadius.circular(18));
    });

    testWidgets('closing the picker never stops audio it did not start',
        (tester) async {
      await pumpSheet(tester, options: await catalogue());

      // No audition happened, so an audiobook playing behind the picker must be
      // left alone.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();

      expect(audio.stops, 0);
    });

    testWidgets(
        'the sheet fits the tightest supported viewport in every locale',
        (tester) async {
      final List<AudiobookVoiceOption> options =
          await catalogue(hasStudioQuota: false);

      await expectNoOverflowAcrossLocales(
        tester,
        (BuildContext context) => ProviderScope(
          overrides: <Override>[
            audioServiceProvider.overrideWithValue(audio),
          ],
          child: AudiobookVoiceSheet(
            title: 'Choose Audiobook Voice',
            options: options,
            selectedVoiceId: 'Fenrir',
            onSelected: (_) {},
          ),
        ),
        locales: const <String>['de', 'ru', 'th', 'hi', 'ja'],
      );
    });
  });
}
