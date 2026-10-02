import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// The current [AppLocalizations] for code that has **no `BuildContext`**.
///
/// Widgets read theirs from `MaterialApp`'s delegate; a provider cannot, which
/// is why `ConversationState` and `StoryState` were carrying hardcoded English
/// prose — including a copy of "No internet connection" that was correct in
/// exactly one of the fourteen languages the app ships.
///
/// It resolves from the same `settingsProvider.locale` that `main.dart` hands to
/// `MaterialApp.locale`, so there stays one source of truth for the app
/// language, and `NetworkNotice.messageOf` already accepts an
/// `AppLocalizations?` for precisely this caller.
///
/// Read it **lazily inside the catch block**, never `watch` it into a
/// `StateNotifierProvider`'s constructor: a locale change would otherwise
/// rebuild the notifier and throw away the conversation (or story) in progress.
final l10nProvider = Provider<AppLocalizations>((ref) {
  final String code = ref.watch(settingsProvider).locale;
  return lookupAppLocalizations(Locale(code));
});
