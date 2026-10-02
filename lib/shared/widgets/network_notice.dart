import 'package:flutter/widgets.dart';

import 'package:hanzi_master/core/utils/network_failure.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';

/// The one way the app says *"you are not online"*.
///
/// Several features cannot work at all without a connection — the AI desks,
/// YouTube search and channel feeds, story fetching, cloud sync, account
/// deletion. When one of them fails, the learner was previously shown the raw
/// exception (`ClientException with SocketException: Failed host lookup…`),
/// which is both untranslated and unactionable.
///
/// Every message here comes from the single existing key
/// `noInternetConnectionPleaseCheckYour`, already translated into all 14
/// locales — so a network notice is the *same sentence* wherever it appears,
/// and fixing the wording is a one-line change per locale rather than a hunt
/// through call sites.
///
/// Because the app is genuinely offline-first (decks live in Hive, texts and
/// covers ship in the bundle, TTS and tone grading run on-device), this is
/// deliberately **not** a global "you are offline" banner: a permanent banner
/// would be wrong while someone is happily reviewing cards on a plane. The
/// notice appears only when a request that needed the network actually failed.
class NetworkNotice {
  NetworkNotice._();

  /// Used only when no `AppLocalizations` is in scope (a bare test harness).
  /// Runtime callers always have the delegate wired up in `MaterialApp`.
  static const String englishFallback =
      'No internet connection. Please check your network and try again.';

  /// The localized "no internet connection" sentence, from an already-resolved
  /// [l10n].
  ///
  /// Preferred inside an `async` gap: `context` may be disposed by the time an
  /// `await` returns, and this never touches it.
  static String messageOf(AppLocalizations? l10n) =>
      l10n?.noInternetConnectionPleaseCheckYour ?? englishFallback;

  /// The localized "no internet connection" sentence.
  static String message(BuildContext context) =>
      messageOf(AppLocalizations.of(context));

  /// [fallback] unless [error] was caused by a lost connection, in which case
  /// the localized offline sentence.
  ///
  /// This is the form to use in a **full-screen error state**, where the whole
  /// feature is unavailable: replacing a raw exception with a sentence the
  /// learner can act on beats adding a toast on top of an error panel that
  /// already explains nothing.
  static String describe(
    BuildContext context,
    Object? error, {
    required String fallback,
  }) =>
      NetworkFailure.isOffline(error) ? message(context) : fallback;

  /// Shows the localized offline toast when [error] was a lost connection.
  ///
  /// Returns whether it fired, so a caller can fall through to its own
  /// handling:
  ///
  /// ```dart
  /// } catch (e) {
  ///   if (NetworkNotice.showIfOffline(context, e)) return;
  ///   ZenToast.error(context, l10n.downloadBookError);
  /// }
  /// ```
  static bool showIfOffline(BuildContext context, Object? error) {
    if (!NetworkFailure.isOffline(error)) return false;
    ZenToast.offline(context, message(context));
    return true;
  }
}
