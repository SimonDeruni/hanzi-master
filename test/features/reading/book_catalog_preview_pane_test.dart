/// The wide-window book pane in the reading room (F4 of
/// `docs/IPAD_ADAPTIVE_PLAN.md`).
///
/// At ≥840dp a cover opens `BookDetailScreen` *beside* the shelf instead of over
/// it. Because the pane is not a route it renders no back button — and that left
/// it with no dismissal of any kind, since the catalogue only ever assigned
/// `_previewBook`. Reported 2026-09-29: "No way to close the right Thing".
/// These tests pin the way out, and that the phone path is untouched.
@Tags(<String>['ipad-sweep'])
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/reading/data/repositories/book_repository.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_collection.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_catalog_screen.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_detail_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../support/locale_layout_harness.dart';

/// Every reading provider the catalogue and the detail pane touch is fed by
/// `bookRepositoryProvider`, and the real one wants Hive boxes and an
/// application-support directory — neither exists in a widget test. Overriding
/// the repository rather than the providers keeps the *real* providers in play,
/// including `BookDownloadController`'s constructor, which refreshes on creation.
class _FakeBookRepository extends BookRepository {
  @override
  Future<void> init() async {}

  @override
  Future<bool> isBookDownloaded(String bookId) async => false;

  @override
  Future<List<BookChapter>> getBookChapters(String bookId) async =>
      const <BookChapter>[];

  @override
  int getReadingProgress(String bookId) => 1;
}

const BookModel _camellias = BookModel(
  id: 'la_dame_aux_camelias',
  title: '茶花女',
  titleEn: 'The Lady of the Camellias',
  localizedTitles: <String, String>{'fr': 'La Dame aux camélias'},
  author: '小仲马',
  authorEn: 'Alexandre Dumas fils',
  category: 'French Classics',
  description: 'Description',
  descriptionEn: 'Description',
  dynastyOrEra: '19th Century',
  hskLevel: 5,
  totalChapters: 15,
  coverEmoji: '🌸',
  tags: <String>['Drama'],
);

const BookModel _musketeers = BookModel(
  id: 'les_trois_mousquetaires',
  title: '三个火枪手',
  titleEn: 'The Three Musketeers',
  localizedTitles: <String, String>{'fr': 'Les Trois Mousquetaires'},
  author: '大仲马',
  authorEn: 'Alexandre Dumas',
  category: 'French Classics',
  description: 'Description',
  descriptionEn: 'Description',
  dynastyOrEra: '19th Century',
  hskLevel: 5,
  totalChapters: 15,
  coverEmoji: '⚔️',
  tags: <String>['Adventure'],
);

/// The French UI is the reported one, and `GlobalMaterialLocalizations` is what
/// labels the close affordance, so the locale matters to the assertions.
Widget _host(String locale) => ProviderScope(
      overrides: <Override>[
        bookRepositoryProvider.overrideWithValue(_FakeBookRepository()),
        bookCatalogProvider
            .overrideWith((ref) => const <BookModel>[_camellias, _musketeers]),
        microReadsProvider.overrideWith((ref) => const <LibraryStory>[]),
        poetryCollectionsProvider
            .overrideWith((ref) => const <PoetryCollection>[]),
        inProgressBooksProvider
            .overrideWith((ref) => const <InProgressBookItem>[]),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        locale: Locale(locale),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        // No app bar: its own back arrow would be a second
        // `Icons.arrow_back_ios_new` on screen and make the phone assertion
        // below ambiguous.
        home: const BookCatalogScreen(showBackButton: false),
      ),
    );

/// `pumpAndSettle` is safe here: nothing in the catalogue or the pane animates
/// forever, and both futures resolve on the first frames.
Future<void> _pumpCatalog(
  WidgetTester tester, {
  required Size size,
  String locale = 'fr',
}) async {
  // The view API, not `binding.setSurfaceSize` (see locale_layout_harness.dart).
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(_host(locale));
  await tester.pumpAndSettle();
}

Finder get _closeButton => find.ancestor(
    of: find.byIcon(Icons.close), matching: find.byType(IconButton));

void main() {
  testWidgets('an iPad opens the detail beside the shelf and can close it again',
      (WidgetTester tester) async {
    await _pumpCatalog(tester, size: const Size(1366, 1024));

    expect(find.byType(BookDetailScreen), findsNothing);
    expect(_closeButton, findsNothing);

    await tester.tap(find.byType(CalligraphicBookCover).first);
    await tester.pumpAndSettle();

    // Beside the shelf, not over it: the covers are still on screen.
    expect(find.byType(BookDetailScreen), findsOneWidget);
    expect(find.byType(CalligraphicBookCover), findsWidgets);

    // The reported defect. Before the fix `embedded: true` rendered the pane
    // with `leading: null` and no replacement, so this was `findsNothing` and
    // the pane could never be dismissed.
    expect(_closeButton, findsOneWidget);

    await tester.tap(_closeButton);
    await tester.pumpAndSettle();

    expect(find.byType(BookDetailScreen), findsNothing);
    expect(_closeButton, findsNothing);
  });

  testWidgets('the close affordance is labelled in the reader\'s language',
      (WidgetTester tester) async {
    await _pumpCatalog(tester, size: const Size(1366, 1024));
    await tester.tap(find.byType(CalligraphicBookCover).first);
    await tester.pumpAndSettle();

    // `MaterialLocalizations` carries this string in all 14 shipped locales, so
    // the pane needs no ARB key of its own — and never falls back to English.
    expect(tester.widget<IconButton>(_closeButton).tooltip, 'Fermer');
  });

  testWidgets('the pane never duplicates the grid card\'s shared-element tag',
      (WidgetTester tester) async {
    await _pumpCatalog(tester, size: const Size(1366, 1024));
    await tester.tap(find.byType(CalligraphicBookCover).first);
    await tester.pumpAndSettle();

    // One tag per hero in this route. The grid card for the open book and the
    // pane's own cover both want `book_catalog::<id>`, and Flutter throws
    // "There are multiple heroes that share the same tag within a subtree" as
    // soon as a page route is pushed from a subtree holding both.
    final List<Object> tags = tester
        .widgetList<Hero>(find.byType(Hero))
        .map((Hero hero) => hero.tag)
        .toList();
    expect(tags.toSet(), hasLength(tags.length),
        reason: 'two heroes share a tag inside the catalogue route');

    // The push itself is the reproduction: every micro-read and poem card does
    // this from this very screen.
    final BuildContext context = tester.element(find.byType(BookCatalogScreen));
    unawaited(Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const SizedBox.shrink()),
    ));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'a phone still pushes the detail, with no pane and no close button',
      (WidgetTester tester) async {
    await _pumpCatalog(tester, size: const Size(390, 844));

    await tester.tap(find.byType(CalligraphicBookCover).first);
    await tester.pumpAndSettle();

    // A pushed route: its own back arrow is the dismissal, so the trailing
    // corner stays empty — the wide branch must not leak onto a phone.
    expect(find.byType(BookDetailScreen), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    expect(_closeButton, findsNothing);

    // This screen is rendered on the tightest phone at the widest locale: its
    // CTA label is a `Flexible` for a reason (it overflowed by 30dp here).
    expectNoOverflow(tester, reason: 'phone book detail at 390dp in fr');
  });

  testWidgets('a Split View slice behaves like the phone, not the iPad',
      (WidgetTester tester) async {
    // 600-839dp is medium: a pane there would squeeze the shelf to nothing.
    await _pumpCatalog(tester, size: const Size(700, 1000));

    await tester.tap(find.byType(CalligraphicBookCover).first);
    await tester.pumpAndSettle();

    expect(find.byType(BookDetailScreen), findsOneWidget);
    expect(_closeButton, findsNothing);
  });
}
