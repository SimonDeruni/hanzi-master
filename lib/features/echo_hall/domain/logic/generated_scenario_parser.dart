import 'dart:convert';

class GeneratedScenarioData {
  const GeneratedScenarioData({
    required this.title,
    required this.description,
    required this.personaName,
    required this.initialAiMessage,
    required this.initialEnglish,
    required this.quests,
    required this.systemPrompt,
  });

  final String title;
  final String description;
  final String personaName;
  final String initialAiMessage;
  final String initialEnglish;
  final List<String> quests;
  final String systemPrompt;

  factory GeneratedScenarioData.parse(String response) {
    final jsonObject = _extractJsonObject(response);
    final decoded = jsonDecode(_removeTrailingCommas(jsonObject));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Scenario response must be a JSON object.');
    }

    String requiredString(String key) {
      final value = decoded[key];
      if (value is! String || value.trim().isEmpty) {
        throw FormatException('Scenario response is missing "$key".');
      }
      return value.trim();
    }

    final rawQuests = decoded['quests'];
    if (rawQuests is! List || rawQuests.length < 3) {
      throw const FormatException(
        'Scenario response must contain at least three quests.',
      );
    }
    final quests = rawQuests.map((quest) {
      if (quest is! String || quest.trim().isEmpty) {
        throw const FormatException(
          'Scenario quests must be non-empty strings.',
        );
      }
      return quest.trim();
    }).toList(growable: false);

    return GeneratedScenarioData(
      title: requiredString('title'),
      description: requiredString('description'),
      personaName: requiredString('personaName'),
      initialAiMessage: requiredString('initialAiMessage'),
      initialEnglish: requiredString('initialEnglish'),
      quests: quests,
      systemPrompt: requiredString('systemPrompt'),
    );
  }
}

String _extractJsonObject(String response) {
  final start = response.indexOf('{');
  if (start == -1) {
    throw const FormatException('Scenario response does not contain JSON.');
  }

  var depth = 0;
  var inString = false;
  var isEscaped = false;

  for (var index = start; index < response.length; index++) {
    final character = response[index];
    if (inString) {
      if (isEscaped) {
        isEscaped = false;
      } else if (character == r'\') {
        isEscaped = true;
      } else if (character == '"') {
        inString = false;
      }
      continue;
    }

    if (character == '"') {
      inString = true;
    } else if (character == '{') {
      depth++;
    } else if (character == '}') {
      depth--;
      if (depth == 0) {
        return response.substring(start, index + 1);
      }
    }
  }

  throw const FormatException('Scenario JSON object is incomplete.');
}

String _removeTrailingCommas(String source) {
  final output = StringBuffer();
  var inString = false;
  var isEscaped = false;

  for (var index = 0; index < source.length; index++) {
    final character = source[index];
    if (inString) {
      output.write(character);
      if (isEscaped) {
        isEscaped = false;
      } else if (character == r'\') {
        isEscaped = true;
      } else if (character == '"') {
        inString = false;
      }
      continue;
    }

    if (character == '"') {
      inString = true;
      output.write(character);
      continue;
    }

    if (character == ',') {
      var nextIndex = index + 1;
      while (nextIndex < source.length && source[nextIndex].trim().isEmpty) {
        nextIndex++;
      }
      if (nextIndex < source.length &&
          (source[nextIndex] == '}' || source[nextIndex] == ']')) {
        continue;
      }
    }

    output.write(character);
  }

  return output.toString();
}
