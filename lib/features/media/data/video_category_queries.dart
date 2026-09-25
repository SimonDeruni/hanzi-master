/// Locale-independent YouTube queries for the automatic Mandarin video feed.
///
/// These are discovery terms, not user-facing labels, so they must not be
/// translated with the application's display language.
///
/// There is deliberately **no** gaming/esports query: it consistently came back
/// with no videos, so the feed shipped a 250dp shelf that only ever said "no
/// videos found". A shelf that cannot fill itself is not worth a row — see
/// `media_search_screen.dart`, which also drops any shelf that loads empty.
abstract final class VideoCategoryQueries {
  static const lifestyle = '中国 日常生活 vlog 中文';
  static const food = '中国 美食 菜谱 中文';
  static const technology = '中国 科技 测评 中文';
}
