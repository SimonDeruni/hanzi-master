import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tracks which shows (playlists) the user has bookmarked.
/// Persisted to SharedPreferences as a list of show IDs.
class SavedShowsNotifier extends StateNotifier<Set<String>> {
  SavedShowsNotifier() : super({}) {
    _load();
  }

  static const _key = 'saved_shows_list';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key);
    if (list != null) {
      state = list.toSet();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, state.toList());
  }

  bool isSaved(String showId) => state.contains(showId);

  Future<void> toggle(String showId) async {
    if (state.contains(showId)) {
      state = {...state}..remove(showId);
    } else {
      state = {...state, showId};
    }
    await _save();
  }
}

final savedShowsProvider =
    StateNotifierProvider<SavedShowsNotifier, Set<String>>((ref) {
  return SavedShowsNotifier();
});

/// Tracks which episodes the user has marked as watched.
/// Persisted to SharedPreferences as a list of video IDs.
class WatchedEpisodesNotifier extends StateNotifier<Set<String>> {
  WatchedEpisodesNotifier() : super({}) {
    _load();
  }

  static const _key = 'watched_episodes_list';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key);
    if (list != null) {
      state = list.toSet();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, state.toList());
  }

  bool isWatched(String videoId) => state.contains(videoId);

  Future<void> markWatched(String videoId) async {
    if (!state.contains(videoId)) {
      state = {...state, videoId};
      await _save();
    }
  }

  Future<void> markUnwatched(String videoId) async {
    if (state.contains(videoId)) {
      state = {...state}..remove(videoId);
      await _save();
    }
  }

  Future<void> toggle(String videoId) async {
    if (state.contains(videoId)) {
      state = {...state}..remove(videoId);
    } else {
      state = {...state, videoId};
    }
    await _save();
  }
}

final watchedEpisodesProvider =
    StateNotifierProvider<WatchedEpisodesNotifier, Set<String>>((ref) {
  return WatchedEpisodesNotifier();
});