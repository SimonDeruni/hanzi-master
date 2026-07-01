import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/media/data/story_fetcher_service.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/media/presentation/screens/web_browser_screen.dart';
import 'package:hanzi_master/features/reading/presentation/providers/story_controller.dart';
import 'package:hanzi_master/features/reading/presentation/screens/story_reader_screen.dart';

class StoryLibraryScreen extends ConsumerStatefulWidget {
  const StoryLibraryScreen({super.key});

  @override
  ConsumerState<StoryLibraryScreen> createState() => _StoryLibraryScreenState();
}

class _StoryLibraryScreenState extends ConsumerState<StoryLibraryScreen> {
  List<LibraryStory> _rssStories = [];
  List<LibraryStory> _jsonStories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  Future<void> _loadStories() async {
    final fetcher = ref.read(storyFetcherServiceProvider);
    
    final rss = await fetcher.fetchAllRssSources();
    final json = await fetcher.fetchPublicDomainClassics();
    
    if (mounted) {
      setState(() {
        _rssStories = rss;
        _jsonStories = json;
        _isLoading = false;
      });
    }
  }

  void _openStory(LibraryStory story) {
    if (story.sourceType == StorySourceType.rss) {
      // Option A: Open in Zen Web Browser
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebBrowserScreen(
            initialUrl: story.link,
          ),
        ),
      );
    } else {
      // Option B: Open in Story Reader Screen using a Blueprint
      final dummyBlueprint = StoryBlueprint(
        id: story.link,
        title: story.title,
        topic: story.title,
        category: "Classic",
        imageUrl: story.imageUrl ?? "",
        tags: ["Classic"],
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StoryReaderScreen(
            blueprint: dummyBlueprint,
            hskLevel: 3, // Default HSK level
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF0), // Zen Paper
      appBar: AppBar(
        title: const Text('文化书房 Library', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF1A1A1B),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF8B0000)))
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Trending Easy Reads (RSS)'),
                _buildHorizontalList(_rssStories),
                const SizedBox(height: 24),
                _buildSectionTitle('Classical Masterpieces (JSON)'),
                _buildHorizontalList(_jsonStories),
                const SizedBox(height: 48),
              ],
            ),
          ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Color(0xFF1A1A1B),
        ),
      ),
    );
  }

  Widget _buildHorizontalList(List<LibraryStory> stories) {
    if (stories.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No stories found.', style: TextStyle(color: Colors.grey)),
      );
    }
    
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: () => _openStory(story),
            child: Container(
              width: 160,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: story.imageUrl != null 
                      ? Image.network(story.imageUrl!, height: 100, width: double.infinity, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholderImage())
                      : _buildPlaceholderImage(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          story.sourceName,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 100,
      width: double.infinity,
      color: const Color(0xFFE5E5E5),
      child: const Icon(Icons.book, color: Colors.grey, size: 40),
    );
  }
}
