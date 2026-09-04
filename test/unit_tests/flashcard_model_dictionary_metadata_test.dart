import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
import 'package:hanzi_master/features/flashcards/data/models/review_stats_model.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory =
        await Directory.systemTemp.createTemp('flashcard-test-');
    Hive.init(temporaryDirectory.path);
    Hive.registerAdapter(FlashcardModelAdapter());
    Hive.registerAdapter(ReviewStatsModelAdapter());
  });

  tearDown(() async {
    await Hive.close();
    await temporaryDirectory.delete(recursive: true);
  });

  test('saved cards preserve dictionary expansion provenance', () async {
    const card = Flashcard(
      id: 'global_42',
      hanzi: '测试',
      pinyin: 'cè shì',
      definition: 'test',
      definitionLanguage: 'French',
      dictionaryWordId: 42,
      englishDefinition: 'to test; a test',
      localizedDefinitionQuality: 40,
      isExpansionEligible: true,
      sourceDefinitionHash:
          '000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f',
      hskLevel: 0,
      strokePaths: [],
      modeStats: {},
    );

    final box = await Hive.openBox<FlashcardModel>('flashcards');
    await box.put(card.id, FlashcardModel.fromEntity(card));
    final restored = box.get(card.id)!.toEntity();

    expect(restored.definitionLanguage, 'French');
    expect(restored.dictionaryWordId, 42);
    expect(restored.englishDefinition, 'to test; a test');
    expect(restored.localizedDefinitionQuality, 40);
    expect(restored.isExpansionEligible, isTrue);
    expect(restored.sourceDefinitionHash, card.sourceDefinitionHash);
  });
}
