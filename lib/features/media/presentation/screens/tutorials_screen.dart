/// The **Tutorials** tab: hand-picked teaching shelves, played from YouTube.
///
/// Everything here is additive and fully compliant on purpose — see
/// `tutorials_repository.dart` for the rules the data layer follows. On screen
/// that means three visible commitments:
///
///  1. **Attribution.** Every row names the channel that made the video, and the
///     watch page is one tap away ("Open in YouTube").
///  2. **No extraction.** The tab shows a title, a channel, a duration and a
///     thumbnail *link*. Nothing is downloaded, no captions are fetched, and the
///     player is YouTube's own (see `tutorial_player_screen.dart`).
///  3. **Disclosure.** The footer states that the videos are hosted and played by
///     YouTube and links Google's privacy policy, which is what the API Services
///     Terms require an API client to surface.
///
/// The topics are existing app strings (`beginner`, `pronunciation`,
/// `strokeOrderChip`, `listening1`, `grammar`), so the shelf is localised without
/// inventing a parallel vocabulary for it.
library;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/media/data/repositories/tutorials_repository.dart';
import 'package:hanzi_master/features/media/data/tutorial_queries.dart';
import 'package:hanzi_master/features/media/domain/models/tutorial_video.dart';
import 'package:hanzi_master/features/media/presentation/screens/tutorial_player_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/zen_filter_pill.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

/// One shelf: what to ask YouTube for, and what to call it on screen.
class _Topic {
  const _Topic(this.query, this.label);

  final String query;
  final String label;
}

class TutorialsScreen extends ConsumerStatefulWidget {
  const TutorialsScreen({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  ConsumerState<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends ConsumerState<TutorialsScreen> {
  int _topicIndex = 0;
  TutorialResult? _result;
  bool _isLoading = true;
  String? _languageCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String locale = Localizations.localeOf(context).languageCode;
    if (_languageCode == locale) return;

    final bool isFirstLoad = _languageCode == null;
    _languageCode = locale;
    if (!isFirstLoad) {
      // A different audience language is a different shelf, not a translation:
      // the cached answers belong to the language they were asked in.
      TutorialsRepository.clearCache();
    }

    // Deferred to a frame: `didChangeDependencies` runs inside the build phase,
    // and the first shelf has to be fetched with the real locale already known —
    // not with the 'en' fallback an `initState` call would have used.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _load();
    });
  }

  List<_Topic> _topics(AppLocalizations l10n) => <_Topic>[
        _Topic(TutorialQueries.beginner, l10n.beginner),
        _Topic(TutorialQueries.pronunciation, l10n.pronunciation),
        _Topic(TutorialQueries.strokeOrder, l10n.strokeOrderChip),
        _Topic(TutorialQueries.listening, l10n.listening1),
        _Topic(TutorialQueries.grammar, l10n.grammar),
      ];

  Future<void> _load() async {
    final List<_Topic> topics = _topics(AppLocalizations.of(context)!);
    setState(() {
      _isLoading = true;
      _result = null;
    });

    final TutorialResult result = await TutorialsRepository(
      apiKeyPool: ref.read(apiKeyPoolProvider),
    ).shelf(
      query: topics[_topicIndex].query,
      languageCode: _languageCode ?? 'en',
    );

    if (!mounted) return;
    setState(() {
      _result = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.surfaceOf(context),
      body: CalligraphyBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(context, theme, l10n),
              _buildTopicBar(_topics(l10n), isDark),
              const SizedBox(height: 8),
              Expanded(child: _buildShelf(theme, l10n)),
              _buildDisclosure(theme, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
      child: Row(
        children: [
          if (widget.showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () => Navigator.pop(context),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.tutorialsTab,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _topicSubtitle(l10n),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// `Beginner · Pronunciation · Stroke order` — built from the app's own
  /// strings, so the shelf describes itself in every locale without new
  /// vocabulary.
  String _topicSubtitle(AppLocalizations l10n) =>
      _topics(l10n).take(3).map((_Topic t) => t.label).join(' · ');

  Widget _buildTopicBar(List<_Topic> topics, bool isDark) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: topics.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) => Center(
          child: ZenFilterPill(
            label: topics[index].label,
            isSelected: index == _topicIndex,
            isDark: isDark,
            onTap: () {
              if (index == _topicIndex) return;
              setState(() => _topicIndex = index);
              _load();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShelf(ThemeData theme, AppLocalizations l10n) {
    if (_isLoading) {
      return Center(
        child: ZenLoader(
          label: l10n.searchingYoutube,
          color: theme.colorScheme.primary,
        ),
      );
    }

    final TutorialResult? result = _result;
    if (result == null ||
        result.unavailable ||
        result.failed ||
        result.isEmpty) {
      return _buildEmptyState(theme, l10n, showRetry: result?.failed ?? false);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      itemCount: result.videos.length,
      itemBuilder: (BuildContext context, int index) =>
          _buildVideoCard(result.videos[index], theme),
    );
  }

  Widget _buildEmptyState(
    ThemeData theme,
    AppLocalizations l10n, {
    required bool showRetry,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 40,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.noVideosFound,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            if (showRetry) ...[
              const SizedBox(height: 12),
              BouncingButton(
                onPressed: _load,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    l10n.tryAgain,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// A tutorial row. The thumbnail is **linked** from `i.ytimg.com` (never
  /// re-hosted), the channel is named, the duration is labelled, and there are
  /// two ways in: play here in YouTube's player, or open the watch page.
  Widget _buildVideoCard(TutorialVideo video, ThemeData theme) {
    final bool isDark = theme.brightness == Brightness.dark;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BouncingButton(
        scaleFactor: 0.99,
        onPressed: () => Navigator.push(
          context,
          SwipeBackRoute(
            builder: (BuildContext context) =>
                TutorialPlayerScreen(video: video),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF222224) : AppTheme.cardBgLight,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.07),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(18)),
                child: SizedBox(
                  width: 120,
                  height: 78,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: video.thumbnailUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.06),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.06),
                        ),
                      ),
                      const Center(
                        child: Icon(Icons.play_circle_fill,
                            color: Colors.white, size: 34),
                      ),
                      if (video.durationLabel != null)
                        Positioned(
                          right: 4,
                          bottom: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.72),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              video.durationLabel!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // The attribution the terms require, next to the video.
                      Text(
                        video.channelTitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.open_in_new, size: 18),
                tooltip: l10n.openInYoutube,
                onPressed: () => openExternalLink(video.watchUrl),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The disclosure the API Services Terms ask an API client to surface: the
  /// videos are YouTube's, and Google's privacy policy is one tap away.
  Widget _buildDisclosure(ThemeData theme, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 14,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.youtubeHostedNotice,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 2),
                GestureDetector(
                  onTap: () => openExternalLink(
                    'https://policies.google.com/privacy',
                  ),
                  child: Text(
                    l10n.privacyPolicy,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
