import 'package:hanzi_master/core/personal/her_account.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';

/// Three videos fetched for one account's birthday.
///
/// The tag, the titles and the channel names are **content, not chrome**, so they
/// ship exactly as written and are not translated — the same rule
/// `curated_shows.dart` (Chinese drama titles) and `video_category_queries.dart`
/// (discovery terms) already follow. A birthday message is also not improved by
/// machine translation: it is meant to read as the person who sent it wrote it.
///
/// **Who it is for** is the owner's comped account in
/// `MonetizationService.compedAccounts`; `birthday_playlist_test.dart` asserts that
/// link, so the shelf cannot outlive the account it belongs to or appear on someone
/// else's screen.
///
/// The titles and channels were resolved once from YouTube's oEmbed endpoint
/// (`youtube.com/oembed`, no key) and are **stored, not fetched**: a shelf that needs
/// the network to say what it is would be missing precisely when she opens the app
/// on a plane. Thumbnails use the same `img.youtube.com/vi/<id>/…` pattern
/// `daily_discovery_repository.dart` uses for the video of the day.
abstract final class BirthdayPlaylist {
  /// The tag shown on the shelf. Exactly this string — it is the message.
  static const String tag = 'HAPPY BIRTHDAY !!!';

  /// The account this shelf belongs to, lower-cased like every email comparison in
  /// the app. It is [HerAccount.email] — one address, declared once.
  static const String recipientEmail = HerAccount.email;

  static const List<YoutubeVideo> videos = <YoutubeVideo>[
    YoutubeVideo(
      id: '4XYZi5HyI58',
      title: 'Happy Birthday (Hardstyle Remix)',
      url: 'https://www.youtube.com/watch?v=4XYZi5HyI58',
      mediumThumbnailUrl: 'https://img.youtube.com/vi/4XYZi5HyI58/hqdefault.jpg',
      highThumbnailUrl:
          'https://img.youtube.com/vi/4XYZi5HyI58/maxresdefault.jpg',
      channelTitle: 'KLAUZ',
    ),
    YoutubeVideo(
      id: 'obzK1p4m68U',
      title: 'Yi Jian Mei (Xue Hua Piao Piao) - Donald Trump Cover',
      url: 'https://www.youtube.com/watch?v=obzK1p4m68U',
      mediumThumbnailUrl: 'https://img.youtube.com/vi/obzK1p4m68U/hqdefault.jpg',
      highThumbnailUrl:
          'https://img.youtube.com/vi/obzK1p4m68U/maxresdefault.jpg',
      channelTitle: 'Rooples',
    ),
    YoutubeVideo(
      id: 'JpLH1SvdUUw',
      title: 'Josman - My Love (feat. Tayc)',
      url: 'https://www.youtube.com/watch?v=JpLH1SvdUUw',
      mediumThumbnailUrl: 'https://img.youtube.com/vi/JpLH1SvdUUw/hqdefault.jpg',
      highThumbnailUrl:
          'https://img.youtube.com/vi/JpLH1SvdUUw/maxresdefault.jpg',
      channelTitle: 'Josman',
    ),
  ];

  /// True when [email] is the account this shelf belongs to. Case and surrounding
  /// space are ignored, and the comparison itself lives in [HerAccount] so that the
  /// shelf and the rest of her content cannot disagree about who she is.
  static bool isFor(String? email) => HerAccount.isHer(email);
}
