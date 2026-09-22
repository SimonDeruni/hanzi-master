import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';
import 'package:hanzi_master/features/media/presentation/screens/story_summary_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

class StoryCulturalInsightScreen extends ConsumerStatefulWidget {
  final LibraryStory story;
  final String heroTag;

  const StoryCulturalInsightScreen({
    super.key,
    required this.story,
    required this.heroTag,
  });

  @override
  ConsumerState<StoryCulturalInsightScreen> createState() =>
      _StoryCulturalInsightScreenState();
}

class _StoryCulturalInsightScreenState
    extends ConsumerState<StoryCulturalInsightScreen> {
  Future<CulturalInsight>? _insightFuture;

  @override
  void initState() {
    super.initState();
    _insightFuture = _fetchInsight();
  }

  Future<String> _loadPoemFullText() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/tang_poetry_en.json');
      final data = json.decode(jsonString) as List<dynamic>;
      final entry = data.firstWhere(
        (d) => (d['link'] ?? 'tang_poetry_${d['title']}') == widget.story.link,
        orElse: () => null,
      );
      return (entry?['rawText'] as String?) ?? '';
    } catch (_) {
      return '';
    }
  }

  Future<CulturalInsight> _fetchInsight() async {
    final geminiService = ref.read(geminiServiceProvider);
    final localeCode = Localizations.localeOf(context).toLanguageTag();
    String content = widget.story.summary;
    // Load the full poem text for classical literature
    if (widget.story.link.startsWith('tang_poetry_')) {
      final fullText = await _loadPoemFullText();
      if (fullText.isNotEmpty) {
        content = '$fullText\n\nSummary: ${widget.story.summary}';
      }
    }
    return geminiService.generateCulturalInsight(
      widget.story.localizedTitle(
        localeCode,
      ),
      content,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage =
        widget.story.imageUrl != null && widget.story.imageUrl!.isNotEmpty;
    final displayImageUrl = hasImage
        ? widget.story.imageUrl!
        : 'assets/images/ai_hub_ink_mountains.png';
    final isNetworkImage = displayImageUrl.startsWith('http');

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.story.localizedTitle(
                  Localizations.localeOf(context).toLanguageTag(),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ],
                ),
              ),
              background: Hero(
                tag: widget.heroTag,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    isNetworkImage
                        ? Image.network(displayImageUrl, fit: BoxFit.cover)
                        : Image.asset(displayImageUrl, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FutureBuilder<CulturalInsight>(
                future: _insightFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingState(theme);
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return _buildErrorState(theme);
                  }

                  final insight = snapshot.data!;
                  return _buildInsightContent(theme, insight);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                SwipeBackPageRoute(
                  builder: (context) => StorySummaryScreen(story: widget.story),
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.startReading,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Center(
            child: ZenLoader(color: theme.colorScheme.primary)),
        const SizedBox(height: 24),
        Center(
          child: Text(
            AppLocalizations.of(context)!.analyzingCulturalContext,
            style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.failedToLoadCulturalInsight,
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchInsight,
            child: Text(AppLocalizations.of(context)!.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightContent(ThemeData theme, CulturalInsight insight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(theme, 'Historical Context', Icons.history_edu),
        _buildSectionBody(theme, insight.historicalContext),
        const SizedBox(height: 32),

        _buildSectionTitle(
            theme, 'Cultural Significance', Icons.diamond_outlined),
        _buildSectionBody(theme, insight.culturalSignificance),
        const SizedBox(height: 32),

        _buildSectionTitle(theme, 'Author Background', Icons.person_outline),
        _buildSectionBody(theme, insight.authorBackground),
        const SizedBox(height: 48), // Padding before button
      ],
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionBody(ThemeData theme, String body) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 4.0),
      child: Text(
        body,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          height: 1.6,
        ),
      ),
    );
  }
}
