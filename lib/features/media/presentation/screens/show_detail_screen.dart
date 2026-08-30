import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/models/youtube_video.dart';
import '../../data/repositories/show_repository.dart';
import '../../../../shared/routes/swipe_back_route.dart';
import 'smart_media_desk_screen.dart';
import '../providers/show_progress_provider.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/services/localized_catalog_service.dart';

final showEpisodesProvider = FutureProvider.family<List<YoutubeVideo>, String>((ref, showId) {
  final repo = ref.watch(showRepositoryProvider);
  return repo.fetchEpisodes(showId);
});

class ShowDetailScreen extends ConsumerWidget {
  final Show show;

  const ShowDetailScreen({super.key, required this.show});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final episodesAsync = ref.watch(showEpisodesProvider(show.id));
    final savedShows = ref.watch(savedShowsProvider);
    final isBookmarked = savedShows.contains(show.id);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A0B) : const Color(0xFFFDFCF0),
      body: CustomScrollView(
        slivers: [
          // Hero header with backdrop
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: isDark ? const Color(0xFF0A0A0B) : const Color(0xFFFDFCF0),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black54 : Colors.black26,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.arrow_back_ios_new,
                    color: isDark ? Colors.white : const Color(0xFF1A1A1B), size: 18),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              // Bookmark button
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black54 : Colors.black26,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked
                        ? Colors.amber
                        : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                    size: 20,
                  ),
                ),
                onPressed: () {
                  ref.read(savedShowsProvider.notifier).toggle(show.id);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Backdrop image
                  CachedNetworkImage(
                    imageUrl: show.thumbnailUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: isDark ? const Color(0xFF1A1A2E) : const Color(0xFFE8E4D9),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: isDark ? const Color(0xFF1A1A2E) : const Color(0xFFE8E4D9),
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          (isDark ? const Color(0xFF0A0A0B) : const Color(0xFFFDFCF0))
                              .withValues(alpha: 0.7),
                          isDark ? const Color(0xFF0A0A0B) : const Color(0xFFFDFCF0),
                        ],
                      ),
                    ),
                  ),
                  // Show info at bottom
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          show.title,
                          style: TextStyle(
                            color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (isDark ? Colors.amber : const Color(0xFF8B6914))
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: (isDark ? Colors.amber : const Color(0xFF8B6914))
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              child: Text(
                                show.genre,
                                style: TextStyle(
                                  color: isDark ? Colors.amber : const Color(0xFF8B6914),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.playlist_play,
                                color: isDark ? Colors.grey[400] : Colors.grey.shade600,
                                size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${show.episodeCount} episodes',
                              style: TextStyle(
                                color: isDark ? Colors.grey[400] : Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          show.channelTitle,
                          style: TextStyle(
                            color: isDark ? Colors.grey[500] : Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Summary (pre-generated 4-sentence English blurb)
          if (show.summary != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1A1A2E)
                        : const Color(0xFFF7F4E4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.07)
                          : const Color(0xFFD4CFB8).withValues(alpha: 0.5),
                    ),
                  ),
                  child: FutureBuilder<String>(
                    future: LocalizedCatalogService.getShowSummary(
                      showTitle: show.title,
                      localeCode: Localizations.localeOf(context).languageCode,
                      fallbackEn: show.summary!,
                    ),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? show.summary!,
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey[300]
                              : const Color(0xFF4A4A3B),
                          fontSize: 13,
                          height: 1.55,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          // Episode list
          episodesAsync.when(
            loading: () => SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: isDark ? Colors.amber : const Color(0xFF8B6914),
                ),
              ),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 40),
                    const SizedBox(height: 12),
                    Text(AppLocalizations.of(context)!.failedToLoadEpisodes,
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey.shade700,
                        )),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.invalidate(showEpisodesProvider(show.id)),
                      child: Text(AppLocalizations.of(context)!.retry,
                          style: TextStyle(
                            color: isDark ? Colors.amber : const Color(0xFF8B6914),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            data: (episodes) {
              if (episodes.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.noEpisodesFound,
                        style: TextStyle(
                          color: isDark ? Colors.grey[500] : Colors.grey.shade600,
                        )),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final episode = episodes[index];
                    return _EpisodeTile(
                      episode: episode,
                      episodeNumber: index + 1,
                      onTap: () {
                        Navigator.of(context).push(
                          SwipeBackPageRoute(
                            builder: (_) => SmartMediaDeskScreen(
                              video: episode,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: episodes.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EpisodeTile extends ConsumerWidget {
  final YoutubeVideo episode;
  final int episodeNumber;
  final VoidCallback onTap;

  const _EpisodeTile({
    required this.episode,
    required this.episodeNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final duration = episode.duration ?? Duration.zero;
    final durationStr = '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    final watchedEpisodes = ref.watch(watchedEpisodesProvider);
    final isWatched = watchedEpisodes.contains(episode.id);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            // Episode number
            SizedBox(
              width: 32,
              child: Text(
                '$episodeNumber',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: episode.mediumThumbnailUrl,
                    width: 120,
                    height: 68,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      width: 120,
                      height: 68,
                      color: isDark ? const Color(0xFF2A2A3E) : const Color(0xFFE8E4D9),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: 120,
                      height: 68,
                      color: isDark ? const Color(0xFF2A2A3E) : const Color(0xFFE8E4D9),
                      child: Icon(Icons.broken_image,
                          color: isDark ? Colors.grey : Colors.grey.shade500, size: 24),
                    ),
                  ),
                  if (isWatched)
                    Positioned.fill(
                      child: Container(
                        color: isDark ? Colors.black54 : Colors.black26,
                        child: Center(
                          child: Icon(Icons.check_circle,
                              color: isDark ? Colors.amber : const Color(0xFF8B6914),
                              size: 28),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Title and duration
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isWatched
                          ? (isDark ? Colors.grey[600] : Colors.grey.shade500)
                          : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (duration != Duration.zero) ...[
                    const SizedBox(height: 4),
                    Text(
                      durationStr,
                      style: TextStyle(
                        color: isDark ? Colors.grey[600] : Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Mark as watched button
            GestureDetector(
              onTap: () {
                ref.read(watchedEpisodesProvider.notifier).toggle(episode.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isWatched ? Icons.check_circle : Icons.check_circle_outline,
                  color: isWatched
                      ? (isDark ? Colors.amber : const Color(0xFF8B6914))
                      : (isDark ? Colors.grey[600] : Colors.grey.shade500),
                  size: 28,
                ),
              ),
            ),
            // Play icon
            Icon(Icons.play_circle_outline,
                color: isDark ? Colors.grey[600] : Colors.grey.shade500, size: 28),
          ],
        ),
      ),
    );
  }
}