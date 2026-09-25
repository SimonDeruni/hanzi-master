import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/features/media/domain/models/video_transcript.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_transcript_line.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_video_top_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

Widget _buildLocalizedWidget({
  required Widget child,
  Locale locale = const Locale('fr'),
}) {
  return ProviderScope(
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SingleChildScrollView(child: child),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Subtitle Localization & Target Language Resolution', () {
    test('resolves correct target language name for locales', () {
      expect(translationLanguageForLocale('fr'), 'French');
      expect(translationLanguageForLocale('de'), 'German');
      expect(translationLanguageForLocale('es'), 'Spanish');
      expect(translationLanguageForLocale('it'), 'Italian');
      expect(translationLanguageForLocale('ja'), 'Japanese');
      expect(translationLanguageForLocale('en'), 'English');
    });

    testWidgets('PremiumTranscriptLine displays localized French translation',
        (tester) async {
      final line = TranscriptLine(
        start: Duration.zero,
        duration: const Duration(seconds: 3),
        text: '今年，日元再次大跌。',
        pinyin: 'jīn nián, rì yuán zài cì dà diē.',
        translation: 'Cette année, le yen japonais a encore chuté.',
      );

      await tester.pumpWidget(
        _buildLocalizedWidget(
          locale: const Locale('fr'),
          child: PremiumTranscriptLine(
            line: line,
            isCurrent: true,
            highlightedCount: 5,
            onReplay: () {},
            onWordTapped: (_) {},
            showEnglish: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Cette année, le yen japonais a encore chuté.'),
        findsOneWidget,
      );
    });

    testWidgets(
        'PremiumTranscriptLine renders localized translating placeholder in French',
        (tester) async {
      final line = TranscriptLine(
        start: Duration.zero,
        duration: const Duration(seconds: 3),
        text: '今年，日元再次大跌。',
        pinyin: 'jīn nián, rì yuán zài cì dà diē.',
        translation: null,
      );

      await tester.pumpWidget(
        _buildLocalizedWidget(
          locale: const Locale('fr'),
          child: PremiumTranscriptLine(
            line: line,
            isCurrent: false,
            highlightedCount: 0,
            onReplay: () {},
            onWordTapped: (_) {},
            showEnglish: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('[ Traduction... ]'), findsOneWidget);
    });

    testWidgets(
        'PremiumTranscriptLine renders localized translating placeholder in English',
        (tester) async {
      final line = TranscriptLine(
        start: Duration.zero,
        duration: const Duration(seconds: 3),
        text: '今年，日元再次大跌。',
        pinyin: 'jīn nián, rì yuán zài cì dà diē.',
        translation: null,
      );

      await tester.pumpWidget(
        _buildLocalizedWidget(
          locale: const Locale('en'),
          child: PremiumTranscriptLine(
            line: line,
            isCurrent: false,
            highlightedCount: 0,
            onReplay: () {},
            onWordTapped: (_) {},
            showEnglish: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('[ Translating... ]'), findsOneWidget);
    });

    testWidgets(
        'PremiumVideoTopBar displays localized showTranslation in French menu',
        (tester) async {
      await tester.pumpWidget(
        _buildLocalizedWidget(
          locale: const Locale('fr'),
          child: PremiumVideoTopBar(
            title: 'Test Video',
            onExitFullscreen: () {},
            showHanzi: true,
            showPinyin: true,
            showEnglish: true,
            onToggleHanzi: (_) {},
            onTogglePinyin: (_) {},
            onToggleEnglish: (_) {},
            playbackRate: 1.0,
            onSpeedChanged: (_) {},
            subtitleBgOpacity: 0.4,
            onOpacityChanged: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open CC menu
      await tester.tap(find.byIcon(Icons.closed_caption));
      await tester.pumpAndSettle();

      expect(find.text('Afficher la traduction'), findsOneWidget);
      expect(find.text("Afficher l'anglais"), findsNothing);
    });
  });
}
