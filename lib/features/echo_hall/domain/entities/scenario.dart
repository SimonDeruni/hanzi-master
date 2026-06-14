class ConversationScenario {
  final String id;
  final String title;
  final String description;
  final String initialAiMessage;
  final String systemPrompt;
  final int targetHskLevel;
  final String iconEmoji;
  final String avatarAssetPath;

  ConversationScenario({
    required this.id,
    required this.title,
    required this.description,
    required this.initialAiMessage,
    required this.systemPrompt,
    required this.targetHskLevel,
    required this.iconEmoji,
    required this.avatarAssetPath,
  });
}

// Pre-defined scenarios
final List<ConversationScenario> defaultScenarios = [
  ConversationScenario(
    id: 'food_1',
    title: 'Ordering Food',
    description: 'Practice ordering dishes and asking for recommendations at a local restaurant.',
    initialAiMessage: '你好！欢迎光临。请问你要点什么？(Hello! Welcome. What would you like to order?)',
    systemPrompt: 'You are a friendly but busy waiter at a Chinese restaurant. Keep responses short (1-2 sentences). Respond naturally to the user\'s order. Do not provide pinyin or english translations, just the Chinese characters.',
    targetHskLevel: 2,
    iconEmoji: '🥟',
    avatarAssetPath: 'assets/mascot/waiter_avatar.png',
  ),
  ConversationScenario(
    id: 'intro_1',
    title: 'Meeting a Friend',
    description: 'Introduce yourself, ask about their day, and make small talk.',
    initialAiMessage: '你好！好久不见，你最近怎么样？(Hello! Long time no see, how have you been lately?)',
    systemPrompt: 'You are a good friend of the user. Keep responses casual and short (1-2 sentences). Ask follow-up questions to keep the conversation going. Do not provide pinyin or english translations, just the Chinese characters.',
    targetHskLevel: 2,
    iconEmoji: '👋',
    avatarAssetPath: 'assets/mascot/friend_avatar.png',
  ),
  ConversationScenario(
    id: 'directions_1',
    title: 'Asking for Directions',
    description: 'You are lost in Beijing. Ask for directions to the subway station.',
    initialAiMessage: '有什么我可以帮你的吗？(Is there anything I can help you with?)',
    systemPrompt: 'You are a helpful local in Beijing. The user is asking for directions. Give realistic but simple directions using HSK 2/3 vocabulary. Keep it short (1-2 sentences). Do not provide pinyin or english translations.',
    targetHskLevel: 3,
    iconEmoji: '🗺️',
    avatarAssetPath: 'assets/mascot/guide_avatar.png',
  ),
];
