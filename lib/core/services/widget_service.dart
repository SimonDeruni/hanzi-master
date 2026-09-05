import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'widget_service.g.dart';

const wordOfDayAppGroupId = 'group.com.sinospark.hanzimaster';
const wordOfDayWidgetKind = 'WordOfTheDayWidget';
final widgetWordSearch = ValueNotifier<String?>(null);

void handleWidgetUri(Uri? uri) {
  if (uri?.scheme != 'sinospark' || uri?.host != 'word') return;
  final hanzi = uri?.queryParameters['hanzi']?.trim();
  if (hanzi != null && hanzi.isNotEmpty) widgetWordSearch.value = hanzi;
}

@immutable
class WordOfTheDay {
  const WordOfTheDay({
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    this.localizedDefinitions = const {},
  });

  final String hanzi;
  final String pinyin;
  final String definition;
  final Map<String, String> localizedDefinitions;
}

const wordOfTheDayVocabulary = <WordOfTheDay>[
  WordOfTheDay(
      hanzi: '你好',
      pinyin: 'nǐ hǎo',
      definition: 'hello',
      localizedDefinitions: {'french': 'bonjour'}),
  WordOfTheDay(
      hanzi: '学习',
      pinyin: 'xué xí',
      definition: 'to study · to learn',
      localizedDefinitions: {'french': 'étudier · apprendre'}),
  WordOfTheDay(
      hanzi: '朋友',
      pinyin: 'péng you',
      definition: 'friend',
      localizedDefinitions: {'french': 'ami · amie'}),
  WordOfTheDay(
      hanzi: '发现',
      pinyin: 'fā xiàn',
      definition: 'to discover',
      localizedDefinitions: {'french': 'découvrir'}),
  WordOfTheDay(
      hanzi: '坚持',
      pinyin: 'jiān chí',
      definition: 'to persist',
      localizedDefinitions: {'french': 'persévérer'}),
  WordOfTheDay(
      hanzi: '勇气',
      pinyin: 'yǒng qì',
      definition: 'courage',
      localizedDefinitions: {'french': 'courage'}),
  WordOfTheDay(
      hanzi: '智慧',
      pinyin: 'zhì huì',
      definition: 'wisdom',
      localizedDefinitions: {'french': 'sagesse'}),
  WordOfTheDay(
      hanzi: '成长',
      pinyin: 'chéng zhǎng',
      definition: 'to grow',
      localizedDefinitions: {'french': 'grandir'}),
  WordOfTheDay(
      hanzi: '平静',
      pinyin: 'píng jìng',
      definition: 'calm · peaceful',
      localizedDefinitions: {'french': 'calme · paisible'}),
  WordOfTheDay(
      hanzi: '希望',
      pinyin: 'xī wàng',
      definition: 'hope',
      localizedDefinitions: {'french': 'espoir'}),
  WordOfTheDay(
      hanzi: '理解',
      pinyin: 'lǐ jiě',
      definition: 'to understand',
      localizedDefinitions: {'french': 'comprendre'}),
  WordOfTheDay(
      hanzi: '习惯',
      pinyin: 'xí guàn',
      definition: 'habit',
      localizedDefinitions: {'french': 'habitude'}),
  WordOfTheDay(
      hanzi: '温暖',
      pinyin: 'wēn nuǎn',
      definition: 'warmth · warm',
      localizedDefinitions: {'french': 'chaleur · chaleureux'}),
  WordOfTheDay(
      hanzi: '专注',
      pinyin: 'zhuān zhù',
      definition: 'to focus',
      localizedDefinitions: {'french': 'se concentrer'}),
];

WordOfTheDay wordOfTheDayFor(DateTime date) {
  // Convert the local calendar components to UTC before subtracting so a
  // daylight-saving transition cannot shift the deterministic day index.
  final calendarDay = DateTime.utc(date.year, date.month, date.day);
  final dayNumber = calendarDay.difference(DateTime.utc(2024)).inDays;
  return wordOfTheDayVocabulary[dayNumber % wordOfTheDayVocabulary.length];
}

Uri wordOfTheDayUri(WordOfTheDay word) => Uri(
      scheme: 'sinospark',
      host: 'word',
      queryParameters: {'hanzi': word.hanzi},
    );

@riverpod
WidgetService widgetService(WidgetServiceRef ref) => WidgetService();

class WidgetService {
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    await HomeWidget.setAppGroupId(wordOfDayAppGroupId);
    _isInitialized = true;
  }

  /// Publishes today's bundled word to the shared App Group and asks WidgetKit
  /// to reload. Widget failures must never prevent the main app from starting.
  Future<void> updateWordOfTheDay({DateTime? now}) async {
    try {
      await init();
      final date = now ?? DateTime.now();
      final word = wordOfTheDayFor(date);
      final dateKey = '${date.year.toString().padLeft(4, '0')}-'
          '${date.month.toString().padLeft(2, '0')}-'
          '${date.day.toString().padLeft(2, '0')}';

      await Future.wait([
        HomeWidget.saveWidgetData<String>('wotd_hanzi', word.hanzi),
        HomeWidget.saveWidgetData<String>('wotd_pinyin', word.pinyin),
        HomeWidget.saveWidgetData<String>('wotd_meaning', word.definition),
        HomeWidget.saveWidgetData<String>('wotd_date', dateKey),
        HomeWidget.saveWidgetData<String>(
          'wotd_url',
          wordOfTheDayUri(word).toString(),
        ),
      ]);
      await HomeWidget.updateWidget(iOSName: wordOfDayWidgetKind);
    } catch (error) {
      debugPrint('Word of the Day widget update failed: $error');
    }
  }

  Future<Uri?> initiallyLaunchedFromWidget() async {
    try {
      await init();
      return HomeWidget.initiallyLaunchedFromHomeWidget();
    } catch (error) {
      debugPrint('Unable to read the initial widget link: $error');
      return null;
    }
  }

  Stream<Uri?> get widgetClicks => HomeWidget.widgetClicked;
}
