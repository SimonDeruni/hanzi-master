import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/media/domain/models/media_briefing.dart';
import 'package:hanzi_master/features/media/domain/models/video_transcript.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_ai_prep_card.dart';
import 'package:hanzi_master/features/media/presentation/widgets/premium_transcript_line.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _InMemoryFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => const [];
}

Widget _wrapWithTestEnvironment({
  required Widget child,
  required ProviderContainer container,
}) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  late ProviderContainer container;

  const mockCard = Flashcard(
    id: 'global_15039',
    hanzi: '力',
    pinyin: 'lì',
    definition: 'power; force; strength',
    englishDefinition: 'power; force; strength',
    hskLevel: 1,
    strokePaths: [],
    modeStats: {},
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'app_locale': 'en',
    });
    prefs = await SharedPreferences.getInstance();
    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        quickLookProvider('力').overrideWith((ref) => Future.value(mockCard)),
        commonWordsProvider('力')
            .overrideWith((ref) => Future.value(const [])),
        flashcardControllerProvider
            .overrideWith(() => _InMemoryFlashcardController()),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  testWidgets(
      'tapping character in PremiumTranscriptLine opens only the floating popover, not bottom sheet',
      (tester) async {
    String? tappedWord;

    final line = TranscriptLine(
      start: Duration.zero,
      duration: const Duration(seconds: 3),
      text: '你好力',
      translation: 'Hello power',
      pinyin: 'nǐ hǎo lì',
    );

    await tester.pumpWidget(
      _wrapWithTestEnvironment(
        container: container,
        child: PremiumTranscriptLine(
          line: line,
          isCurrent: true,
          highlightedCount: 3,
          onReplay: () {},
          onLineTapped: () {},
          onWordTapped: (w) => tappedWord = w,
          showPinyin: true,
          showEnglish: true,
        ),
      ),
    );

    // Find RichText widget rendering the transcript text spans
    final richTextWidgets = tester.widgetList<RichText>(find.byType(RichText));
    RichText? hanziRichText;
    for (final rt in richTextWidgets) {
      if (rt.text is TextSpan) {
        final span = rt.text as TextSpan;
        if (span.children?.any((c) => c is TextSpan && c.text == '力') ?? false) {
          hanziRichText = rt;
          break;
        }
      }
    }
    expect(hanziRichText, isNotNull);

    final rootSpan = hanziRichText!.text as TextSpan;
    final targetSpan = rootSpan.children!.firstWhere(
      (c) => c is TextSpan && c.text == '力',
    ) as TextSpan;

    final recognizer = targetSpan.recognizer as TapGestureRecognizer?;
    expect(recognizer, isNotNull);

    recognizer!.onTapDown?.call(
      TapDownDetails(globalPosition: const Offset(200, 300)),
    );
    recognizer.onTap?.call();
    await tester.pumpAndSettle();

    // Word tapped callback was triggered (to pause video)
    expect(tappedWord, equals('力'));

    // Floating dialog is mounted and contains character definition
    expect(find.text('power; force; strength'), findsOneWidget);

    // Bottom sheet is NOT mounted
    expect(find.byType(GlobalBlurredBottomSheet), findsNothing);
  });

  testWidgets(
      'tapping chip in PremiumAiPrepCard opens only the floating popover, not bottom sheet',
      (tester) async {
    String? tappedWord;

    final briefing = MediaBriefing(
      summary: 'Test summary',
      hardWords: const ['力'],
    );

    await tester.pumpWidget(
      _wrapWithTestEnvironment(
        container: container,
        child: PremiumAiPrepCard(
          briefing: briefing,
          onWordTapped: (w) => tappedWord = w,
        ),
      ),
    );

    final chipFinder = find.text('力');
    expect(chipFinder, findsOneWidget);

    await tester.tap(chipFinder);
    await tester.pumpAndSettle();

    expect(tappedWord, equals('力'));
    expect(find.text('power; force; strength'), findsOneWidget);
    expect(find.byType(GlobalBlurredBottomSheet), findsNothing);
  });
}
