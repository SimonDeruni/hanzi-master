import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/media/data/birthday_playlist.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';
import 'package:hanzi_master/features/media/presentation/screens/smart_media_desk_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

/// A shelf that exists for exactly one account, and is invisible to every other.
///
/// It renders nothing at all unless the signed-in address is
/// [BirthdayPlaylist.recipientEmail] — not "hidden", *absent*: outside that account
/// the surrounding screen has to stay pixel-identical to what it was before, which is
/// why the gate is the first line of `build` and the empty branch returns a zero-size
/// box rather than a spacer.
///
/// The tag is deliberately loud — it is a birthday message, and the point was that she
/// cannot miss it — so the Media tab leads with it, above the carousel of the day.
/// The shelf itself is plain: a tag, four fetched videos, and the same tap every
/// other video in the app gets (`SmartMediaDeskScreen`, so she lands on the transcript
/// desk rather than a bare embed).
class BirthdayShelf extends ConsumerWidget {
  const BirthdayShelf({super.key});

  /// Card width, and the height the thumbnail alone needs (16:9 of that width).
  static const double cardWidth = 260;

  /// The text under the thumbnail — two title lines plus the channel — measured at
  /// 1.0x. The card is sized from this rather than from a fixed height, because a
  /// fixed 232dp clipped the title by 33px at 2.0x text scale: the same trap the
  /// swipe legend fell into.
  static const double _textBlockHeight = 76;

  /// Card height at the current text scale. The thumbnail is a fixed 16:9 (an image
  /// does not need to grow); everything below it is text, so it does.
  static double cardHeightFor(BuildContext context) =>
      cardWidth * 9 / 16 +
      _textBlockHeight * MediaQuery.textScalerOf(context).scale(1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // `currentUserProvider` is the signed-in Firebase user, so this follows a
    // sign-out without the host screen having to be rebuilt by hand.
    final String? email = ref.watch(currentUserProvider)?.email;
    if (!BirthdayPlaylist.isFor(email)) return const SizedBox.shrink();

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: _buildTag(isDark),
          ),
          SizedBox(
            height: cardHeightFor(context),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: BirthdayPlaylist.videos.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (BuildContext context, int index) => _buildCard(
                context,
                isDark,
                BirthdayPlaylist.videos[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The tag itself: the app's badge vocabulary (`accentFire` on 12% of itself, which
  /// is how "VIDEO OF THE DAY" is drawn), one size up — this one is a message rather
  /// than a label.
  Widget _buildTag(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.accentFire.withValues(alpha: isDark ? 0.20 : 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.accentFire.withValues(alpha: 0.45)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('🎂', style: TextStyle(fontSize: 18, height: 1)),
          SizedBox(width: 8),
          // Flexible, not a bare Text: the tag is longer than any label this badge
          // was drawn for, and at 2.0x text scale it has to wrap rather than overflow
          // the chip.
          Flexible(
            child: Text(
              BirthdayPlaylist.tag,
              style: TextStyle(
                color: AppTheme.accentFire,
                fontWeight: FontWeight.w900,
                fontSize: 17,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, bool isDark, YoutubeVideo video) {
    return SizedBox(
      width: cardWidth,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          // `SwipeBackPageRoute`: the app's own route, which carries the iOS-style
          // swipe-back gesture every other push in the app has. The motion guard
          // (`test/core/motion_guard_test.dart`) ratchets bare Material routes
          // downwards for exactly that reason.
          SwipeBackPageRoute<void>(
            builder: (_) => SmartMediaDeskScreen(video: video),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppTheme.cardBgOf(context),
            border: Border.all(
              color:
                  isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        video.highThumbnailUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) =>
                            progress == null ? child : _placeholder(isDark),
                        // `maxresdefault` does not exist for every video — YouTube
                        // answers 404 for plenty of them, two of the four on this shelf
                        // included — while `hqdefault` almost always does. So the
                        // fallback is the other thumbnail, and only *then* the
                        // placeholder: a card that shows a grey hole for a video whose
                        // frame exists is a card that looks broken on her birthday.
                        errorBuilder: (context, error, stackTrace) => Image.network(
                          video.mediumThumbnailUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) =>
                              progress == null ? child : _placeholder(isDark),
                          errorBuilder: (context, error, stackTrace) =>
                              _placeholder(isDark),
                        ),
                      ),
                      const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          size: 44,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
                  child: Text(
                    video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    video.channelTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _placeholder(bool isDark) => ColoredBox(
        color: isDark ? const Color(0xFF1E2430) : const Color(0xFFE8E0D2),
        child: const Center(
          child: Icon(Icons.music_note, color: Colors.white24, size: 32),
        ),
      );
}
