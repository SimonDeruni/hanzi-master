import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/youtube_repository.dart';
import '../../domain/models/youtube_video.dart';
import 'smart_media_desk_screen.dart';
import 'channel_videos_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import '../../data/channels_data.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class MediaSearchScreen extends ConsumerStatefulWidget {
  const MediaSearchScreen({super.key});

  @override
  ConsumerState<MediaSearchScreen> createState() => _MediaSearchScreenState();
}

class _MediaSearchScreenState extends ConsumerState<MediaSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  late final Map<String, List<YoutubeVideo>> _categories;
  late final Map<String, String> _categoryQueries;
  bool _categoriesInitialized = false;

  // Track loading state per category for progressive rendering
  final Map<String, _CategoryLoadState> _categoryStates = {};

  bool _isSearching = false;
  List<YoutubeVideo> _searchResults = [];
  String? _error;
  String _searchStatus = '';

  // Channel row state: resolved channel info for quick access
  final List<Map<String, String>> _channelInfos = [];
  bool _channelsLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChannelInfos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_categoriesInitialized) return;

    final localizations = AppLocalizations.of(context)!;
    _categories = {
      localizations.lifestyleAndVlog: [],
      localizations.gamingAndEsports: [],
      localizations.foodAndCooking: [],
      localizations.techAndGadgets: [],
    };
    _categoryQueries = {
      localizations.lifestyleAndVlog: localizations.vlog,
      localizations.gamingAndEsports: localizations.unknown2,
      localizations.foodAndCooking: localizations.unknown3,
      localizations.techAndGadgets: localizations.unknown4,
    };
    for (final key in _categoryQueries.keys) {
      _categoryStates[key] = _CategoryLoadState.loading;
    }
    _categoriesInitialized = true;
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

  Future<void> _loadChannelInfos() async {
    final repository = ref.read(youtubeRepositoryProvider);
    final infos = <Map<String, String>>[];

    for (final entry in ChannelsData.entries) {
      try {
        Map<String, String> data;
        switch (entry.sourceType) {
          case SourceType.handle:
            data = await repository.getChannelByHandle(entry.handle);
          case SourceType.channelId:
            data = await repository.getChannelById(entry.channelId);
          case SourceType.video:
            data = await repository.getChannelByVideo(entry.resolveVideoId);
        }
        infos.add(data);
      } catch (e) {
        // Fallback to hardcoded data from the registry
        infos.add({
          'id': entry.channelId.isNotEmpty
              ? entry.channelId
              : (entry.handle.isNotEmpty ? entry.handle : entry.resolveVideoId),
          'title': entry.displayName,
          'logoUrl': entry.logoUrl,
        });
      }
    }

    if (mounted) {
      setState(() {
        _channelInfos.addAll(infos);
        _channelsLoading = false;
      });
    }
  }

  Future<void> _loadCategory(String categoryKey) async {
    final query = _categoryQueries[categoryKey];
    if (query == null) return;

    setState(() {
      _categoryStates[categoryKey] = _CategoryLoadState.loading;
    });

    try {
      final repository = ref.read(youtubeRepositoryProvider);
      final results = await repository.searchVideos(query);
      if (mounted) {
        setState(() {
          _categories[categoryKey] = results;
          _categoryStates[categoryKey] = results.isEmpty
              ? _CategoryLoadState.empty
              : _CategoryLoadState.loaded;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _categoryStates[categoryKey] = _CategoryLoadState.error;
        });
      }
    }
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
      setState(() => _searchStatus = 'Searching...');
      final results = await repository.searchVideos(query);

      if (mounted) {
        setState(() {
          _searchResults = results;
          _searchStatus = results.isEmpty
              ? 'No videos found. Try a different search term.'
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF141416)
          : const Color(0xFFFDFCF0), // Xuan paper
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // â”€â”€ Channel quick-access row â”€â”€
            const SizedBox(height: 8),
            _buildChannelRow(),
            const SizedBox(height: 12),

            // â”€â”€ Pill Search Bar (matching reference) â”€â”€
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E22) : Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.06),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(
                      Icons.search_rounded,
                      size: 22,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                          color:
                              isDark ? Colors.white : const Color(0xFF1A1A1B),
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .searchTopicsEgCookingHistory,
                          hintStyle: TextStyle(
                            color: isDark ? Colors.white38 : Colors.black38,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onSubmitted: _performSearch,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send_rounded,
                          color: Color(0xFF3F51B5), size: 22),
                      onPressed: () => _performSearch(_searchController.text),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            if (_error != null)
              Expanded(
                  child: Center(
                      child: Text(
                          _error ??
                              AppLocalizations.of(context)!.failedToLoadContent,
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
                                color: Color(0xFF3F51B5),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _searchStatus,
                              style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: _searchResults.isEmpty &&
                              _searchStatus.contains('Searching')
                          ? _buildSkeletonGrid()
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                          child: Row(
                            children: [
                              Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'NotoSerifSC',
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF1A1A1B),
                                ),
                              ),
                              if (state == _CategoryLoadState.loading) ...[
                                const SizedBox(width: 12),
                                const SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF3F51B5),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: _buildCategoryContent(
                              entry.key, state, entry.value),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContent(
      String categoryKey, _CategoryLoadState state, List<YoutubeVideo> videos) {
    switch (state) {
      case _CategoryLoadState.loading:
        return _buildSkeletonRow();
      case _CategoryLoadState.empty:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.noVideosFound,
              style: const TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ),
        );
      case _CategoryLoadState.error:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.failedToLoadContent,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => _loadCategory(categoryKey),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(AppLocalizations.of(context)!.tapToRetry),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF3F51B5),
                    backgroundColor:
                        const Color(0xFF3F51B5).withValues(alpha: 0.1),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
        );
      case _CategoryLoadState.loaded:
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return const _SkeletonCard(width: 240, imageHeight: 155);
      },
    );
  }

  /// Shimmer skeleton grid for search results (loading state)
  Widget _buildSkeletonGrid() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const _SkeletonCard(width: double.infinity, imageHeight: 200);
      },
    );
  }

  Widget _buildVideoCard(YoutubeVideo video, {required bool isLarge}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = isLarge ? double.infinity : 240.0;
    final imageHeight = isLarge ? 200.0 : 155.0;

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
          color: isDark ? const Color(0xFF1E1E22) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.04),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail with Duration, CC Badge, & Play overlay
              Stack(
                children: [
                  Image.network(
                    isLarge ? video.highThumbnailUrl : video.mediumThumbnailUrl,
                    width: width,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: width,
                      height: imageHeight,
                      color: isDark
                          ? const Color(0xFF2C2C2E)
                          : Colors.grey.shade300,
                    ),
                  ),
                  // Duration badge (bottom-right)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _formatDuration(video.duration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // CC Badge (top-left, matching reference screenshot)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3252C7), // Vibrant blue CC badge
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.closed_caption_rounded,
                              color: Colors.white, size: 14),
                          SizedBox(width: 3),
                          Text(
                            "CC",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Play Icon Overlay
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.28),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Video Info
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.channelTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.grey.shade600,
                        fontSize: 12,
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

  Widget _buildChannelRow() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 86,
      child: _channelsLoading
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 8,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFD6D6D6),
                  ),
                );
              },
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: _channelInfos.length,
              itemBuilder: (context, index) {
                final channel = _channelInfos[index];
                final logoUrl = channel['logoUrl'] ?? '';
                final title = channel['title'] ?? '';
                final channelId = channel['id'] ?? '';
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: GestureDetector(
                    onTap: () {
                      HapticsManager.medium();
                      Navigator.push(
                        context,
                        SwipeBackPageRoute(
                          builder: (context) => ChannelVideosScreen(
                            channelId: channelId,
                            channelName: title,
                            channelLogoUrl: logoUrl,
                            initialChannelInfos: _channelInfos,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: isDark
                              ? const Color(0xFF2C2C2E)
                              : const Color(0xFFB0C4DE).withValues(alpha: 0.6),
                          backgroundImage:
                              logoUrl.isNotEmpty ? NetworkImage(logoUrl) : null,
                          child: logoUrl.isEmpty
                              ? Icon(Icons.person,
                                  size: 22,
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.grey.shade600)
                              : null,
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 64,
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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

// Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬ Loading state enum Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬

enum _CategoryLoadState { loading, loaded, empty, error }

// Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬ Shimmer Skeleton Card Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬Ã¢”â‚¬

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
