import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../data/youtube_repository.dart';
import 'smart_media_desk_screen.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/info_bulb.dart';

class MediaSearchScreen extends ConsumerStatefulWidget {
  const MediaSearchScreen({super.key});

  @override
  ConsumerState<MediaSearchScreen> createState() => _MediaSearchScreenState();
}

class _MediaSearchScreenState extends ConsumerState<MediaSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  final Map<String, List<Video>> _categories = {
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

  bool _isLoadingInitial = true;
  bool _isSearching = false;
  List<Video> _searchResults = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInitialCategories();
  }

  Future<void> _loadInitialCategories() async {
    try {
      final repository = ref.read(youtubeRepositoryProvider);
      
      // Load all categories in parallel to speed up initial load
      await Future.wait(_categoryQueries.entries.map((entry) async {
        final results = await repository.searchVideos(entry.value);
        if (mounted) {
          setState(() {
            _categories[entry.key] = results;
          });
        }
      }));
      
      if (mounted) {
        setState(() {
          _isLoadingInitial = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoadingInitial = false;
        });
      }
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _isLoadingInitial = true;
      _error = null;
    });

    try {
      final repository = ref.read(youtubeRepositoryProvider);
      // Append Chinese context to ensure native Chinese videos
      final results = await repository.searchVideos('$query 中国 中文');

      setState(() {
        _searchResults = results;
        _isLoadingInitial = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoadingInitial = false;
      });
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
              message: "Discover Chinese content from YouTube. Browse curated categories or search for topics you're interested in. Each video comes with interactive subtitles to help you learn while watching.",
            ),
            Text('Smart Media Desk', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
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
            Expanded(child: Center(child: Text('Error: $_error', style: const TextStyle(color: Colors.red))))
          else if (_isLoadingInitial)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.indigo),
                    SizedBox(height: 16),
                    Text('Curating Chinese Content...', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )
          else if (_isSearching)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return _buildVideoCard(_searchResults[index], isLarge: true);
                },
              ),
            )
          else
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 40),
                children: _categories.entries.map((entry) {
                  if (entry.value.isEmpty) return const SizedBox.shrink();
                  
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          scrollDirection: Axis.horizontal,
                          itemCount: entry.value.length,
                          itemBuilder: (context, index) {
                            return _buildVideoCard(entry.value[index], isLarge: false);
                          },
                        ),
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

  Widget _buildVideoCard(Video video, {required bool isLarge}) {
    final width = isLarge ? double.infinity : 260.0;
    final imageHeight = isLarge ? 200.0 : 140.0;
    
    return GestureDetector(
      onTap: () {
        HapticsManager.medium();
        Navigator.push(
          context,
          MaterialPageRoute(
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    isLarge ? video.thumbnails.highResUrl : video.thumbnails.mediumResUrl,
                    width: width,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(width: width, height: imageHeight, color: Colors.grey.shade300),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _formatDuration(video.duration),
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.closed_caption, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text("CC", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 1.3),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    video.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.w600),
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
