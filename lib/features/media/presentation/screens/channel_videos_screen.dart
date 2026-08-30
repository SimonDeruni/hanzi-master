import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/youtube_repository.dart';
import '../../domain/models/youtube_video.dart';
import 'smart_media_desk_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import '../../data/channels_data.dart';

/// Displays all recent uploads from a specific YouTube channel.
class ChannelVideosScreen extends ConsumerStatefulWidget {
  final String channelId;
  final String channelName;
  final String channelLogoUrl;

  final List<Map<String, String>> initialChannelInfos;

  const ChannelVideosScreen({
    super.key,
    required this.channelId,
    required this.channelName,
    required this.channelLogoUrl,
    this.initialChannelInfos = const [],
  });

  @override
  ConsumerState<ChannelVideosScreen> createState() =>
      _ChannelVideosScreenState();
}

class _ChannelVideosScreenState extends ConsumerState<ChannelVideosScreen> {
  late String _currentChannelId;
  late String _currentChannelName;
  late String _currentChannelLogoUrl;

  List<YoutubeVideo> _videos = [];
  bool _isLoading = true;
  String? _error;

  List<Map<String, String>> _channelInfos = [];
  bool _channelsLoading = true;

  @override
  void initState() {
    super.initState();
    _currentChannelId = widget.channelId;
    _currentChannelName = widget.channelName;
    _currentChannelLogoUrl = widget.channelLogoUrl;

    if (widget.initialChannelInfos.isNotEmpty) {
      _channelInfos = List.from(widget.initialChannelInfos);
      _channelsLoading = false;
    } else {
      _loadChannelInfos();
    }

    _loadUploads();
  }

  void _switchChannel(String channelId, String name, String logo) {
    if (_currentChannelId == channelId && _currentChannelName == name) return;
    HapticsManager.selection();
    setState(() {
      _currentChannelId = channelId;
      _currentChannelName = name;
      _currentChannelLogoUrl = logo;
      _videos = [];
      _isLoading = true;
      _error = null;
    });
    _loadUploads();
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
        _channelInfos = infos;
        _channelsLoading = false;
      });
    }
  }

  Future<void> _loadUploads() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final repository = ref.read(youtubeRepositoryProvider);
      final videos = await repository.getChannelUploads(
        _currentChannelId,
        channelName: _currentChannelName,
      );
      if (mounted) {
        setState(() {
          _videos = videos;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Row(
            key: ValueKey(_currentChannelId),
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: _currentChannelLogoUrl.isNotEmpty
                    ? NetworkImage(_currentChannelLogoUrl)
                    : null,
                child: _currentChannelLogoUrl.isEmpty
                    ? Icon(Icons.person, size: 16, color: isDark ? Colors.white54 : Colors.grey.shade600)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _currentChannelName,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    fontFamily: 'NotoSerifSC',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Persistent Channel Row
          const SizedBox(height: 4),
          _buildChannelRow(),
          
          // 3-sentence channel description banner
          _buildChannelDescriptionCard(),
          const SizedBox(height: 8),

          // Main video list
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildChannelDescriptionCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Find channel points from ChannelsData
    final match = ChannelsData.entries.firstWhere(
      (e) =>
          e.channelId == _currentChannelId ||
          e.displayName == _currentChannelName ||
          (_currentChannelName.contains(e.displayName) || e.displayName.contains(_currentChannelName)),
      orElse: () => const ChannelEntry(
        displayName: '',
        logoUrl: '',
        sourceType: SourceType.handle,
        descriptionPoints: [
          'High-quality curated Mandarin content with natural vocabulary.',
          'Authentic spoken Chinese across real-world themes and topics.',
          'Engaging video material with interactive synchronized subtitles.',
        ],
      ),
    );

    final points = match.descriptionPoints.isNotEmpty
        ? match.descriptionPoints
        : [
            'High-quality curated Mandarin content with natural vocabulary.',
            'Authentic spoken Chinese across real-world themes and topics.',
            'Engaging video material with interactive synchronized subtitles.',
          ];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Container(
        key: ValueKey(_currentChannelId),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E22) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F51B5).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'ABOUT CHANNEL',
                    style: TextStyle(
                      color: Color(0xFF3F51B5),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (final sentence in points)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 8),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.amber : const Color(0xFF3F51B5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        sentence,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: isDark ? Colors.white70 : const Color(0xFF2C2C2E),
                          fontWeight: FontWeight.w500,
                        ),
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
                final isSelected = channelId == _currentChannelId || title == _currentChannelName;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: GestureDetector(
                    onTap: () => _switchChannel(channelId, title, logoUrl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: const Color(0xFF3F51B5), width: 2.5)
                                : null,
                          ),
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: isDark
                                ? const Color(0xFF2C2C2E)
                                : const Color(0xFFB0C4DE).withValues(alpha: 0.6),
                            backgroundImage: logoUrl.isNotEmpty
                                ? NetworkImage(logoUrl)
                                : null,
                            child: logoUrl.isEmpty
                                ? Icon(Icons.person,
                                    size: 22,
                                    color: isDark ? Colors.white54 : Colors.grey.shade600)
                                : null,
                          ),
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
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF3F51B5)
                                  : (isDark ? Colors.white70 : Colors.black87),
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

  Widget _buildBody() {
    if (_isLoading) return _buildLoadingGrid();
    if (_error != null) return _buildErrorState();
    if (_videos.isEmpty) {
      return const Center(
        child: Text(
          'No videos found',
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      itemCount: _videos.length,
      itemBuilder: (context, index) => _buildVideoCard(_videos[index]),
    );
  }

  Widget _buildLoadingGrid() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 24),
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
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(height: 200, color: Colors.grey.shade200),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
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

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              'Failed to load videos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadUploads,
              icon: const Icon(Icons.refresh),
              label: const Text('Tap to Retry'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.indigo,
                backgroundColor: Colors.indigo.withValues(alpha: 0.1),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(YoutubeVideo video) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E22) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    video.highThumbnailUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(height: 200, color: isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade300),
                  ),
                ),
                _buildDurationBadge(video.duration),
                _buildCcBadge(),
                _buildPlayOverlay(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.3,
                      color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    video.channelTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isDark ? Colors.white60 : Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

  Widget _buildDurationBadge(Duration? duration) {
    if (duration == null || duration == Duration.zero || duration.inSeconds == 0) {
      return const SizedBox.shrink();
    }
    final text = _formatDuration(duration);
    return Positioned(
      bottom: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCcBadge() {
    return Positioned(
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
            Text(
              'CC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayOverlay() {
    return Positioned.fill(
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
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return '';
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
