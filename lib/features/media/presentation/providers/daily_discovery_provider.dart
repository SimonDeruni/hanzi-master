import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/data/repositories/daily_discovery_repository.dart';

part 'daily_discovery_provider.g.dart';

@riverpod
class DailyDiscovery extends _$DailyDiscovery {
  @override
  Future<List<DailyMediaItem>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayString = "${now.year}-${now.month}-${now.day}";
    const cacheVersion = "v2"; // Bump this to bust the cache
    
    final cacheDate = prefs.getString('daily_discovery_cache_date');
    final cacheData = prefs.getString('daily_discovery_cache_data');
    final savedVersion = prefs.getString('daily_discovery_cache_version');

    if (cacheDate == todayString && cacheData != null && savedVersion == cacheVersion) {
      try {
        final List<dynamic> decoded = jsonDecode(cacheData);
        return decoded.map((e) => DailyMediaItem.fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        // Fallback to fetch if decode fails
      }
    }

    final repo = DailyDiscoveryRepository();
    
    // Fetch both simultaneously with a faster timeout to prevent UI hanging
    final results = await Future.wait([
      repo.getDailyVideo().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          final fallbacks = List<DailyMediaItem>.from(DailyDiscoveryRepository.fallbackVideos);
          fallbacks.shuffle(Random("\${now.year}-\${now.month}-\${now.day}".hashCode));
          return fallbacks.first;
        },
      ),
      repo.getDailyArticle().timeout(
        const Duration(seconds: 3),
        onTimeout: () => DailyMediaItem(
          title: "BBC 中文网",
          subtitle: "Current Events in Simplified Chinese",
          url: "https://www.bbc.com/zhongwen/simp",
          imageUrl: "https://www.bbc.co.uk/news/special/2015/newsspec_10857/bbc_news_logo.png",
          tag: "2 MIN CULTURAL CONTEXT",
        ),
      ),
    ]);
    
    // Save to cache
    await prefs.setString('daily_discovery_cache_date', todayString);
    await prefs.setString('daily_discovery_cache_data', jsonEncode(results.map((e) => e.toJson()).toList()));
    await prefs.setString('daily_discovery_cache_version', cacheVersion);

    return results;
  }
}

final completedDailyMediaProvider = StateNotifierProvider<CompletedDailyMediaNotifier, List<String>>((ref) {
  return CompletedDailyMediaNotifier();
});

class CompletedDailyMediaNotifier extends StateNotifier<List<String>> {
  CompletedDailyMediaNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayString = "\${now.year}-\${now.month}-\${now.day}";
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
