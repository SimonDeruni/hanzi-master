import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/echo_hall/domain/logic/generated_scenario_parser.dart';

void main() {
  const validJson = '''
{
  "title": "Dinner with Dad",
  "description": "You are choosing dinner together.",
  "personaName": "Dad (爸爸)",
  "initialAiMessage": "今晚想吃什么？",
  "initialEnglish": "What would you like for dinner tonight?",
  "quests": ["Suggest noodles", "Ask about tea", "Choose dessert"],
  "systemPrompt": "You are Dad. Stay in character."
}
''';

  test('parses a complete scenario response', () {
    final scenario = GeneratedScenarioData.parse(validJson);

    expect(scenario.title, 'Dinner with Dad');
    expect(scenario.personaName, 'Dad (爸爸)');
    expect(scenario.initialAiMessage, '今晚想吃什么？');
    expect(scenario.quests, hasLength(3));
  });

  test('unwraps markdown and surrounding model commentary', () {
    final scenario = GeneratedScenarioData.parse(
      'Here is the scenario:\n```json\n$validJson```\nEnjoy!',
    );

    expect(scenario.title, 'Dinner with Dad');
  });

  test('removes trailing object and array commas', () {
    final response = validJson
        .replaceFirst('"Choose dessert"]', '"Choose dessert",]')
        .replaceFirst(
          '"You are Dad. Stay in character."',
          '"You are Dad. Stay in character.",',
        );

    final scenario = GeneratedScenarioData.parse(response);

    expect(scenario.quests, hasLength(3));
    expect(scenario.systemPrompt, 'You are Dad. Stay in character.');
  });

  test('preserves commas and braces inside JSON strings', () {
    final response = validJson.replaceFirst(
      'You are choosing dinner together.',
      'Choose rice, noodles, or a dish with {vegetables}.',
    );

    final scenario = GeneratedScenarioData.parse(response);

    expect(
      scenario.description,
      'Choose rice, noodles, or a dish with {vegetables}.',
    );
  });

  test('rejects incomplete scenario data', () {
    expect(
      () => GeneratedScenarioData.parse('{"title":"Incomplete"}'),
      throwsFormatException,
    );
  });

  test('rejects malformed JSON instead of returning fallback content', () {
    expect(
      () => GeneratedScenarioData.parse('{"title": nope}'),
      throwsFormatException,
    );
  });
}
