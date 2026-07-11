import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';
import 'package:hanzi_master/features/media/presentation/providers/cultural_context_provider.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_search_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/smart_media_desk_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:url_launcher/url_launcher.dart';

class CulturalContextScreen extends ConsumerWidget {
  final DailyMediaItem mediaItem;

  const CulturalContextScreen({super.key, required this.mediaItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final culturalContextAsync = ref.watch(culturalContextProvider(mediaItem.title));

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            stretch: true,
            backgroundColor: theme.colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: mediaItem.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.black12),
                    errorWidget: (context, url, error) => Container(color: Colors.black12),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          theme.colorScheme.surface,
                        ],
                        stops: const [0.4, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      mediaItem.tag,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildClickableContext(
                    context, 
                    mediaItem.title, 
                    theme,
                    customBaseStyle: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'NotoSerifSC',
                    ),
                    customHanziStyle: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'NotoSerifSC',
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.amber, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        "Cultural Insight",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.03) : const Color(0xFFF9F7F1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                      ),
                    ),
                    child: culturalContextAsync.when(
                      data: (text) => _buildClickableContext(context, text, theme),
                      loading: () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          const Center(child: CircularProgressIndicator()),
                          const SizedBox(height: 24),
                          Text(
                            "AI is translating cultural context...",
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      error: (err, stack) => Text("Failed to load context: \$err"),
                    ),
                  ),
                  const SizedBox(height: 100), // padding for FAB
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BouncingButton(
        onPressed: () async {
          if (mediaItem.url.contains("youtube.com") || mediaItem.url.contains("youtu.be")) {
            // Extract video ID from URL and create a YoutubeVideo
            final videoId = _extractVideoId(mediaItem.url);
            if (videoId != null) {
              final video = YoutubeVideo(
                id: videoId,
                title: mediaItem.title,
                url: mediaItem.url,
                mediumThumbnailUrl: mediaItem.imageUrl,
                highThumbnailUrl: mediaItem.imageUrl,
                channelTitle: '',
              );
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                SwipeBackPageRoute(
                  builder: (_) => SmartMediaDeskScreen(video: video),
                ),
              );
            } else {
              // Fallback: open the video directly in YouTube app or browser
              final uri = Uri.tryParse(mediaItem.url);
              if (uri != null) {
                launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Unable to open this video. Please try again later.')),
                );
              }
            }
          } else {
            Navigator.pushReplacement(
              context,
              SwipeBackPageRoute(
                builder: (_) => WebBrowserScreen(initialUrl: mediaItem.url),
              ),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(vertical: 18),
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dive into Full Content",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: theme.colorScheme.onPrimary),
            ],
          ),
        ),
      ),
    );
  }

  /// Extract YouTube video ID from various URL formats
  String? _extractVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // youtu.be/VIDEO_ID
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    // youtube.com/watch?v=VIDEO_ID
    // youtube.com/embed/VIDEO_ID
    // youtube.com/v/VIDEO_ID
    if (uri.host.contains('youtube.com')) {
      if (uri.pathSegments.contains('watch')) {
        return uri.queryParameters['v'];
      }
      if (uri.pathSegments.contains('embed') || uri.pathSegments.contains('v')) {
        return uri.pathSegments.last;
      }
    }

    return null;
  }

  Widget _buildClickableContext(BuildContext context, String text, ThemeData theme, {TextStyle? customBaseStyle, TextStyle? customHanziStyle}) {
    final paragraphs = text.split('\n\n');
    final RegExp chineseRegex = RegExp(r'[\u4e00-\u9fa5]');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((p) {
        // Strip markdown hashes if present
        var content = p.replaceAll(RegExp(r'^#+\s+'), '');
        // Strip bold asterisks
        content = content.replaceAll('**', '');

        final List<TextSpan> spans = [];
        final baseStyle = customBaseStyle ?? theme.textTheme.bodyLarge?.copyWith(height: 1.6);
        final hanziStyle = customHanziStyle ?? baseStyle?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        );

        for (int i = 0; i < content.length; i++) {
          final char = content[i];
          if (chineseRegex.hasMatch(char)) {
            spans.add(TextSpan(
              text: char,
              style: hanziStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showQuickLook(context, char);
                },
            ));
          } else {
            spans.add(TextSpan(text: char, style: baseStyle));
          }
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: RichText(text: TextSpan(children: spans)),
        );
      }).toList(),
    );
  }
}