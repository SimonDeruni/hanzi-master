import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/youtube_thumbnail.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';

void main() {
  group('YouTubeThumbnail', () {
    test('addresses the 1280x720 rendition for the HD still', () {
      expect(
        YouTubeThumbnail.maxRes('dQw4w9WgXcQ'),
        'https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg',
      );
    });

    test('addresses the 480x360 rendition as the guaranteed floor', () {
      expect(
        YouTubeThumbnail.high('dQw4w9WgXcQ'),
        'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg',
      );
    });
  });

  group('YoutubeVideo.fromJson thumbnail selection', () {
    Map<String, dynamic> payload(Map<String, String> renditions) => {
          'id': {'kind': 'youtube#video', 'videoId': 'dQw4w9WgXcQ'},
          'snippet': {
            'title': 'A video',
            'channelTitle': 'A channel',
            'thumbnails': {
              for (final entry in renditions.entries)
                entry.key: {'url': entry.value},
            },
          },
        };

    test('prefers maxres over high when the Data API offers an HD still', () {
      final video = YoutubeVideo.fromJson(payload({
        'default': 'https://i.ytimg.com/vi/x/default.jpg',
        'medium': 'https://i.ytimg.com/vi/x/mqdefault.jpg',
        'high': 'https://i.ytimg.com/vi/x/hqdefault.jpg',
        'maxres': 'https://i.ytimg.com/vi/x/maxresdefault.jpg',
      }));

      expect(video.highThumbnailUrl, contains('maxresdefault.jpg'));
      // The lower slot is only ever a placeholder or a fallback, so it stays at
      // the 480x360 frame that every upload has.
      expect(video.mediumThumbnailUrl, contains('hqdefault.jpg'));
    });

    test('falls back to high when the upload has no HD still', () {
      final video = YoutubeVideo.fromJson(payload({
        'medium': 'https://i.ytimg.com/vi/x/mqdefault.jpg',
        'high': 'https://i.ytimg.com/vi/x/hqdefault.jpg',
      }));

      expect(video.highThumbnailUrl, contains('hqdefault.jpg'));
      expect(video.mediumThumbnailUrl, contains('hqdefault.jpg'));
    });

    test('falls back to medium when even high is absent', () {
      final video = YoutubeVideo.fromJson(payload({
        'medium': 'https://i.ytimg.com/vi/x/mqdefault.jpg',
      }));

      expect(video.highThumbnailUrl, contains('mqdefault.jpg'));
      expect(video.mediumThumbnailUrl, contains('mqdefault.jpg'));
    });
  });
}
