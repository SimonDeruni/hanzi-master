import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/data/repositories/daily_discovery_repository.dart';
import 'package:hanzi_master/features/media/data/repositories/show_repository.dart';
import 'package:hanzi_master/core/config/app_features.dart';

part 'daily_discovery_provider.g.dart';

@riverpod
class DailyDiscovery extends _$DailyDiscovery {
  @override
  Future<List<DailyMediaItem>> build() async {
    final prefs = await SharedPreferences.getInstance();

    // Check before reading the shared cache: an enabled internal build may
    // have cached a video which must never surface in a public build.
    if (!AppFeatures.youtubeMedia) {
      return [await _fetchArticle()];
    }

    final now = DateTime.now();
    final todayString = "${now.year}-${now.month}-${now.day}";
    const cacheVersion = "v5"; // Bust cached BBC homepage fallback entries.

    final cacheDate = prefs.getString('daily_discovery_cache_date');
    final cacheData = prefs.getString('daily_discovery_cache_data');
    final savedVersion = prefs.getString('daily_discovery_cache_version');

    if (cacheDate == todayString &&
        cacheData != null &&
        savedVersion == cacheVersion) {
      try {
        final List<dynamic> decoded = jsonDecode(cacheData);
        return decoded
            .map((e) => DailyMediaItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (e) {
        // Fallback to fetch if decode fails
      }
    }

    final repo = DailyDiscoveryRepository();

    // Load shown video IDs from persistent storage
    final shownIds = prefs.getStringList('daily_shown_video_ids') ?? [];

    // Fetch video of the day
    DailyMediaItem videoItem;
    String? newVideoId;
    try {
      final result = await repo.getDailyVideo(shownVideoIds: shownIds).timeout(
            const Duration(seconds: 20),
            onTimeout: () => throw Exception('Video fetch timed out'),
          );
      videoItem = result.item;
      newVideoId = result.videoId;
    } catch (e) {
      // Don't cache fallbacks — return directly so next refresh can try API again
      final fallbacks =
          List<DailyMediaItem>.from(DailyDiscoveryRepository.fallbackVideos);
      fallbacks.shuffle(Random(todayString.hashCode));
      return [fallbacks.first, await _fetchArticle()];
    }

    // Persist the new video ID so it won't repeat tomorrow
    final updatedShown = [...shownIds, newVideoId];
    final trimmed = updatedShown.length > 200
        ? updatedShown.sublist(updatedShown.length - 200)
        : updatedShown;
    await prefs.setStringList('daily_shown_video_ids', trimmed);

    // Fetch article of the day
    final articleItem = await _fetchArticle();

    final results = [videoItem, articleItem];

    // Only cache on success
    await prefs.setString('daily_discovery_cache_date', todayString);
    await prefs.setString('daily_discovery_cache_data',
        jsonEncode(results.map((e) => e.toJson()).toList()));
    await prefs.setString('daily_discovery_cache_version', cacheVersion);

    return results;
  }

  Future<DailyMediaItem> _fetchArticle() async {
    final repo = DailyDiscoveryRepository();
    return repo.getDailyArticle();
  }
}

final completedDailyMediaProvider =
    StateNotifierProvider<CompletedDailyMediaNotifier, List<String>>((ref) {
  return CompletedDailyMediaNotifier();
});

class CompletedDailyMediaNotifier extends StateNotifier<List<String>> {
  CompletedDailyMediaNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayString = "${now.year}-${now.month}-${now.day}";
    final cacheDate = prefs.getString('completed_daily_media_date');
    if (cacheDate == todayString) {
      final list = prefs.getStringList('completed_daily_media_list');
      if (list != null) {
        state = list;
      }
    } else {
      await prefs.setString('completed_daily_media_date', todayString);
      await prefs.setStringList('completed_daily_media_list', []);
    }
  }

  Future<void> markCompleted(String url) async {
    if (!state.contains(url)) {
      state = [...state, url];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('completed_daily_media_list', state);
    }
  }
}

/// Provider that fetches the daily show recommendation.
/// Uses date-seeded deterministic selection so all users see the same show each day.
final dailyShowProvider = FutureProvider<Show?>((ref) async {
  if (!AppFeatures.youtubeMedia) return null;
  final repo = ref.read(showRepositoryProvider);
  return repo.getDailyShow();
});
