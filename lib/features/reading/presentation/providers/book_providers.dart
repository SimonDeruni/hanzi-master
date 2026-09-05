import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/reading/data/repositories/book_repository.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/logic/reading_session.dart';
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

final bookChaptersProvider =
    FutureProvider.family<List<BookChapter>, String>((ref, bookId) async {
  final repo = ref.read(bookRepositoryProvider);
  await repo.init();
  return repo.getBookChapters(bookId);
});

enum BookDownloadStatus {
  checking,
  notDownloaded,
  downloading,
  downloaded,
  error
}

class BookDownloadState {
  final BookDownloadStatus status;
  final double progress;
  final String? error;

  const BookDownloadState({
    this.status = BookDownloadStatus.checking,
    this.progress = 0,
    this.error,
  });
}

class BookDownloadController extends StateNotifier<BookDownloadState> {
  final BookRepository _repository;
  final String _bookId;

  BookDownloadController(this._repository, this._bookId)
      : super(const BookDownloadState()) {
    refresh();
  }

  Future<void> refresh() async {
    try {
      final downloaded = await _repository.isBookDownloaded(_bookId);
      if (mounted && state.status != BookDownloadStatus.downloading) {
        state = BookDownloadState(
          status: downloaded
              ? BookDownloadStatus.downloaded
              : BookDownloadStatus.notDownloaded,
          progress: downloaded ? 1 : 0,
        );
      }
    } catch (error) {
      if (mounted && state.status != BookDownloadStatus.downloading) {
        state = BookDownloadState(
          status: BookDownloadStatus.error,
          error: error.toString(),
        );
      }
    }
  }

  Future<void> download() async {
    state = const BookDownloadState(status: BookDownloadStatus.downloading);
    try {
      await _repository.downloadBook(
        _bookId,
        onProgress: (progress) {
          if (mounted) {
            state = BookDownloadState(
              status: BookDownloadStatus.downloading,
              progress: progress,
            );
          }
        },
      );
      if (mounted) {
        state = const BookDownloadState(
          status: BookDownloadStatus.downloaded,
          progress: 1,
        );
      }
    } catch (error) {
      if (mounted) {
        state = BookDownloadState(
          status: BookDownloadStatus.error,
          error: error.toString(),
        );
      }
    }
  }

  Future<void> remove() async {
    await _repository.removeDownloadedBook(_bookId);
    if (mounted) {
      state = const BookDownloadState(
        status: BookDownloadStatus.notDownloaded,
      );
    }
  }
}

final bookDownloadProvider = StateNotifierProvider.autoDispose
    .family<BookDownloadController, BookDownloadState, String>((ref, bookId) {
  return BookDownloadController(ref.read(bookRepositoryProvider), bookId);
});

final bookProgressProvider = StateProvider.family<int, String>((ref, bookId) {
  final repo = ref.read(bookRepositoryProvider);
  return repo.getReadingProgress(bookId);
});

final bookDetailedProgressProvider =
    Provider.family<BookReadingProgress?, String>((ref, bookId) {
  final repo = ref.read(bookRepositoryProvider);
  return repo.getDetailedReadingProgress(bookId);
});

class InProgressBookItem {
  final BookModel book;
  final BookReadingProgress progress;

  const InProgressBookItem({
    required this.book,
    required this.progress,
  });
}

final inProgressBooksProvider =
    FutureProvider<List<InProgressBookItem>>((ref) async {
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

final bookBookmarksProvider =
    StateProvider.family<List<BookmarkModel>, String>((ref, bookId) {
  final repo = ref.read(bookRepositoryProvider);
  return repo.getBookmarks(bookId);
});

final lastSessionProvider = Provider<ReadingSessionData?>((ref) {
  return ref.read(bookRepositoryProvider).getLastReadingSession();
});

class BookmarkShelfItem {
  final BookModel book;
  final BookmarkModel bookmark;

  const BookmarkShelfItem({required this.book, required this.bookmark});
}

final allBookmarksProvider =
    FutureProvider<List<BookmarkShelfItem>>((ref) async {
  final repo = ref.read(bookRepositoryProvider);
  await repo.init();
  final books = await repo.loadCatalog();
  final poetry = await ref.read(chinesePoetryProvider.future);
  final allBooks = <String, BookModel>{for (final book in books) book.id: book};
  for (final story in poetry) {
    allBooks[story.link] = BookModel(
      id: story.link,
      title: story.title,
      titleEn: story.titleEn ?? story.title,
      author: story.sourceName,
      authorEn: story.sourceName,
      category: story.category,
      description: story.summary,
      descriptionEn: story.summaryEn ?? story.summary,
      dynastyOrEra: '',
      hskLevel: story.hskLevel,
      totalChapters: 1,
      coverEmoji: '诗',
      tags: story.keywords,
    );
  }
  return repo
      .getAllBookmarksAcrossBooks()
      .map(BookmarkModel.fromJson)
      .where((bookmark) => allBooks.containsKey(bookmark.bookId))
      .map((bookmark) => BookmarkShelfItem(
            book: allBooks[bookmark.bookId]!,
            bookmark: bookmark,
          ))
      .toList();
});

final microReadsProvider = FutureProvider<List<LibraryStory>>((ref) async {
  final fetcher = ref.read(storyFetcherServiceProvider);
  final all = await fetcher.fetchLocalStories();
  return all
      .where((s) =>
          s.category != 'Tang Poetry' && s.category != 'Classical Literature')
      .toList();
});

final tangPoetryProvider = FutureProvider<List<LibraryStory>>((ref) async {
  final fetcher = ref.read(storyFetcherServiceProvider);
  final all = await fetcher.fetchLocalStories();
  return all
      .where((s) =>
          s.category == 'Tang Poetry' || s.category == 'Classical Literature')
      .toList();
});

final chinesePoetryProvider = FutureProvider<List<LibraryStory>>((ref) async {
  final fetcher = ref.read(storyFetcherServiceProvider);
  final all = await fetcher.fetchLocalStories();
  return all
      .where((s) =>
          s.category == 'Chinese Poetry' ||
          s.category == 'Tang Poetry' ||
          s.category == 'Classical Literature')
      .toList();
});
