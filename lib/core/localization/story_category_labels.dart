import 'package:hanzi_master/l10n/app_localizations.dart';

/// Display labels for story categories.
///
/// Story **data** keeps English category values ("Idiom Stories",
/// "Classical Literature", ...) because the code compares them - see
/// `book_providers.dart` (which separates micro-reads from poetry) and
/// `poetry_story_id.dart`. Only what the reader sees is translated, so this maps
/// the stored value to a localized label, mirroring how the deck library
/// localizes its filter keys.
///
/// Categories with no key yet fall through as the stored English, which is
/// deliberate: a new source category shows up in the UI instead of vanishing.
extension StoryCategoryLabels on AppLocalizations {
  String storyCategoryLabel(String category) {
    switch (category) {
      case 'Idiom Stories':
        return storyCategoryIdiomStories;
      case 'Contemporary Stories':
        return storyCategoryContemporaryStories;
      case 'Classical Literature':
        return storyCategoryClassicalLiterature;
      case 'English & World':
        return storyCategoryEnglishWorld;
      case 'French Classics':
        return storyCategoryFrenchClassics;
      case 'German Classics':
        return storyCategoryGermanClassics;
      case 'Spanish & World':
        return storyCategorySpanishWorld;
      case 'Ancient Philosophy':
        return storyCategoryAncientPhilosophy;
      case 'Modern Chinese':
        return storyCategoryModernChinese;
      case 'Chinese Epics':
        return storyCategoryChineseEpics;
      case 'Supernatural & Folklore':
        return storyCategorySupernaturalFolklore;
      case 'Chinese Poetry':
        return storyCategoryChinesePoetry;
      case 'Tang Poetry':
        return storyCategoryTangPoetry;
      default:
        return category;
    }
  }
}
