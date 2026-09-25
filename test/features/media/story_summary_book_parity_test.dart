import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_summary_screen.dart';
import 'package:hanzi_master/features/media/presentation/widgets/story_cover_art.dart';
import 'package:hanzi_master/features/reading/data/repositories/story_repository.dart';
import 'package:hanzi_master/features/reading/presentation/providers/story_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../support/locale_layout_harness.dart';

/// Stand-ins so the controller can be constructed without touching Hive or the
/// network: the screen's loading call is overridden to a no-op.
class _FakeGeminiService extends Fake implements GeminiService {}

/// The controller's constructor loads custom blueprints; nothing else is reached.
class _FakeStoryRepository extends Fake implements StoryRepository {
  @override
  Future<List<StoryBlueprint>> getCustomBlueprints() async =>
      <StoryBlueprint>[];
}

/// Records which loading path the screen chose, and does nothing else.
class _RecordingStoryController extends StoryController {
  _RecordingStoryController(this.calls)
      : super(
          geminiService: _FakeGeminiService(),
          repository: _FakeStoryRepository(),
        );

  final List<String> calls;

  @override
  Future<void> fetchAndParseLocalStory(
      StoryBlueprint blueprint, int hskLevel) async {
    calls.add('local');
  }

  @override
  Future<void> fetchAndParseFirebaseStory(
      StoryBlueprint blueprint, int hskLevel) async {
    calls.add('firebase');
  }

  @override
  Future<void> loadOrGenerateStory(
      StoryBlueprint blueprint, int hskLevel) async {
    calls.add('generate');
  }
}

/// The story the report was about: Mandarin Bean, dumplings and tangyuan.
LibraryStory _dumplings() => const LibraryStory(
      title: 'Dumplings and Tangyuan',
      titleEn: 'Dumplings and Tangyuan',
      sourceName: 'Mandarin Bean',
      link: 'https://mandarinbean.com/dumplings-and-tangyuan/',
      summary: '中国人喜欢吃特别是在重要的节日里有两样东西很多人都会吃那就是饺子和汤圆',
      category: 'Food & Dining',
      sourceType: StorySourceType.json,
      hskLevel: 5,
    );

Widget _host({required Widget child, Locale locale = const Locale('en')}) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}

void main() {
  testWidgets(
      'a Mandarin Bean story is read from the bundled data, not Firestore',
      (tester) async {
    // Regression: these links used to be routed to `fetchAndParseFirebaseStory`,
    // which looks up a Firestore document by the *URL* — so the key words never
    // arrived on the first screen of a Mandarin Bean story.
    final List<String> calls = <String>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          storyControllerProvider
              .overrideWith((Ref ref) => _RecordingStoryController(calls)),
        ],
        child: _host(child: StorySummaryScreen(story: _dumplings())),
      ),
    );
    await tester.pumpAndSettle();

    expect(calls, <String>['local']);
  });

  testWidgets(
      'the first screen shows the story\'s own Mandarin Bean cover, not a generic landscape',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final List<String> calls = <String>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          storyControllerProvider
              .overrideWith((Ref ref) => _RecordingStoryController(calls)),
        ],
        child: _host(child: StorySummaryScreen(story: _dumplings())),
      ),
    );
    await tester.pumpAndSettle();

    // 1. The cover card, composed like a book cover.
    expect(find.byType(StoryCoverArt), findsOneWidget);
    final StoryCoverArt cover =
        tester.widget<StoryCoverArt>(find.byType(StoryCoverArt));
    expect(cover.width, 135);
    expect(cover.height, 190);
    expect(
      (tester.widget<Image>(find.byType(Image).first).image as AssetImage)
          .assetName,
      'assets/images/mandarin_bean/dumplings-and-tangyuan.jpg',
    );
    expect(_mountainsImage(), findsNothing);

    // 2. Title, level, subject and source.
    expect(find.text('HSK 5'), findsOneWidget);
    expect(find.text('Food & Dining'), findsOneWidget);
    expect(find.text('Mandarin Bean'), findsOneWidget);

    // 3. One primary action, in the book screen's button vocabulary: carbon ink
    //    in light mode, and at least 52px tall. (`ElevatedButton.icon` builds a
    //    private subclass, so the matcher has to be a predicate.)
    final Finder cta =
        find.byWidgetPredicate((Widget w) => w is ElevatedButton);
    expect(cta, findsOneWidget);
    final ElevatedButton button = tester.widget<ElevatedButton>(cta);
    expect(
      button.style?.backgroundColor?.resolve(<WidgetState>{}),
      const Color(0xFF1A1A1B),
    );
    expect(tester.getSize(cta).height, greaterThanOrEqualTo(52));

    // 4. The summary and key word sections are ink wells at radius 18, the same
    //    containers the book detail screen uses.
    for (final String section in <String>['Summary', 'Key Words']) {
      final Finder title = find.text(section);
      expect(title, findsOneWidget, reason: section);
      // The nearest Container ancestor is the ink well itself.
      final Finder card =
          find.ancestor(of: title, matching: find.byType(Container)).first;
      final BoxDecoration decoration =
          tester.widget<Container>(card).decoration! as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(18),
          reason: section);
    }
  });

  testWidgets(
      'the redesigned first screen fits the tightest viewport in every locale',
      (tester) async {
    await expectNoOverflowAcrossLocales(
      tester,
      (BuildContext context) {
        final List<String> calls = <String>[];
        return ProviderScope(
          overrides: <Override>[
            storyControllerProvider
                .overrideWith((Ref ref) => _RecordingStoryController(calls)),
          ],
          child: StorySummaryScreen(story: _dumplings()),
        );
      },
      locales: const <String>['de', 'ru', 'th', 'ja'],
    );
  });
}

Finder _mountainsImage() => find.byWidgetPredicate((Widget w) =>
    w is Image &&
    w.image is AssetImage &&
    (w.image as AssetImage).assetName.contains('ai_hub_ink_mountains'));
