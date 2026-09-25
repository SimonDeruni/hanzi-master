import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hanzi_master/features/media/domain/logic/insight_sections.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';
import 'package:hanzi_master/features/media/presentation/providers/cultural_context_provider.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
import 'package:hanzi_master/features/media/presentation/screens/smart_media_desk_screen.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/shared/widgets/staggered_list_item.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

/// Article / Video of the Day briefing.
///
/// Reads as a sibling of the book screens: inset rounded hero card, shared
/// badge vocabulary, shared card container, same footer CTA treatment. The
/// daily AI briefing is split into its two meaningful halves — a Summary and
/// the cultural context — instead of being dumped as one wall of text.
class CulturalContextScreen extends ConsumerWidget {
  final DailyMediaItem mediaItem;

  const CulturalContextScreen({super.key, required this.mediaItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;
    final primaryText = theme.colorScheme.onSurface;
    final sourceHost = _hostOf(mediaItem.url);

    final encodedParam = '${mediaItem.title}|||${mediaItem.subtitle}';
    final culturalContextAsync =
        ref.watch(culturalContextProvider(encodedParam));

    return Scaffold(
      backgroundColor: AppTheme.surfaceOf(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            tooltip: l10n.diveIntoFullContent,
            icon: Icon(Icons.open_in_new_rounded, size: 20, color: primaryText),
            onPressed: () => _openSource(context, l10n),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StaggeredListItem(
                          index: 0,
                          child: _buildHeroCard(context, l10n, isDark),
                        ),
                        const SizedBox(height: 18),
                        StaggeredListItem(
                          index: 1,
                          child: _buildTitleBlock(context, theme),
                        ),
                        const SizedBox(height: 14),
                        StaggeredListItem(
                          index: 2,
                          child: _buildBadgeRow(context, l10n, sourceHost),
                        ),
                        const SizedBox(height: 22),
                        ...culturalContextAsync.when(
                          data: (text) => _buildInsightCards(
                            context,
                            theme,
                            l10n,
                            text,
                            isDark,
                          ),
                          loading: () => <Widget>[
                            _buildLoading(context, theme, l10n, isDark),
                          ],
                          error: (err, stack) => <Widget>[
                            _buildError(context, theme, l10n, isDark),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildFooter(context, l10n, isDark),
        ],
      ),
    );
  }

  // ── Hero image card ────────────────────────────────────────────────────────
  /// Inset rounded card with an overlay pill — the same treatment the book
  /// covers and the daily-discovery cards use, instead of a full-bleed app bar.
  Widget _buildHeroCard(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppTheme.cardBgOf(context),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (mediaItem.imageUrl.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: mediaItem.imageUrl,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  memCacheWidth: (MediaQuery.of(context).size.width *
                          MediaQuery.of(context).devicePixelRatio)
                      .round(),
                  fadeInDuration: ZenMotion.swap,
                  placeholder: (context, url) => _buildImageFallback(),
                  errorWidget: (context, url, error) => _buildImageFallback(),
                )
              else
                _buildImageFallback(),
              Positioned(
                top: 10,
                left: 10,
                child: _buildOverlayPill(
                  _localizedTag(l10n),
                  _isVideoUrl(mediaItem.url)
                      ? Icons.play_circle_fill
                      : Icons.article_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Warm dark slate placeholder, matching the hub's daily card fallback.
  Widget _buildImageFallback() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3A3229),
            Color(0xFF262220),
            Color(0xFF1E1E22),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.auto_stories,
          size: 44,
          color: Colors.white.withValues(alpha: 0.18),
        ),
      ),
    );
  }

  /// Dark translucent pill laid over the artwork.
  Widget _buildOverlayPill(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white.withValues(alpha: 0.75)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  /// Maps the raw feed tag to a localized label. Mirrors the mapping in
  /// `media_hub_screen.dart` so the badge no longer leaks the English tag.
  String _localizedTag(AppLocalizations l10n) {
    switch (mediaItem.tag) {
      case 'ARTICLE OF THE DAY':
        return l10n.articleOfTheDay;
      case 'VIDEO OF THE DAY':
        return l10n.videoOfTheDay;
      default:
        return mediaItem.tag;
    }
  }

  // ── Title block ────────────────────────────────────────────────────────────
  Widget _buildTitleBlock(BuildContext context, ThemeData theme) {
    final subtitle = mediaItem.subtitle.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TappableMarkdownHanziText(
          mediaItem.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: 'NotoSerifSC',
            height: 1.4,
            color: theme.colorScheme.onSurface,
          ),
          quickLookPresentation: QuickLookPresentation.readingPopover,
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 8),
          TappableMarkdownHanziText(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            quickLookPresentation: QuickLookPresentation.readingPopover,
          ),
        ],
      ],
    );
  }

  // ── Badge row ──────────────────────────────────────────────────────────────
  Widget _buildBadgeRow(
    BuildContext context,
    AppLocalizations l10n,
    String sourceHost,
  ) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _buildBadge(l10n.aiGenerated, AppTheme.accentOf(context)),
        if (sourceHost.isNotEmpty)
          _buildBadge(sourceHost, onSurface.withValues(alpha: 0.55)),
      ],
    );
  }

  /// Badge vocabulary shared with the book detail screen.
  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // ── Shared card container (same as the book detail screen) ─────────────────
  Widget _buildSectionCard({
    required BuildContext context,
    required bool isDark,
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    final accent = AppTheme.accentOf(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.cardBgOf(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  // ── AI briefing: Summary + cultural context ────────────────────────────────
  /// Renders the daily briefing as a Summary card followed by a cultural
  /// context card holding the remaining AI sections.
  ///
  /// Parsing lives in `domain/logic/insight_sections.dart` so the section
  /// contract can be unit tested without a live model call.
  List<Widget> _buildInsightCards(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
    String text,
    bool isDark,
  ) {
    final briefing = splitInsightBriefing(text);
    final summary = briefing.summary;
    final widgets = <Widget>[];

    if (summary != null) {
      widgets.add(
        _buildSectionCard(
          context: context,
          isDark: isDark,
          icon: Icons.auto_awesome,
          title: l10n.aiSummary,
          child: _buildInsightBody(context, theme, summary.lines),
        ),
      );
    }

    // No headings at all means the model returned prose; the whole response
    // then belongs under the cultural-context header.
    if (briefing.context.isNotEmpty) {
      if (widgets.isNotEmpty) widgets.add(const SizedBox(height: 14));
      widgets.add(
        _buildSectionCard(
          context: context,
          isDark: isDark,
          icon: Icons.history_edu,
          title: l10n.culturalInsight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < briefing.context.length; i++) ...[
                if (i > 0) const SizedBox(height: 18),
                if (briefing.context[i].hasHeading)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      briefing.context[i].heading,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.accentOf(context),
                      ),
                    ),
                  ),
                _buildInsightBody(context, theme, briefing.context[i].lines),
              ],
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  /// Renders `- bullets` and paragraphs, with **bold** and tappable hanzi.
  Widget _buildInsightBody(
    BuildContext context,
    ThemeData theme,
    List<String> lines,
  ) {
    final baseStyle = theme.textTheme.bodyLarge?.copyWith(
      height: 1.8,
      fontSize: 16,
      color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
    );

    final widgets = <Widget>[];
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith('##')) continue;

      if (trimmed.startsWith('- ')) {
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
                  trimmed.substring(2).trim(),
                  style: baseStyle,
                  quickLookPresentation: QuickLookPresentation.readingPopover,
                ),
              ),
            ],
          ),
        ));
        continue;
      }

      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 12),
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

  // ── Loading / error ────────────────────────────────────────────────────────
  Widget _buildLoading(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
      decoration: BoxDecoration(
        color: AppTheme.cardBgOf(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(child: ZenLoader()),
          const SizedBox(height: 20),
          Center(
            child: Text(
              l10n.aiIsAnalyzingCulturalContext,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.cardBgOf(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.failedToLoadCulturalInsight,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  // ── Footer CTA ─────────────────────────────────────────────────────────────
  Widget _buildFooter(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).padding.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surfaceOf(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () => _openSource(context, l10n),
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
                  l10n.diveIntoFullContent,
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
    );
  }

  // ── Source handling ────────────────────────────────────────────────────────
  /// Opens the full article in the in-app reader, or the video desk for a
  /// YouTube source.
  Future<void> _openSource(BuildContext context, AppLocalizations l10n) async {
    if (_isVideoUrl(mediaItem.url)) {
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
        return;
      }

      final uri = Uri.tryParse(mediaItem.url);
      if (uri != null) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.unable_to_open_this_video_please)),
        );
      }
      return;
    }

    Navigator.pushReplacement(
      context,
      SwipeBackPageRoute(
        builder: (_) => WebBrowserScreen(initialUrl: mediaItem.url),
      ),
    );
  }

  bool _isVideoUrl(String url) =>
      url.contains('youtube.com') || url.contains('youtu.be');

  /// Bare host of the source URL, used for the attribution badge.
  String _hostOf(String url) {
    final host = Uri.tryParse(url)?.host ?? '';
    return host.startsWith('www.') ? host.substring(4) : host;
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
}
