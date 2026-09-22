import 'package:flutter/material.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// Shared-element transition helpers for the app's card → detail navigations.
///
/// ## Why a namespaced tag
///
/// [Hero] tags must be unique within a single route. Shelf and catalog screens
/// render the *same* card widget in several places (a horizontal shelf, a
/// "continue reading" rail, a category grid), so a naive `Hero` would put
/// duplicate tags on one screen and Flutter would throw at runtime.
///
/// [heroTag] namespaces every tag by screen context, so the same book appearing
/// in two rails still produces distinct tags. Only the card whose tag matches
/// the detail screen's tag animates; the rest stay static, which is the correct
/// behaviour anyway.
///
/// ## Reduced motion
///
/// When the platform "Reduce Motion" setting is on, [HeroTransition] returns its
/// child unwrapped, so navigation is a plain cut with no flying element.
class HeroTransition {
  const HeroTransition._();

  /// Builds a collision-safe hero tag.
  ///
  /// [scope] identifies the *screen* the card is rendered on (e.g.
  /// `'book_catalog'`), and [id] identifies the item.
  static String heroTag(String scope, String id) => '$scope::$id';

  /// Wraps [child] in a [Hero] unless motion is reduced.
  ///
  /// The [tag] is passed through [FlightShuttleBuilder] defaults; the child is
  /// expected to size itself the same on both routes so the flight looks stable.
  static Widget wrap({
    required BuildContext context,
    required String tag,
    required Widget child,
    bool enabled = true,
  }) {
    if (!enabled || context.reduceMotion) return child;
    return Hero(
      tag: tag,
      // Keep the destination widget's own layout during the flight; the source
      // and destination covers share their painter, so this avoids a flash when
      // one side carries extra chrome (badges, ribbons).
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        final toHero = toHeroContext.widget as Hero;
        return toHero.child;
      },
      child: child,
    );
  }
}
