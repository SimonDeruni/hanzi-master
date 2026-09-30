/// The birthday shelf: one account's tag, four fetched videos, and nobody else.
///
/// Two things are being pinned. The **content** — the tag reads exactly as written, and
/// the four videos are the ones that were asked for (by id, not by a search that could
/// drift to something else tomorrow). And the **gate** — outside her account the shelf
/// does not merely hide, it is *absent*, so every other user's Media tab is unchanged.
library;

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/media/data/birthday_playlist.dart';
import 'package:hanzi_master/features/media/data/youtube_repository.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_search_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/smart_media_desk_screen.dart';
import 'package:hanzi_master/features/media/presentation/widgets/birthday_shelf.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An email and nothing else: the shelf only ever asks who is signed in.
class _FakeUser extends Fake implements User {
  _FakeUser(this.email);

  @override
  final String email;
}

/// Records pushes without the test having to build the pushed screen.
class _RecordingNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushedRoutes = <Route<dynamic>>[];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }
}

/// The desk's discovery shelves come back empty and its channel lookups fail, which is
/// the worst case for the birthday shelf: the feed has nothing else in it, so what shows
/// up can only be the curated tag. Both are what the screen already handles — an empty
/// shelf is dropped, a failed channel lookup falls back to the registry.
class _EmptyYoutubeRepository extends YoutubeRepository {
  @override
  Future<List<YoutubeVideo>> searchVideos(
    String query, {
    bool preferChineseCaptions = false,
  }) async =>
      <YoutubeVideo>[];

  @override
  Future<Map<String, String>> getChannelByHandle(String handle) async =>
      throw UnimplementedError('offline in this test');

  @override
  Future<Map<String, String>> getChannelById(String channelId) async =>
      throw UnimplementedError('offline in this test');

  @override
  Future<Map<String, String>> getChannelByVideo(String videoId) async =>
      throw UnimplementedError('offline in this test');
}

/// The four ids from the links that were sent, in order.
const List<String> _expectedIds = <String>[
  '4XYZi5HyI58',
  'obzK1p4m68U',
  'JpLH1SvdUUw',
  'sPtc6P9xvbg',
];

Widget _host({
  String? email,
  required Widget child,
  double textScale = 1.0,
  NavigatorObserver? navigatorObserver,
}) {
  return ProviderScope(
    overrides: <Override>[
      currentUserProvider.overrideWithValue(
        email == null ? null : _FakeUser(email),
      ),
    ],
    child: MaterialApp(
      locale: const Locale('en'),
      navigatorObservers: <NavigatorObserver>[
        if (navigatorObserver != null) navigatorObserver,
      ],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (BuildContext context, Widget? child) =>
          MediaQuery.withClampedTextScaling(
        minScaleFactor: textScale,
        maxScaleFactor: textScale,
        child: child!,
      ),
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
}

Future<void> _pumpShelf(
  WidgetTester tester, {
  required String? email,
  double textScale = 1.0,
  NavigatorObserver? navigatorObserver,
}) async {
  tester.view.physicalSize = const Size(430, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    _host(
      email: email,
      textScale: textScale,
      navigatorObserver: navigatorObserver,
      child: const BirthdayShelf(),
    ),
  );
  await tester.pump();
}

void main() {
  group('the playlist', () {
    test('carries the tag exactly as it was asked for', () {
      expect(BirthdayPlaylist.tag, 'HAPPY BIRTHDAY !!!');
    });

    test('is the four videos that were sent, by id', () {
      expect(BirthdayPlaylist.videos.map((v) => v.id).toList(), _expectedIds);
      for (final video in BirthdayPlaylist.videos) {
        expect(video.url, 'https://www.youtube.com/watch?v=${video.id}',
            reason: 'the card must open the video it shows');
        expect(video.title.trim(), isNotEmpty, reason: video.id);
        expect(video.channelTitle.trim(), isNotEmpty, reason: video.id);
        // Thumbnails are addressed by the same id, so a card cannot show a different
        // video's frame.
        expect(video.highThumbnailUrl, contains('/${video.id}/'),
            reason: video.id);
        expect(video.mediumThumbnailUrl, contains('img.youtube.com/vi/'),
            reason: video.id);
      }
      expect(BirthdayPlaylist.videos.map((v) => v.id).toSet(), hasLength(4),
          reason: 'no duplicate video');
    });

    test('belongs to the owner comped account, and to nobody else', () {
      // The shelf is only useful while that account exists, so the two are asserted
      // together rather than left to drift apart.
      expect(MonetizationService.compedAccounts,
          contains(BirthdayPlaylist.recipientEmail));
      expect(BirthdayPlaylist.isFor('hanbaobao@love.com'), isTrue);
      expect(BirthdayPlaylist.isFor(' HanBaoBao@Love.com '), isTrue);
      for (final String? other in <String?>[
        null,
        '',
        'someone.else@love.com',
        'hanbaobao@love.com.evil.com',
      ]) {
        expect(BirthdayPlaylist.isFor(other), isFalse, reason: '$other');
      }
    });
  });

  group('the shelf', () {
    testWidgets('shows the tag and every title to her', (WidgetTester tester) async {
      await _pumpShelf(tester, email: 'hanbaobao@love.com');

      expect(find.text('HAPPY BIRTHDAY !!!'), findsOneWidget);

      // A row of 260dp cards on a 430dp screen builds roughly one and a half of them,
      // so each title is scrolled to rather than assumed to be on screen already.
      for (final video in BirthdayPlaylist.videos) {
        await tester.scrollUntilVisible(
          find.text(video.title),
          200,
          scrollable: find.byType(Scrollable).last,
        );
        expect(find.text(video.title), findsOneWidget, reason: video.id);
      }

      final ListView shelf = tester.widget<ListView>(find.byType(ListView));
      expect(shelf.semanticChildCount, BirthdayPlaylist.videos.length,
          reason: 'one card per video, no more and no fewer');
      expect(tester.getSize(find.byType(BirthdayShelf)).height, greaterThan(0));
    });

    // `maxresdefault` 404s for plenty of videos — two of the four on this shelf — while
    // `hqdefault` exists for them, so a failed best-frame request must land on the
    // medium frame and only then give up. The `Image` widget is still in the tree after
    // its `errorBuilder` has drawn something, so what it *would* draw can be asked for
    // directly instead of waiting on a network that never answers in a test.
    testWidgets('a missing maxres thumbnail falls back to the medium one',
        (WidgetTester tester) async {
      await _pumpShelf(tester, email: 'hanbaobao@love.com');

      final YoutubeVideo first = BirthdayPlaylist.videos.first;
      final Finder thumbnails = find.byType(Image);
      expect(thumbnails, findsWidgets, reason: 'the card asks for a frame');

      final Image best = tester.widget<Image>(thumbnails.first);
      expect((best.image as NetworkImage).url, first.highThumbnailUrl,
          reason: 'the best frame is asked for first');

      final Widget afterError = best.errorBuilder!(
        tester.element(thumbnails.first),
        Exception('404'),
        null,
      );
      expect(afterError, isA<Image>(),
          reason: 'a 404 on maxres must not cost her the thumbnail');
      final Image fallback = afterError as Image;
      expect((fallback.image as NetworkImage).url, first.mediumThumbnailUrl);

      // And if that is missing too, the card is a placeholder rather than a hole.
      expect(
        fallback.errorBuilder!(
          tester.element(thumbnails.first),
          Exception('404'),
          null,
        ),
        isNot(isA<Image>()),
      );
    });

    testWidgets('is absent — not hidden — for anyone else',
        (WidgetTester tester) async {
      for (final String? email in <String?>[
        'someone.else@love.com',
        null,
      ]) {
        await _pumpShelf(tester, email: email);
        expect(find.text('HAPPY BIRTHDAY !!!'), findsNothing, reason: '$email');
        expect(tester.getSize(find.byType(BirthdayShelf)), Size.zero,
            reason: 'a zero-size box leaves the host screen untouched for $email');
      }
    });

    testWidgets('a card opens the transcript desk, like every other video',
        (WidgetTester tester) async {
      final _RecordingNavigatorObserver observer = _RecordingNavigatorObserver();
      await _pumpShelf(
        tester,
        email: 'hanbaobao@love.com',
        navigatorObserver: observer,
      );

      await tester.tap(find.text(BirthdayPlaylist.videos.first.title));
      // Deliberately no `pump`: the push has already reached the observer, and pumping
      // would build the desk, which needs YouTube providers this test does not fake.
      // The route's own builder is asked what it *would* build instead.
      expect(observer.pushedRoutes, hasLength(2),
          reason: 'the first push is the home route, the second is the card');
      final MaterialPageRoute<void> route =
          observer.pushedRoutes.last as MaterialPageRoute<void>;
      expect(
        route.builder(tester.element(find.byType(BirthdayShelf))),
        isA<SmartMediaDeskScreen>(),
        reason: 'the birthday videos get the same desk as the rest of the app',
      );
    });

    testWidgets('survives its longest title at 2.0x text scale',
        (WidgetTester tester) async {
      // Two lines and an ellipsis is the contract: the longest title here is 48
      // characters, and the tag is longer than any label the badge was drawn for.
      await _pumpShelf(
        tester,
        email: 'hanbaobao@love.com',
        textScale: 2.0,
      );

      expect(tester.takeException(), isNull);
      expect(find.text('HAPPY BIRTHDAY !!!'), findsOneWidget);
    });
  });

  group('both video surfaces lead with it', () {
    testWidgets('the video desk renders the tag as its first shelf, for her',
        (WidgetTester tester) async {
      // End-to-end for the desk hook, using the real screen: its own discovery shelves
      // are empty here, so this proves the tag is *added* rather than the feed merely
      // containing it somewhere.
      SharedPreferences.setMockInitialValues(<String, Object>{});
      tester.view.physicalSize = const Size(430, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: <Override>[
            currentUserProvider
                .overrideWithValue(_FakeUser('hanbaobao@love.com')),
            youtubeRepositoryProvider
                .overrideWithValue(_EmptyYoutubeRepository()),
          ],
          child: const MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaSearchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // The desk's channel row fetches avatar images over the network; a test client
      // answers 400, and those failures surface here. They belong to the desk, not to
      // the birthday shelf — whose cards carry an `errorBuilder` — so they are drained
      // rather than asserted on.
      while (tester.takeException() != null) {}

      expect(find.text('HAPPY BIRTHDAY !!!'), findsOneWidget);
      // The shelf's own videos are under it — the discovery shelves are all empty, so
      // this title can only be hers.
      expect(find.text(BirthdayPlaylist.videos.first.title), findsOneWidget);
      expect(find.text('Lifestyle & Vlog'), findsNothing,
          reason: 'the discovery shelves really are empty in this test');
    });

    // Placement *is* the requirement ("easily seen by her"), and placement is exactly
    // what a later edit quietly undoes, so it is asserted rather than assumed.
    test('the Media tab puts the shelf above the carousel of the day', () {
      final String hub = File(
        'lib/features/media/presentation/screens/media_hub_screen.dart',
      ).readAsStringSync();
      final int shelf = hub.indexOf('BirthdayShelf()');
      expect(shelf, greaterThan(0));
      expect(shelf, lessThan(hub.indexOf('_DailyDiscoveryCarousel()')),
          reason: 'her shelf must come first on the Media tab');
    });

    test('the video desk registers the tag before the discovery shelves', () {
      final String desk = File(
        'lib/features/media/presentation/screens/media_search_screen.dart',
      ).readAsStringSync();
      final int birthday =
          desk.indexOf('BirthdayPlaylist.tag: BirthdayPlaylist.videos');
      expect(birthday, greaterThan(0));
      expect(birthday, lessThan(desk.indexOf('localizations.lifestyleAndVlog: []')),
          reason: 'the birthday tag is the first shelf in the feed');
      expect(
        desk.contains('BirthdayPlaylist.tag] = _CategoryLoadState.loaded'),
        isTrue,
        reason: 'a tag with no fetch behind it has to be marked loaded, or it '
            'renders as a skeleton forever',
      );
      expect(desk.contains('VideoCategoryQueries.birthday'), isFalse,
          reason: 'the tag has no search query — it names its videos');
    });
  });
}
