/// Compile-time feature switches for functionality that should not ship in
/// every distribution of the app.
abstract final class AppFeatures {
  /// YouTube learning videos, video discovery, shows, and dramas.
  ///
  /// Disabled by default for public builds. Internal builds can restore the
  /// preserved implementation with:
  /// `--dart-define=ENABLE_YOUTUBE_MEDIA=true`.
  static const bool youtubeMedia = bool.fromEnvironment(
    'ENABLE_YOUTUBE_MEDIA',
    defaultValue: false,
  );
}
