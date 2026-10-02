/// The Tutorials tab's compliance contract, in executable form.
///
/// The tab exists because YouTube *permits* apps to build on its catalogue —
/// through the official Data API and the official player. What it forbids is
/// reaching YouTube any other way, or copying what it serves. The rest of the
/// media feature already takes the other road (`youtube_repository.dart` scrapes
/// search, caption manifests and transcripts with `youtube_explode_dart`), so the
/// point of these tests is that **this** feature never does:
///
///  * official endpoints only, with the filters that make a shelf safe and
///    playable (`videoEmbeddable`, `safeSearch`, `videoCaption`),
///  * no scraper, no caption extraction, no download, no audio separation —
///    playback happens in YouTube's player, which is what keeps embedding legal,
///  * attribution (the channel) and a link out to the watch page, which the terms
///    require,
///  * a disclosure naming YouTube API Services and Google's privacy policy,
///  * quota discipline: the expensive call is cached, so the shelf is not a
///    per-user 100-unit spend.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/data/repositories/tutorials_repository.dart';
import 'package:hanzi_master/features/media/domain/models/tutorial_video.dart';

/// The files that make up the Tutorials feature.
const List<String> _featureFiles = <String>[
  'lib/features/media/data/tutorial_queries.dart',
  'lib/features/media/data/repositories/tutorials_repository.dart',
  'lib/features/media/domain/models/tutorial_video.dart',
  'lib/features/media/presentation/screens/tutorials_screen.dart',
  'lib/features/media/presentation/screens/tutorial_player_screen.dart',
];

const String _repositoryPath =
    'lib/features/media/data/repositories/tutorials_repository.dart';
const String _screenPath =
    'lib/features/media/presentation/screens/tutorials_screen.dart';
const String _playerPath =
    'lib/features/media/presentation/screens/tutorial_player_screen.dart';
const String _videoPath =
    'lib/features/media/domain/models/tutorial_video.dart';

String _read(String path) =>
    File(path).readAsStringSync().replaceAll('\r\n', '\n');

/// Removes `//` comments, so documenting an idiom is not mistaken for using it.
///
/// The repository's doc comment names the scraper it deliberately avoids, and a
/// scan that reads comments would flag that as a dependency. Same helper, same
/// reason, as `test/core/motion_guard_test.dart`.
String _withoutLineComments(String source) => source
    .split('\n')
    .map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    })
    .join('\n');

void main() {
  late Map<String, String> sources;

  /// The same files with comments stripped — what the code actually does.
  late Map<String, String> code;

  setUpAll(() {
    sources = <String, String>{
      for (final String path in _featureFiles) path: _read(path),
    };
    code = <String, String>{
      for (final MapEntry<String, String> entry in sources.entries)
        entry.key: _withoutLineComments(entry.value),
    };
  });

  group('it uses the official API and nothing else', () {
    test('the repository talks to googleapis.com/youtube/v3', () {
      final String repository = sources[_repositoryPath]!;
      expect(repository, contains('https://www.googleapis.com/youtube/v3'));
      expect(repository, contains(r'$_baseUrl/search'));
      expect(repository, contains(r'$_baseUrl/videos'));
    });

    test('no file in the feature touches the scraper', () {
      for (final MapEntry<String, String> entry in code.entries) {
        expect(entry.value, isNot(contains('youtube_explode_dart')),
            reason: '${entry.key} must not import the scraper');
        expect(entry.value, isNot(contains('YoutubeExplode')),
            reason: '${entry.key} must not use YoutubeExplode');
        expect(entry.value, isNot(contains('closedCaptions')),
            reason: '${entry.key} must not read caption manifests');
        expect(entry.value, isNot(contains('getTranscript')),
            reason: '${entry.key} must not extract transcripts');
      }
    });

    test('the existing scraper path is untouched, and unreferenced', () {
      expect(File('lib/features/media/data/youtube_repository.dart').existsSync(),
          isTrue,
          reason: 'The tutorial work is additive; the existing feature stands');
      for (final MapEntry<String, String> entry in code.entries) {
        expect(entry.value, isNot(contains('youtube_repository.dart')),
            reason: '${entry.key} must not depend on the scraped path');
      }
    });
  });

  group('the search is filtered for safety, captions and playability', () {
    test('every required query parameter is present', () {
      final String repository = sources[_repositoryPath]!;
      expect(repository, contains("'videoEmbeddable': 'true'"),
          reason: 'Never list a video the player cannot show');
      expect(repository, contains("'safeSearch': 'strict'"),
          reason: 'A teaching shelf is also a content shelf');
      expect(repository, contains("'videoCaption': 'closedCaption'"),
          reason: 'A tutorial a learner cannot read along with is not a tutorial');
      expect(repository, contains("'relevanceLanguage'"));
      expect(repository, contains("'regionCode'"));
    });

    test('status.embeddable is re-checked on every hydrated item', () {
      expect(sources[_repositoryPath]!,
          contains("'part': 'snippet,contentDetails,status'"));
      expect(sources[_videoPath]!, contains("status['embeddable'] == false"));
    });
  });

  group('nothing is copied', () {
    test('no download, capture or audio-separation API is used', () {
      for (final String banned in <String>[
        'audioplayers',
        'HttpClient',
        'getManifest',
        'ffmpeg',
      ]) {
        for (final MapEntry<String, String> entry in code.entries) {
          expect(entry.value, isNot(contains(banned)),
              reason: '${entry.key} must not use $banned');
        }
      }
    });

    test('the cache holds metadata only, with a bounded lifetime', () {
      expect(sources[_repositoryPath]!, contains('static const Duration cacheTtl'));
      expect(TutorialsRepository.cacheTtl.inDays, lessThanOrEqualTo(30),
          reason: 'API data may only be cached for a limited time');
      // Ids, titles, a thumbnail *link* and a duration — no media, no captions.
      final Map<String, dynamic> stored = const TutorialVideo(
        id: 'abc123',
        title: 'Tones explained',
        channelTitle: 'A Teacher',
        thumbnailUrl: 'https://i.ytimg.com/vi/abc123/hqdefault.jpg',
      ).toJson();
      expect(stored.keys.toSet(), <String>{
        'id',
        'title',
        'channelTitle',
        'thumbnailUrl',
        'durationSeconds',
      });
    });
  });

  group('attribution and disclosure are on screen', () {
    test('a card names the channel and links the watch page', () {
      final String screen = sources[_screenPath]!;
      expect(screen, contains('video.channelTitle'),
          reason: 'The channel credit is required next to the video');
      expect(screen, contains('openInYoutube'),
          reason: 'The watch page must be one tap away');
      expect(screen, contains('video.watchUrl'));
      expect(sources[_videoPath]!, contains('i.ytimg.com'),
          reason: 'Thumbnails are linked from YouTube, never re-hosted');
    });

    test('the shelf discloses YouTube API Services and Google\'s policy', () {
      final String screen = sources[_screenPath]!;
      expect(screen, contains('l10n.youtubeHostedNotice'));
      expect(screen, contains('https://policies.google.com/privacy'));
    });

    test('the licences screen carries the API Services notice', () {
      final String notices = _read('lib/core/legal/third_party_notices.dart');
      expect(notices, contains('youtubeApiServicesPackageName'));
      expect(notices, contains('youtubeApiServicesNotice'));
      expect(notices, contains('https://www.youtube.com/t/terms'),
          reason: 'The disclosure must point at the YouTube Terms of Service');
      expect(notices, contains('not endorsed or certified by YouTube'));
    });
  });

  group('playback stays inside YouTube\'s player', () {
    test('the player is YouTube\'s, with its own controls', () {
      final String player = sources[_playerPath]!;
      expect(player, contains('YoutubePlayerController.fromVideoId'));
      expect(player, contains('showControls: true'),
          reason: 'The player must not be obscured or replaced by custom chrome');
      expect(player, contains('strictRelatedVideos: true'),
          reason: 'A lesson should not end in unrelated recommendations');
      expect(player, contains('_controller.close()'));
    });

    test('no overlay is drawn over the player', () {
      final String player = sources[_playerPath]!;
      // The player is presented as a widget and nothing else: no Stack of
      // overlays over the video, no ad SDK, no custom caption rail.
      expect(player, isNot(contains('Stack(')),
          reason: 'Nothing may cover the player');
      expect(player, isNot(contains('google_mobile_ads')));
    });
  });

  group('the shelf is not gated', () {
    test('nothing in the feature checks entitlement', () {
      for (final MapEntry<String, String> entry in code.entries) {
        for (final String gate in <String>[
          'isPremium',
          'hasPro',
          'premiumGate',
          'PaywallSheet',
          'entitlement',
        ]) {
          expect(entry.value, isNot(contains(gate)),
              reason: '${entry.key} must not put YouTube content behind a '
                  'paywall');
        }
      }
    });

    test('the hub links to it additively', () {
      final String hub =
          _read('lib/features/media/presentation/screens/media_hub_screen.dart');
      expect(hub, contains('TutorialsScreen()'));
      expect(hub, contains('tutorialsTab'));
    });
  });

  group('the ISO-8601 duration parser', () {
    test('reads the shapes the API actually returns', () {
      expect(TutorialVideo.parseIsoDuration('PT12M34S'),
          const Duration(minutes: 12, seconds: 34));
      expect(TutorialVideo.parseIsoDuration('PT1H2M3S'),
          const Duration(hours: 1, minutes: 2, seconds: 3));
      expect(
          TutorialVideo.parseIsoDuration('PT45S'), const Duration(seconds: 45));
      expect(TutorialVideo.parseIsoDuration('P1DT2H'),
          const Duration(days: 1, hours: 2));
    });

    test('returns null instead of throwing on anything odd', () {
      expect(TutorialVideo.parseIsoDuration(null), isNull);
      expect(TutorialVideo.parseIsoDuration(''), isNull);
      expect(TutorialVideo.parseIsoDuration('12:34'), isNull);
      expect(TutorialVideo.parseIsoDuration('PT0S'), isNull);
    });
  });

  group('the API item mapping', () {
    Map<String, dynamic> item({Object? embeddable, String duration = 'PT5M'}) =>
        <String, dynamic>{
          'id': 'vid123',
          'snippet': <String, dynamic>{
            'title': 'Chinese tones, explained',
            'channelTitle': 'Slow Mandarin',
          },
          'contentDetails': <String, dynamic>{'duration': duration},
          'status': <String, dynamic>{'embeddable': embeddable},
        };

    test('maps a playable, embeddable video', () {
      final TutorialVideo? video =
          TutorialVideo.fromApiItem(item(embeddable: true));
      expect(video, isNotNull);
      expect(video!.id, 'vid123');
      expect(video.channelTitle, 'Slow Mandarin');
      expect(video.durationLabel, '5:00');
      expect(video.watchUrl, 'https://www.youtube.com/watch?v=vid123');
      expect(video.thumbnailUrl, 'https://i.ytimg.com/vi/vid123/hqdefault.jpg');
    });

    test('drops a video the player is not allowed to show', () {
      expect(TutorialVideo.fromApiItem(item(embeddable: false)), isNull,
          reason: 'A card that fails on tap is worse than a shorter shelf');
    });

    test('drops an item with no id or no title', () {
      expect(TutorialVideo.fromApiItem(<String, dynamic>{}), isNull);
      expect(
        TutorialVideo.fromApiItem(<String, dynamic>{
          'id': 'vid123',
          'snippet': <String, dynamic>{'title': ''},
        }),
        isNull,
      );
    });

    test('survives the cache round trip, duration included', () {
      final TutorialVideo original = TutorialVideo.fromApiItem(item())!;
      final TutorialVideo? restored = TutorialVideo.fromJson(
        json.decode(json.encode(original.toJson())) as Map<String, dynamic>,
      );
      expect(restored, isNotNull);
      expect(restored!.id, original.id);
      expect(restored.title, original.title);
      expect(restored.duration, original.duration);
    });
  });

  group('the store front', () {
    test('follows the interface language and falls back safely', () {
      expect(TutorialsRepository.regionFor('ja'), 'JP');
      expect(TutorialsRepository.regionFor('fr'), 'FR');
      expect(TutorialsRepository.regionFor('pt'), 'BR');
      expect(TutorialsRepository.regionFor('en'), 'US');
      expect(TutorialsRepository.regionFor('xx'), 'US',
          reason: 'An unknown locale falls back rather than failing the shelf');
    });
  });
}
