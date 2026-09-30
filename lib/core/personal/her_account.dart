/// The one account the personal content in `her_content.dart` belongs to.
///
/// Everything keyed to that account — the birthday shelf, the word of the day, the
/// book, the shadowing sentences, the deck — asks *this* class whether the signed-in
/// address is hers, so there is one comparison in the app instead of one per screen.
/// A screen that compared `'hanbaobao@love.com'` itself could disagree about case,
/// about surrounding space, or about a lookalike domain like
/// `hanbaobao@love.com.evil.example`, and the disagreement would show up as
/// personal content leaking onto somebody else's screen.
abstract final class HerAccount {
  /// Lower-cased, like every email comparison in the app.
  static const String email = 'hanbaobao@love.com';

  /// True when [email] is her account. Case and surrounding space are ignored.
  static bool isHer(String? email) =>
      email != null && email.trim().toLowerCase() == HerAccount.email;
}
