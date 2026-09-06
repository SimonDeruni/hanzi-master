import 'package:hive/hive.dart';
import 'package:hanzi_master/features/flashcards/data/models/daily_deck_activity_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/deck_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/review_stats_model.dart';
import 'package:hanzi_master/features/media/domain/models/saved_article.dart';

void registerHiveAdapters() {
  _register(FlashcardModelAdapter());
  _register(DeckModelAdapter());
  _register(ReviewStatsModelAdapter());
  _register(SavedArticleAdapter());
  _register(DailyDeckActivityModelAdapter());
}

void _register<T>(TypeAdapter<T> adapter) {
  // `main()` is not rerun by hot reload, and older builds registered several
  // adapters through mismatched ID guards. Override the slot so a warm process
  // cannot retain a stale adapter mapping for one of our persisted models.
  Hive.registerAdapter<T>(adapter, override: true);
}
