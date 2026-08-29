import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/repositories/show_repository.dart';
import '../../../../shared/routes/swipe_back_route.dart';
import '../../../../core/presentation/widgets/zen_search_bar.dart';
import 'show_detail_screen.dart';
import '../providers/show_progress_provider.dart';

final showsProvider = FutureProvider<Map<ShowGenre, List<Show>>>((ref) {
  final repo = ref.watch(showRepositoryProvider);
  return repo.fetchAllShows();
});

class ShowCatalogScreen extends ConsumerStatefulWidget {
  const ShowCatalogScreen({super.key});

  @override
  ConsumerState<ShowCatalogScreen> createState() => _ShowCatalogScreenState();
}

class _ShowCatalogScreenState extends ConsumerState<ShowCatalogScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showsAsync = ref.watch(showsProvider);
    final savedShows = ref.watch(savedShowsProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A0B) : const Color(0xFFFDFCF0),
      body: showsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.amber),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 12),
              Text('Failed to load shows', style: TextStyle(color: Colors.grey[400])),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(showsProvider),
                child: const Text('Retry', style: TextStyle(color: Colors.amber)),
              ),
            ],
          ),
        ),
        data: (showsByGenre) {
          if (showsByGenre.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.tv_off, color: Colors.grey[600], size: 48),
                  const SizedBox(height: 12),
                  Text('No shows available', style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                ],
              ),
            );
          }

          final allShows = showsByGenre.values.expand((shows) => shows).toSet().toList();

          // Filtering logic
          final filteredShows = allShows.where((show) {
            final matchesQuery = _searchQuery.isEmpty ||
                show.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                show.tags.any((tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()));
            return matchesQuery;
          }).toList();

          final isFiltering = _searchQuery.isNotEmpty;

          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ZenSearchBar(
                  controller: _searchController,
                  hintText: 'Search by title or tag...',
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              
              const SizedBox(height: 8),

              // Content Area
              Expanded(
                child: isFiltering
                    ? (filteredShows.isEmpty
                        ? Center(
                            child: Text(
                              'No shows found',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: filteredShows.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: _ShowCard(show: filteredShows[index], isWide: true),
                                ),
                              );
                            },
                          ))
                    : ListView.builder(
                        itemCount: showsByGenre.keys.length + 1,
                        itemBuilder: (context, index) {
                          // Show bookmarked shows section at top if any exist
                          final bookmarkedShows = allShows
                              .where((show) => savedShows.contains(show.id))
                              .toList();

                          if (index == 0) {
                            if (bookmarkedShows.isEmpty) return const SizedBox.shrink();
                            return _BookmarkedRow(shows: bookmarkedShows);
                          }

                          final genreIndex = index - 1;
                          final genre = showsByGenre.keys.elementAt(genreIndex);
                          final rawShows = showsByGenre[genre]!;
                          final shows = rawShows;
                          if (shows.isEmpty) return const SizedBox.shrink();
                          return _GenreRow(genre: genre, shows: shows);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BookmarkedRow extends StatelessWidget {
  final List<Show> shows;

  const _BookmarkedRow({required this.shows});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(Icons.bookmark, color: Colors.amber, size: 18),
              SizedBox(width: 6),
              Text(
                'Bookmarked',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: shows.length,
            itemBuilder: (context, index) {
              return _ShowCard(show: shows[index]);
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _GenreRow extends StatelessWidget {
  final ShowGenre genre;
  final List<Show> shows;

  const _GenreRow({required this.genre, required this.shows});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            genre.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: shows.length,
            itemBuilder: (context, index) {
              return _ShowCard(show: shows[index]);
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _ShowCard extends ConsumerWidget {
  final Show show;
  final bool isWide;

  const _ShowCard({required this.show, this.isWide = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedShows = ref.watch(savedShowsProvider);
    final isBookmarked = savedShows.contains(show.id);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          SwipeBackPageRoute(
            builder: (_) => ShowDetailScreen(show: show),
          ),
        );
      },
      child: Container(
        width: isWide ? double.infinity : 140,
        margin: EdgeInsets.symmetric(horizontal: isWide ? 0 : 4),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with bookmark badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: show.thumbnailUrl,
                    height: 100,
                    width: isWide ? double.infinity : 140,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      height: 100,
                      width: isWide ? double.infinity : 140,
                      color: const Color(0xFF2A2A3E),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      height: 100,
                      width: isWide ? double.infinity : 140,
                      color: const Color(0xFF2A2A3E),
                      child: const Icon(Icons.broken_image, color: Colors.grey, size: 28),
                    ),
                  ),
                ),
                if (show.subtitleType == SubtitleType.soft)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.teal.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'CC',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                if (show.tags.contains('Trailer') || show.tags.contains('Highlight'))
                  Positioned(
                    top: 4,
                    left: show.subtitleType == SubtitleType.soft ? 44 : 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: show.tags.contains('Trailer') 
                            ? Colors.redAccent.withValues(alpha: 0.9)
                            : Colors.purpleAccent.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        show.tags.contains('Trailer') ? 'TRAILER' : 'HIGHLIGHT',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                if (isBookmarked)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.bookmark, color: Colors.amber, size: 14),
                    ),
                  ),
              ],
            ),
            // Title and episode count
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    show.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${show.episodeCount} episodes',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}