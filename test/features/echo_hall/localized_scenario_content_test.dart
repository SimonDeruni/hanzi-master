import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/localized_scenario_content.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';

void main() {
  const supportedLocales = <String>{
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'th',
    'vi',
  };

  const builtInPersonas = <String, String>{
    'food_1': 'Lǐ fúwùyuán (李服务员)',
    'taxi_1': 'Wáng shīfu (王师傅)',
    'market_1': 'Chén āyí (陈阿姨)',
    'doctor_1': 'Zhāng yīshēng (张医生)',
    'intro_1': 'Péngyou (朋友)',
    'job_1': 'Liú jīnglǐ (刘经理)',
  };

  test('every built-in persona has objectives in every locale', () {
    for (final id in builtInPersonas.keys) {
      for (final languageCode in supportedLocales) {
        final quests =
            LocalizedScenarioContent.quests(id, Locale(languageCode));
        expect(quests, hasLength(3),
            reason: '$id should support $languageCode');
        expect(quests!.every((quest) => quest.trim().isNotEmpty), isTrue);
      }
    }
  });

  test('job interview uses the reported French translations', () {
    expect(
      LocalizedScenarioContent.quests('job_1', const Locale('fr')),
      [
        'Présentez brièvement votre parcours professionnel',
        'Expliquez pourquoi vous souhaitez travailler pour cette entreprise',
        'Posez une question polie sur la culture de l’entreprise',
      ],
    );
  });

  test('every built-in persona uses its pinyin and Hanzi label', () {
    for (final entry in builtInPersonas.entries) {
      for (final languageCode in supportedLocales) {
        expect(
          LocalizedScenarioContent.personaName(
            entry.key,
            Locale(languageCode),
          ),
          entry.value,
          reason:
              '${entry.key} should have a standardized label in $languageCode',
        );
      }
    }
  });

  test('unknown locale falls back to English objectives', () {
    expect(
      LocalizedScenarioContent.quests('job_1', const Locale('nl')),
      LocalizedScenarioContent.quests('job_1', const Locale('en')),
    );
  });

  test('custom scenario fallbacks support every locale', () {
    for (final languageCode in supportedLocales) {
      final quests = LocalizedScenarioContent.customScenarioQuests(
        Locale(languageCode),
        'tea',
      );
      expect(quests, hasLength(3),
          reason: 'fallback should support $languageCode');
      expect(quests.every((quest) => quest.trim().isNotEmpty), isTrue);
    }
  });

  test('saved built-ins localize while custom scenarios preserve their content',
      () {
    final savedBuiltIn = _scenario(
      id: 'job_1',
      personaName: 'Manager Liu',
      quests: const ['old English objective'],
    );
    final custom = _scenario(
      id: 'custom-1',
      personaName: 'Mon personnage',
      quests: const ['Mon objectif'],
    );

    expect(
      savedBuiltIn.localizedQuests(const Locale('fr')).first,
      'Présentez brièvement votre parcours professionnel',
    );
    expect(
      savedBuiltIn.localizedPersonaName(const Locale('fr')),
      'Liú jīnglǐ (刘经理)',
    );
    expect(custom.localizedQuests(const Locale('fr')), ['Mon objectif']);
    expect(
      custom.localizedPersonaName(const Locale('fr')),
      'Mon personnage',
    );
  });
}

ConversationScenario _scenario({
  required String id,
  required String personaName,
  required List<String> quests,
}) =>
    ConversationScenario(
      id: id,
      title: 'Title',
      description: 'Description',
      initialAiMessage: '你好',
      systemPrompt: 'Prompt',
      targetHskLevel: 1,
      avatarAssetPath: 'none',
      personaName: personaName,
      quests: quests,
      isCustom: true,
    );
