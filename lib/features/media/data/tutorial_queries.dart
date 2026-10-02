/// The teaching searches behind the Tutorials tab.
///
/// Like `video_category_queries.dart` these are **discovery terms, not user-facing
/// labels**, so they are deliberately not translated: the API is asked in the
/// language it indexes best, and the chip labels come from the app's own
/// catalogue (`tutorials_screen.dart` maps each topic onto an existing key).
///
/// The *audience* language is not ignored — it is passed to the API as
/// `relevanceLanguage` plus a `regionCode`, which is the sanctioned lever for
/// "show this learner results in their language". Rewriting the query per locale
/// would need a translated query string per locale and would bias the shelf
/// towards machine-translated titles.
///
/// Every topic also ships `videoEmbeddable=true` and `videoCaption=closedCaption`
/// at the call site, so a shelf can only ever fill with videos that play in the
/// app and that a learner can read along with.
abstract final class TutorialQueries {
  /// Lessons aimed at someone on their first week.
  static const beginner = 'learn Chinese for beginners lesson HSK 1';

  /// Pinyin, tones, initials and finals — the app's own weakest area for
  /// learners and the topic they search for most.
  static const pronunciation = 'Chinese pronunciation pinyin tones explained';

  /// How characters are built: radicals, components and stroke order.
  static const strokeOrder = 'Chinese characters stroke order radicals explained';

  /// Graded listening, which needs deliberately slow speech to be useful.
  static const listening = 'Chinese listening practice for beginners slow';

  /// The particles and word orders that no amount of vocabulary fixes.
  static const grammar = 'Chinese grammar lesson explained 的 了 是';
}
