import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/reading/data/repositories/book_repository.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/media/data/story_fetcher_service.dart';
import 'package:hanzi_master/features/media/domain/models/library_story.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return BookRepository();
});

final bookCatalogProvider = FutureProvider<List<BookModel>>((ref) async {
  final repo = ref.read(bookRepositoryProvider);
  await repo.init();
  return repo.loadCatalog();
});

final bookChaptersProvider = FutureProvider.family<List<BookChapter>, String>((ref, bookId) async {
  final repo = ref.read(bookRepositoryProvider);
  await repo.init();
  return repo.getBookChapters(bookId);
});

final bookProgressProvider = StateProvider.family<int, String>((ref, bookId) {
  final repo = ref.read(bookRepositoryProvider);
  return repo.getReadingProgress(bookId);
});

class InProgressBookItem {
  final BookModel book;
  final BookReadingProgress progress;

  const InProgressBookItem({
    required this.book,
    required this.progress,
  });
}

final inProgressBooksProvider = FutureProvider<List<InProgressBookItem>>((ref) async {
  final repo = ref.read(bookRepositoryProvider);
  await repo.init();
  final catalog = await repo.loadCatalog();
  final progressList = repo.getAllInProgressBooksData();

  final items = <InProgressBookItem>[];
  for (final data in progressList) {
    final bookId = data['bookId'] as String? ?? '';
    final book = catalog.where((b) => b.id == bookId).firstOrNull;
    if (book != null) {
      final prog = BookReadingProgress.fromJson(data);
      items.add(InProgressBookItem(book: book, progress: prog));
    }
  }
  return items;
});

final bookBookmarksProvider = StateProvider.family<List<BookmarkModel>, String>((ref, bookId) {
  final repo = ref.read(bookRepositoryProvider);
  return repo.getBookmarks(bookId);
});

final microReadsProvider = FutureProvider<List<LibraryStory>>((ref) async {
  final fetcher = ref.read(storyFetcherServiceProvider);
  final all = await fetcher.fetchLocalStories();
  return all.where((s) => s.category != 'Tang Poetry' && s.category != 'Classical Literature').toList();
});

final tangPoetryProvider = FutureProvider<List<LibraryStory>>((ref) async {
  final fetcher = ref.read(storyFetcherServiceProvider);
  final all = await fetcher.fetchLocalStories();
  return all.where((s) => s.category == 'Tang Poetry' || s.category == 'Classical Literature').toList();
});

