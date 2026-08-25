import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/models/youtube_video.dart';
import '../../data/repositories/show_repository.dart';
import '../../../../shared/routes/swipe_back_route.dart';
import 'smart_media_desk_screen.dart';
import '../providers/show_progress_provider.dart';

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
            backgroundColor: const Color(0xFF0A0A0B),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              // Bookmark button
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? Colors.amber : Colors.white,
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
                    placeholder: (_, __) => Container(color: const Color(0xFF1A1A2E)),
                    errorWidget: (_, __, ___) => Container(color: const Color(0xFF1A1A2E)),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF0A0A0B).withValues(alpha: 0.7),
                          const Color(0xFF0A0A0B),
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
                          style: const TextStyle(
                            color: Colors.white,
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
                                color: Colors.amber.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
                              ),
                              child: Text(
                                show.genre,
                                style: const TextStyle(color: Colors.amber, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.playlist_play, color: Colors.grey[400], size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${show.episodeCount} episodes',
                              style: TextStyle(color: Colors.grey[400], fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          show.channelTitle,
                          style: TextStyle(color: Colors.grey[500], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Episode list
          episodesAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: Colors.amber)),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 40),
                    const SizedBox(height: 12),
                    Text('Failed to load episodes', style: TextStyle(color: Colors.grey[400])),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.invalidate(showEpisodesProvider(show.id)),
                      child: const Text('Retry', style: TextStyle(color: Colors.amber)),
                    ),
                  ],
                ),
              ),
            ),
            data: (episodes) {
              if (episodes.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('No episodes found', style: TextStyle(color: Colors.grey[500])),
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
                  color: Colors.grey[500],
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
                      color: const Color(0xFF2A2A3E),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: 120,
                      height: 68,
                      color: const Color(0xFF2A2A3E),
                      child: const Icon(Icons.broken_image, color: Colors.grey, size: 24),
                    ),
                  ),
                  if (isWatched)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black54,
                        child: const Center(
                          child: Icon(Icons.check_circle, color: Colors.amber, size: 28),
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
                      color: isWatched ? Colors.grey[600] : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (duration != Duration.zero) ...[
                    const SizedBox(height: 4),
                    Text(
                      durationStr,
                      style: TextStyle(
                        color: Colors.grey[600],
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
                  color: isWatched ? Colors.amber : Colors.grey[600],
                  size: 28,
                ),
              ),
            ),
            // Play icon
            Icon(Icons.play_circle_outline, color: Colors.grey[600], size: 28),
          ],
        ),
      ),
    );
  }
}