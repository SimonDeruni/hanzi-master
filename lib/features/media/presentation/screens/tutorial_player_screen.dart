/// One tutorial, played in YouTube's own player.
///
/// The compliance surface of the whole tab is here, so it is small on purpose:
///
///  * playback goes through the **official IFrame player**, so the video is
///    streamed by YouTube with its ads, analytics and branding intact,
///  * the player is never obscured, miniaturised or overlaid — YouTube's own
///    controls stay visible, which is also what a learner needs for captions,
///  * `strictRelatedVideos` keeps the end screen from turning a grammar lesson
///    into unrelated recommendations,
///  * the channel that made the video is named, and the watch page is one tap
///    away, which is the attribution the terms require,
///  * nothing is downloaded, recorded or separated into audio — there is no
///    such call anywhere in this feature.
library;

import 'package:flutter/material.dart';
import 'package:hanzi_master/features/media/domain/models/tutorial_video.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/// Opens a YouTube watch/terms/privacy page outside the app.
Future<void> openExternalLink(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not open $url');
  }
}

class TutorialPlayerScreen extends StatefulWidget {
  const TutorialPlayerScreen({super.key, required this.video});

  final TutorialVideo video;

  @override
  State<TutorialPlayerScreen> createState() => _TutorialPlayerScreenState();
}

class _TutorialPlayerScreenState extends State<TutorialPlayerScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.video.id,
      autoPlay: true,
      params: const YoutubePlayerParams(
        // YouTube's own controls, visible: the player must not be replaced by a
        // custom chrome, and captions/quality have to stay reachable.
        showControls: true,
        showFullscreenButton: true,
        showVideoAnnotations: false,
        enableCaption: true,
        // A teaching video should not end in unrelated recommendations.
        strictRelatedVideos: true,
        playsInline: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TutorialVideo video = widget.video;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          video.channelTitle,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 16:9, unobscured, black letterbox around it.
            YoutubePlayer(controller: _controller, aspectRatio: 16 / 9),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      video.channelTitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (video.durationLabel != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        video.durationLabel!,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.white54),
                      ),
                    ],
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      onPressed: () => openExternalLink(video.watchUrl),
                      icon: const Icon(Icons.open_in_new, size: 18),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white38),
                      ),
                      label: Text(AppLocalizations.of(context)!.openInYoutube),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
