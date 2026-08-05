import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('lib/l10n/app_en.arb');
  final jsonStr = file.readAsStringSync();
  final data = json.decode(jsonStr) as Map<String, dynamic>;

  data.addAll({
    'scenarioLocalRestaurant': 'Local Restaurant',
    'scenarioLocalRestaurantDesc': 'Practice ordering dishes and asking for recommendations.',
    'scenarioTaxiAirport': 'Taxi to Airport',
    'scenarioTaxiAirportDesc': 'Tell the driver your destination and discuss the traffic.',
    'scenarioSilkMarket': 'Silk Market Haggling',
    'scenarioSilkMarketDesc': 'Try to get a better price for a souvenir.',
    'scenarioMedicalClinic': 'Medical Clinic',
    'scenarioMedicalClinicDesc': 'Explain your symptoms to a traditional doctor.',
    'scenarioMeetingFriend': 'Meeting a Friend',
    'scenarioMeetingFriendDesc': 'Introduce yourself and make small talk.',
    'scenarioJobInterview': 'Job Interview',
    'scenarioJobInterviewDesc': 'Apply for a role at a tech company in Shanghai.',
    'createCustomScenario': 'Create Custom Scenario',
    'customScenarioTitleHint': 'Title (e.g. Wedding Reception)',
    'customScenarioDescHint': 'Description (Context)',
    'customScenarioPersonaHint': 'AI Persona (e.g. A curious coworker)',
    'customScenarioDifficulty': 'Difficulty',
    'createAction': 'Create',
    'cancelAction': 'Cancel',
    'mythsAndLegends': 'Myths & Legends',
    'historyAndCulture': 'History & Culture',
    'idiomsTitle': 'Idioms (成语)',
    'theMonkeyKing': 'The Monkey King',
    'theMonkeyKingDesc': 'Sun Wukong (Journey to the West)',
    'huaMulan': 'Hua Mulan',
    'huaMulanDesc': 'Hua Mulan joining the army instead of her father',
    'confuciusTitle': 'Confucius',
    'confuciusDesc': 'The life and teachings of Confucius',
    'theGreatWall': 'The Great Wall',
    'theGreatWallDesc': 'Building the Great Wall of China',
    'generateTopic': 'Generate Topic',
    'simplifyText': 'Simplify Text',
    'topicHint': 'Topic (e.g. Aliens in Beijing)',
    'tagsHint': 'Tags (comma separated, optional)',
    'createMagic': 'Create Magic',
    'speakWithMasterLin': 'Speak with Master Lin',
    'masterLinGreeting': 'Greetings, student. The ink is ready. What character or phrase shall we examine today?',
    'typeYourMessage': 'Type your message...'
  });

  file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(data));
  print('Added keys to app_en.arb');
}
