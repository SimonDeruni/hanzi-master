import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            genre.label,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'NotoSerifSC',
            ),
          ),
        ),
        SizedBox(
          height: 210,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
        width: isWide ? double.infinity : 150,
        margin: EdgeInsets.symmetric(horizontal: isWide ? 0 : 4),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E22) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.04),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail with bookmark badge
              Stack(
                children: [
                  Image.network(
                    show.thumbnailUrl,
                    height: 105,
                    width: isWide ? double.infinity : 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // If the original URL failed and contains maxresdefault, attempt hqdefault
                      if (show.thumbnailUrl.contains('maxresdefault.jpg')) {
                        final fallbackUrl = show.thumbnailUrl.replaceAll('maxresdefault.jpg', 'hqdefault.jpg');
                        return Image.network(
                          fallbackUrl,
                          height: 105,
                          width: isWide ? double.infinity : 150,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholder(isDark, isWide),
                        );
                      }
                      return _buildPlaceholder(isDark, isWide);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 105,
                        width: isWide ? double.infinity : 150,
                        color: isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade200,
                      );
                    },
                  ),
                  if (show.subtitleType == SubtitleType.soft)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3252C7), // Blue CC badge matching media
                          borderRadius: BorderRadius.circular(5),
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
                      top: 6,
                      left: show.subtitleType == SubtitleType.soft ? 42 : 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: show.tags.contains('Trailer') 
                              ? Colors.redAccent.withValues(alpha: 0.9)
                              : Colors.purpleAccent.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(5),
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
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.bookmark_rounded, color: Colors.amber, size: 14),
                      ),
                    ),
                ],
              ),
              // Title and episode count
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${show.episodeCount} episodes',
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.grey.shade600,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(bool isDark, bool isWide) {
    return Container(
      height: 105,
      width: isWide ? double.infinity : 150,
      color: isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade300,
      child: Icon(
        Icons.movie_creation_outlined,
        color: isDark ? Colors.white38 : Colors.black26,
        size: 32,
      ),
    );
  }
}