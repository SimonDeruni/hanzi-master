/// Helpers for requesting the **highest-quality** YouTube still available.
///
/// YouTube re-serves the same frame at a handful of fixed sizes from
/// `img.youtube.com/vi/<id>/<rendition>.jpg`:
///
/// | rendition            | pixels   | present when          |
/// |----------------------|----------|-----------------------|
/// | `mqdefault.jpg`      | 320x180  | every video           |
/// | `hqdefault.jpg`      | 480x360  | every video           |
/// | `sddefault.jpg`      | 640x480  | most videos           |
/// | `maxresdefault.jpg`  | 1280x720 | HD-or-better uploads  |
///
/// The rendition most code reaches for is `hqdefault`, which pixelates the
/// moment it is stretched across a full-bleed header. `maxresdefault` is 2.7x
/// the linear size, but YouTube answers **404** for uploads that were never
/// encoded above 480p — so it must be *attempted*, never assumed. Every caller
/// therefore needs a fallback: an image widget's `errorBuilder`
/// (`birthday_shelf.dart` is the reference implementation) or the existence
/// probe in `daily_discovery_repository.dart`.
class YouTubeThumbnail {
  /// 1280x720 — the crisp rendition, available only for HD uploads.
  static String maxRes(String videoId) =>
      'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';

  /// 480x360 — available for every video, so it is the safe floor. This is what
  /// `errorBuilder` fallbacks and pre-load placeholders should point at.
  static String high(String videoId) =>
      'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
}
