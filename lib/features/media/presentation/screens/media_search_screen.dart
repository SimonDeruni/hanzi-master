import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/youtube_repository.dart';
import '../../domain/models/youtube_video.dart';
import 'smart_media_desk_screen.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/info_bulb.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

class MediaSearchScreen extends ConsumerStatefulWidget {
  const MediaSearchScreen({super.key});

  @override
  ConsumerState<MediaSearchScreen> createState() => _MediaSearchScreenState();
}

class _MediaSearchScreenState extends ConsumerState<MediaSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<YoutubeVideo>> _categories = {
    'Lifestyle & Vlog': [],
    'Gaming & Esports': [],
    'Food & Cooking': [],
    'Tech & Gadgets': [],
  };

  final Map<String, String> _categoryQueries = {
    'Lifestyle & Vlog': '中国 日常 vlog',
    'Gaming & Esports': '中国 游戏 实况',
    'Food & Cooking': '中国 美食 菜谱',
    'Tech & Gadgets': '中国 科技 测评',
  };

  // Track loading state per category for progressive rendering
  final Map<String, _CategoryLoadState> _categoryStates = {};

  bool _isSearching = false;
  List<YoutubeVideo> _searchResults = [];
  String? _error;
  String _searchStatus = '';

  @override
  void initState() {
    super.initState();
    for (final key in _categoryQueries.keys) {
      _categoryStates[key] = _CategoryLoadState.loading;
    }
    _loadInitialCategories();
  }

  Future<void> _loadInitialCategories() async {
    final repository = ref.read(youtubeRepositoryProvider);

    // Launch all categories in parallel, but update UI as each completes
    final futures = _categoryQueries.entries.map((entry) async {
      try {
        final results = await repository.searchVideos(entry.value);
        if (mounted) {
          setState(() {
            _categories[entry.key] = results;
            _categoryStates[entry.key] = results.isEmpty
                ? _CategoryLoadState.empty
                : _CategoryLoadState.loaded;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _categoryStates[entry.key] = _CategoryLoadState.error;
          });
        }
      }
    });

    await Future.wait(futures);
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _searchStatus = '';
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _searchStatus = 'Searching YouTube...';
    });

    try {
      final repository = ref.read(youtubeRepositoryProvider);
      setState(() => _searchStatus = 'Checking captions...');
      final results = await repository.searchVideos('$query 中国 中文');

      if (mounted) {
        setState(() {
          _searchResults = results;
          _searchStatus = results.isEmpty
              ? 'No videos with Chinese subtitles found'
              : 'Found ${results.length} video${results.length == 1 ? '' : 's'}';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _searchStatus = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0), // Xuan paper
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoBulb(
              id: 'smart_media_desk',
              title: "Smart Media Desk",
              message:
                  "Discover Chinese content from YouTube. Browse curated categories or search for topics you're interested in. Each video comes with interactive subtitles to help you learn while watching.",
            ),
            Text('Smart Media Desk',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HanziTextField(
              controller: _searchController,
              hintText: 'Search topics (e.g., Cooking, History)',
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send, color: Colors.indigo),
                onPressed: () => _performSearch(_searchController.text),
              ),
              onSubmitted: _performSearch,
            ),
          ),

          if (_error != null)
            Expanded(
                child: Center(
                    child: Text('Error: $_error',
                        style: const TextStyle(color: Colors.red))))
          else if (_isSearching)
            Expanded(
              child: Column(
                children: [
                  // Dynamic status text
                  if (_searchStatus.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _searchStatus,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: _searchResults.isEmpty && _searchStatus.contains('Searching')
                        ? _buildSkeletonGrid()
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              return _buildVideoCard(_searchResults[index],
                                  isLarge: true);
                            },
                          ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 40),
                children: _categories.entries.map((entry) {
                  final state = _categoryStates[entry.key] ??
                      _CategoryLoadState.loading;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        child: Row(
                          children: [
                            Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                            if (state == _CategoryLoadState.loading) ...[
                              const SizedBox(width: 12),
                              const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: _buildCategoryContent(state, entry.value),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent(_CategoryLoadState state, List<YoutubeVideo> videos) {
    switch (state) {
      case _CategoryLoadState.loading:
        return _buildSkeletonRow();
      case _CategoryLoadState.empty:
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              'No videos found',
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ),
        );
      case _CategoryLoadState.error:
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              'Failed to load',
              style: TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
          ),
        );
      case _CategoryLoadState.loaded:
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return _buildVideoCard(videos[index], isLarge: false);
          },
        );
    }
  }

  /// Shimmer skeleton for horizontal category rows (loading state)
  Widget _buildSkeletonRow() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return _SkeletonCard(width: 260, imageHeight: 140);
      },
    );
  }

  /// Shimmer skeleton grid for search results (loading state)
  Widget _buildSkeletonGrid() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _SkeletonCard(width: double.infinity, imageHeight: 200);
      },
    );
  }

  Widget _buildVideoCard(YoutubeVideo video, {required bool isLarge}) {
    final width = isLarge ? double.infinity : 260.0;
    final imageHeight = isLarge ? 200.0 : 140.0;

    return GestureDetector(
      onTap: () {
        HapticsManager.medium();
        Navigator.push(
          context,
          SwipeBackPageRoute(
            builder: (context) => SmartMediaDeskScreen(video: video),
          ),
        );
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(
          right: isLarge ? 0 : 16,
          bottom: isLarge ? 24 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with Duration & CC Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    isLarge
                        ? video.highThumbnailUrl
                        : video.mediumThumbnailUrl,
                    width: width,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                        width: width,
                        height: imageHeight,
                        color: Colors.grey.shade300),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _formatDuration(video.duration),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.closed_caption,
                            color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text("CC",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                // Play Icon Overlay
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow,
                          color: Colors.white, size: 32),
                    ),
                  ),
                ),
              ],
            ),

            // Video Info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.3),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    video.channelTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return "0:00";
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return "$minutes:${twoDigits(seconds)}";
  }
}

// ─── Loading state enum ───────────────────────────────────────────────────────

enum _CategoryLoadState { loading, loaded, empty, error }

// ─── Shimmer Skeleton Card ────────────────────────────────────────────────────

class _SkeletonCard extends StatefulWidget {
  final double width;
  final double imageHeight;
  const _SkeletonCard({required this.width, required this.imageHeight});

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final shimmer = Color.lerp(
          Colors.grey.shade200,
          Colors.grey.shade400,
          _animation.value,
        )!;
        return Container(
          width: widget.width,
          margin: EdgeInsets.only(
            right: widget.width == double.infinity ? 0 : 16,
            bottom: widget.width == double.infinity ? 24 : 0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer thumbnail placeholder
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  width: widget.width,
                  height: widget.imageHeight,
                  color: shimmer,
                ),
              ),
              // Shimmer text placeholders
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: widget.width == double.infinity ? 280 : 200,
                      decoration: BoxDecoration(
                        color: shimmer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: widget.width == double.infinity ? 200 : 140,
                      decoration: BoxDecoration(
                        color: shimmer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 12,
                      width: 100,
                      decoration: BoxDecoration(
                        color: shimmer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}