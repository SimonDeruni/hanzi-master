import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

part 'widget_service.g.dart';

@riverpod
WidgetService widgetService(WidgetServiceRef ref) {
  return WidgetService();
}

class WidgetService {
  final String _androidAppWidgetName = 'HanziWidgetProvider';
  final String _iOSAppGroupId = 'group.com.sinospark.hanzimaster'; // Replace with actual app group ID

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    
    // Set up group ID for iOS
    await HomeWidget.setAppGroupId(_iOSAppGroupId);

    _isInitialized = true;
  }

  Future<void> updateReviewWidget(int dueCount) async {
    await init();
    
    // Save data to be read by native widgets
    await HomeWidget.saveWidgetData<int>('due_cards_count', dueCount);
    
    // Trigger update
    await HomeWidget.updateWidget(
      name: _androidAppWidgetName,
      iOSName: 'ReviewStationWidget', // Name of the iOS widget kind
    );
  }

  Future<void> updateDailySparkWidget({
    required Flashcard wordOfDay,
    required String newsHeadline,
    required String videoTitle,
  }) async {
    await init();

    await HomeWidget.saveWidgetData<String>('wotd_hanzi', wordOfDay.hanzi);
    await HomeWidget.saveWidgetData<String>('wotd_pinyin', wordOfDay.pinyin);
    await HomeWidget.saveWidgetData<String>('wotd_meaning', wordOfDay.definition);
    await HomeWidget.saveWidgetData<String>('news_headline', newsHeadline);
    await HomeWidget.saveWidgetData<String>('video_title', videoTitle);

    await HomeWidget.updateWidget(
      name: _androidAppWidgetName,
      iOSName: 'DailySparkWidget', 
    );
  }
}
