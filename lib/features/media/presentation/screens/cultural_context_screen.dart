import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';
import 'package:hanzi_master/features/media/presentation/providers/cultural_context_provider.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/smart_media_desk_screen.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

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

    // Keep the hero image substantial but never dominant: a fixed 350px header
    // swallowed half the screen and forced a small source bitmap to upscale.
    final heroHeight =
        (MediaQuery.of(context).size.height * 0.32).clamp(200.0, 280.0);

    return Scaffold(
      backgroundColor: AppTheme.surfaceOf(context),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: heroHeight,
                  pinned: true,
                  // Disabled: stretching zoomed the bitmap and amplified blur.
                  stretch: false,
                  backgroundColor: AppTheme.surfaceOf(context),
                  surfaceTintColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: mediaItem.imageUrl,
                          fit: BoxFit.cover,
                          // Rendering at device pixel ratio keeps the bitmap
                          // sharp instead of letting it decode undersized.
                          filterQuality: FilterQuality.medium,
                          memCacheWidth: (MediaQuery.of(context).size.width *
                                  MediaQuery.of(context).devicePixelRatio)
                              .round(),
                          fadeInDuration: ZenMotion.swap,
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
                                AppTheme.surfaceOf(context),
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
                        color:
                            AppTheme.surfaceOf(context).withValues(alpha: 0.5),
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
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            // Book-screen badge vocabulary.
                            color: AppTheme.accentOf(context)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppTheme.accentOf(context)
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            mediaItem.tag.toUpperCase(),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: AppTheme.accentOf(context),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
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
                            color: AppTheme.accentOf(context),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Icon(Icons.auto_awesome,
                                color: AppTheme.accentOf(context), size: 24),
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
                                    child: ZenLoader()),
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
              color: AppTheme.surfaceOf(context),
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
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? Colors.amber.shade700 : const Color(0xFF1A1A1B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)!.diveIntoFullContent,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 22),
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
    final baseStyle = theme.textTheme.bodyLarge?.copyWith(
      height: 1.8,
      fontSize: 17,
      color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
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
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 8),
                child: Text('•', style: baseStyle),
              ),
              Expanded(
                child: TappableMarkdownHanziText(
                  bulletContent,
                  style: baseStyle,
                  quickLookPresentation: QuickLookPresentation.readingPopover,
                ),
              ),
            ],
          ),
        ));
        continue;
      }

      // Regular paragraph
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: TappableMarkdownHanziText(
          trimmed,
          style: baseStyle,
          quickLookPresentation: QuickLookPresentation.readingPopover,
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  /// Legacy renderer — kept for backward compatibility with non-structured text.
  Widget _buildClickableContext(
      BuildContext context, String text, ThemeData theme,
      {TextStyle? customBaseStyle, TextStyle? customHanziStyle}) {
    final paragraphs = text.split('\n\n');
    final baseStyle =
        customBaseStyle ?? theme.textTheme.bodyLarge?.copyWith(height: 1.6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((p) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TappableMarkdownHanziText(
            p,
            style: baseStyle,
            quickLookPresentation: QuickLookPresentation.readingPopover,
          ),
        );
      }).toList(),
    );
  }
}
