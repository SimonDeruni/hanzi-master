import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hanzi_master/features/reading/presentation/providers/now_playing_provider.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/now_playing_bar.dart';

/// Tracks whether anything sits **above** the app shell's route.
///
/// Self-correcting rather than a counter: every callback reports the route that
/// is on top afterwards, so a `pushAndRemoveUntil` or a `removeRoute` cannot
/// leave a depth drifting and silently strand the transport.
class AudioRouteObserver extends NavigatorObserver {
  final ValueNotifier<bool> _shellBuried = ValueNotifier<bool>(false);

  /// True while a route is stacked above the shell (`MainNavigationScreen`).
  ValueListenable<bool> get shellBuried => _shellBuried;

  Route<dynamic>? _top;

  void _setTop(Route<dynamic>? route) {
    _top = route;
    // `isFirst` *is* the shell. Before the first push there is no route yet, and
    // a shell with nothing above it draws its own bar.
    _shellBuried.value = !(route?.isFirst ?? true);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _setTop(route);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _setTop(previousRoute);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _setTop(previousRoute);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (identical(_top, oldRoute)) _setTop(newRoute);
  }
}

/// The app-wide transport for background audiobook playback.
///
/// **The gap it closes.** `MainNavigationScreen` already draws a
/// [NowPlayingBar] directly above its tab bar, and `AudiobookPlayerScreen.dispose`
/// deliberately does **not** stop playback when it is playing — background
/// listening is the feature, so the transport is handed over to that bar. But
/// that bar lives inside the *shell's* `Scaffold`, so **every route pushed above
/// the shell covers it**. The player is opened from `BookDetailScreen` and
/// `BookReaderScreen`, so stepping out of the player lands on exactly such a
/// route: the audiobook kept playing, the only in-app control was behind a screen
/// nobody could see, and the OS media notification was the sole surface left.
///
/// So the bar is mounted *above* the `Navigator` as well (through
/// `MaterialApp.builder`) and draws itself exactly while the shell is buried.
/// One transport in every state — the shell's own while the shell is on top,
/// this one everywhere else — and neither while the player is on screen, since
/// the player carries its own.
class NowPlayingHost extends ConsumerWidget {
  const NowPlayingHost({super.key, required this.shellBuried});

  /// The app's [AudioRouteObserver]'s [AudioRouteObserver.shellBuried].
  final ValueListenable<bool> shellBuried;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool playerOwnsTransport = ref.watch(playerOwnsTransportProvider);

    return ValueListenableBuilder<bool>(
      valueListenable: shellBuried,
      builder: (BuildContext context, bool buried, Widget? _) {
        if (!buried || playerOwnsTransport) return const SizedBox.shrink();
        return const SafeArea(top: false, child: NowPlayingBar());
      },
    );
  }
}
