import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';
import 'package:hanzi_master/features/media/presentation/providers/cultural_context_provider.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/smart_media_desk_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class CulturalContextScreen extends ConsumerWidget {
  final DailyMediaItem mediaItem;

  const CulturalContextScreen({super.key, required this.mediaItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final encodedParam = '${mediaItem.title}|||${mediaItem.subtitle}';
    final culturalContextAsync =
        ref.watch(culturalContextProvider(encodedParam));

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 350,
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
                          placeholder: (context, url) =>
                              Container(color: Colors.black12),
                          errorWidget: (context, url, error) =>
                              Container(color: Colors.black12),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(
                                    alpha: 0.5), // For status bar visibility
                                Colors.transparent,
                                theme.colorScheme.surface,
                              ],
                              stops: const [0.0, 0.4, 1.0],
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
                        color: theme.colorScheme.surface.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back,
                          color: theme.colorScheme.onSurface),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 140.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            mediaItem.tag.toUpperCase(),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildClickableContext(
                          context,
                          mediaItem.title,
                          theme,
                          customBaseStyle:
                              theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'NotoSerifSC',
                            height: 1.4,
                          ),
                          customHanziStyle:
                              theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'NotoSerifSC',
                            color: theme.colorScheme.primary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Icon(Icons.auto_awesome,
                                color: theme.colorScheme.primary, size: 24),
                            const SizedBox(width: 12),
                            Text(
                              AppLocalizations.of(context)!.culturalInsight,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        culturalContextAsync.when(
                          data: (text) => _buildStructuredInsight(
                            context,
                            text,
                            theme,
                          ),
                          loading: () => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Center(
                                    child: CircularProgressIndicator()),
                                const SizedBox(height: 24),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .aiIsAnalyzingCulturalContext,
                                    style: TextStyle(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.5),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          error: (err, stack) => Text(
                            AppLocalizations.of(context)!
                                .failedToLoadCulturalInsight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sticky Footer CTA
          Container(
            padding: EdgeInsets.fromLTRB(
                24, 16, 24, MediaQuery.of(context).padding.bottom + 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: BouncingButton(
              onPressed: () async {
                if (mediaItem.url.contains("youtube.com") ||
                    mediaItem.url.contains("youtu.be")) {
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
                    final uri = Uri.tryParse(mediaItem.url);
                    if (uri != null) {
                      launchUrl(uri, mode: LaunchMode.externalApplication);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .unable_to_open_this_video_please)),
                      );
                    }
                  }
                } else {
                  Navigator.pushReplacement(
                    context,
                    SwipeBackPageRoute(
                      builder: (_) =>
                          WebBrowserScreen(initialUrl: mediaItem.url),
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.diveIntoFullContent,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward,
                        color: theme.colorScheme.onPrimary),
                  ],
                ),
              ),
            ),
          ),
        ],
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
      if (uri.pathSegments.contains('embed') ||
          uri.pathSegments.contains('v')) {
        return uri.pathSegments.last;
      }
    }

    return null;
  }

  /// Parses AI-generated structured insight text with ## headings, - bullets, and **bold**.
  Widget _buildStructuredInsight(
      BuildContext context, String text, ThemeData theme) {
    final lines = text.split('\n');
    final RegExp chineseRegex = RegExp(r'[\u4e00-\u9fa5]');

    final baseStyle = theme.textTheme.bodyLarge?.copyWith(
      height: 1.8,
      fontSize: 17,
      color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
    );
    final hanziStyle = theme.textTheme.bodyLarge?.copyWith(
      height: 1.8,
      fontSize: 17,
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.w600,
    );
    final headingStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 18,
      color: theme.colorScheme.onSurface,
      height: 1.4,
    );

    final List<Widget> widgets = [];

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      // Subheading: "## Something"
      if (trimmed.startsWith('## ')) {
        final heading = trimmed.substring(3).trim();
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 12),
          child: Text(heading, style: headingStyle),
        ));
        continue;
      }

      // Bullet point: "- Something"
      if (trimmed.startsWith('- ')) {
        final bulletContent = trimmed.substring(2).trim();
        final spans = _buildRichSpans(bulletContent, baseStyle!, hanziStyle!,
            chineseRegex, context, theme);
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 8),
                child: Text('•', style: baseStyle),
              ),
              Expanded(child: RichText(text: TextSpan(children: spans))),
            ],
          ),
        ));
        continue;
      }

      // Regular paragraph
      final spans = _buildRichSpans(
          trimmed, baseStyle!, hanziStyle!, chineseRegex, context, theme);
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: RichText(text: TextSpan(children: spans)),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  /// Builds a list of [TextSpan] from raw text, making Chinese characters tappable
  /// and preserving **bold** markers.
  List<TextSpan> _buildRichSpans(
    String text,
    TextStyle baseStyle,
    TextStyle hanziStyle,
    RegExp chineseRegex,
    BuildContext context,
    ThemeData theme,
  ) {
    // First, strip ** markers and track bold ranges
    final List<_BoldRange> boldRanges = [];
    final StringBuffer cleanBuffer = StringBuffer();
    bool insideBold = false;

    for (int i = 0; i < text.length; i++) {
      if (i + 1 < text.length && text[i] == '*' && text[i + 1] == '*') {
        insideBold = !insideBold;
        i++; // skip second *
        if (insideBold) {
          // Record start of bold region
          boldRanges.add(_BoldRange(start: cleanBuffer.length, end: -1));
        } else {
          // Close the last opened bold range
          for (int j = boldRanges.length - 1; j >= 0; j--) {
            if (boldRanges[j].end == -1) {
              boldRanges[j] = _BoldRange(
                  start: boldRanges[j].start, end: cleanBuffer.length);
              break;
            }
          }
        }
      } else {
        cleanBuffer.write(text[i]);
      }
    }

    final cleanText = cleanBuffer.toString();
    final List<TextSpan> spans = [];

    for (int i = 0; i < cleanText.length; i++) {
      final char = cleanText[i];
      bool isInsideBoldRange = boldRanges.any((r) => i >= r.start && i < r.end);

      final effectiveStyle = isInsideBoldRange
          ? (chineseRegex.hasMatch(char) ? hanziStyle : baseStyle)
              .copyWith(fontWeight: FontWeight.w800)
          : chineseRegex.hasMatch(char)
              ? hanziStyle
              : baseStyle;

      if (chineseRegex.hasMatch(char)) {
        spans.add(TextSpan(
          text: char,
          style: effectiveStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              showQuickLook(context, char);
            },
        ));
      } else {
        spans.add(TextSpan(text: char, style: effectiveStyle));
      }
    }

    return spans;
  }

  /// Legacy renderer — kept for backward compatibility with non-structured text.
  Widget _buildClickableContext(
      BuildContext context, String text, ThemeData theme,
      {TextStyle? customBaseStyle, TextStyle? customHanziStyle}) {
    final paragraphs = text.split('\n\n');
    final RegExp chineseRegex = RegExp(r'[\u4e00-\u9fa5]');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((p) {
        var content = p.replaceAll(RegExp(r'^#+\s+'), '');
        content = content.replaceAll('**', '');

        final List<TextSpan> spans = [];
        final baseStyle =
            customBaseStyle ?? theme.textTheme.bodyLarge?.copyWith(height: 1.6);
        final hanziStyle = customHanziStyle ??
            baseStyle?.copyWith(
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

/// Small helper to hold bold region boundaries in the cleaned text.
class _BoldRange {
  final int start;
  final int end;
  const _BoldRange({required this.start, required this.end});
}
