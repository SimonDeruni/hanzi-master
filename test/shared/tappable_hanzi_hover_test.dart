/// Hover quick-look (Part 2b of `docs/IPAD_ADAPTIVE_PLAN.md`): on a pointer device
/// a character can be *peeked* without tapping, and the peek is a non-modal
/// overlay — so the page underneath stays interactive and a phone never sees it.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';

class _InMemoryFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => const <Flashcard>[];
}

Flashcard _card() => const Flashcard(
      id: 'card-你',
      deckId: 'hsk1',
      hanzi: '你',
      pinyin: 'nǐ',
      definition: 'you',
      hskLevel: 1,
      strokePaths: <String>[],
      modeStats: <StudyMode, ReviewStats>{},
    );

ProviderContainer _container() {
  final Flashcard card = _card();
  final ProviderContainer container = ProviderContainer(
    overrides: <Override>[
      quickLookProvider('你').overrideWith((Ref ref) => Future.value(card)),
      commonWordsProvider('你')
          .overrideWith((Ref ref) => Future.value(const <Flashcard>[])),
      flashcardControllerProvider
          .overrideWith(() => _InMemoryFlashcardController()),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

/// A single character, so any hover inside the paragraph maps to offset 0 and the
/// peek target is deterministic.
Future<void> _pumpBench(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: _container(),
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(child: TappableHanziText('你')),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('hovering a character on an iPad peeks without a tap',
      (WidgetTester tester) async {
    await _pumpBench(tester, const Size(1024, 1366));
    expect(find.byType(QuickLookPeekOverlay), findsNothing);

    final TestGesture pointer =
        await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(pointer.removePointer);
    await pointer.addPointer(location: Offset.zero);
    await pointer.moveTo(tester.getCenter(find.byType(TappableHanziText)));

    // Hover intent: the card does not appear on the first hover frame, which is
    // what stops a pointer crossing a sentence from flashing cards.
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(QuickLookPeekOverlay), findsNothing);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(QuickLookPeekOverlay), findsOneWidget);

    // Leaving the text dismisses it after the grace period, so crossing a line
    // break does not flicker.
    await pointer.moveTo(const Offset(4, 4));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.byType(QuickLookPeekOverlay), findsNothing);
  });

  testWidgets('a phone never peeks: tapping stays the only way in',
      (WidgetTester tester) async {
    await _pumpBench(tester, const Size(390, 844));

    final TestGesture pointer =
        await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(pointer.removePointer);
    await pointer.addPointer(location: Offset.zero);
    await pointer.moveTo(tester.getCenter(find.byType(TappableHanziText)));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.byType(QuickLookPeekOverlay), findsNothing);
  });
}
