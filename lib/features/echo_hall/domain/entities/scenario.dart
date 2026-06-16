class ConversationScenario {
  final String id;
  final String title;
  final String description;
  final String initialAiMessage;
  final String systemPrompt;
  final int targetHskLevel;
  final String avatarAssetPath;
  final bool isCustom;

  ConversationScenario({
    required this.id,
    required this.title,
    required this.description,
    required this.initialAiMessage,
    required this.systemPrompt,
    required this.targetHskLevel,
    required this.avatarAssetPath,
    this.isCustom = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'initialAiMessage': initialAiMessage,
      'systemPrompt': systemPrompt,
      'targetHskLevel': targetHskLevel,
      'avatarAssetPath': avatarAssetPath,
      'isCustom': isCustom,
    };
  }

  factory ConversationScenario.fromJson(Map<String, dynamic> json) {
    return ConversationScenario(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      initialAiMessage: json['initialAiMessage'],
      systemPrompt: json['systemPrompt'],
      targetHskLevel: json['targetHskLevel'],
      avatarAssetPath: json['avatarAssetPath'],
      isCustom: json['isCustom'] ?? false,
    );
  }
}

// Pre-defined scenarios
final List<ConversationScenario> defaultScenarios = [
  ConversationScenario(
    id: 'food_1',
    title: 'Local Restaurant',
    description: 'Practice ordering dishes and asking for recommendations.',
    initialAiMessage: '你好！欢迎光临。请问你要点什么？',
    systemPrompt: 'Friendly but busy waiter at a Chinese restaurant. Respond naturally.',
    targetHskLevel: 2,
    avatarAssetPath: 'assets/mascot/waiter_avatar.png',
  ),
  ConversationScenario(
    id: 'taxi_1',
    title: 'Taxi to Airport',
    description: 'Tell the driver your destination and discuss the traffic.',
    initialAiMessage: '你好，去哪儿？今天路上有点儿堵。',
    systemPrompt: 'Talkative Beijing taxi driver. Use casual Mandarin.',
    targetHskLevel: 3,
    avatarAssetPath: 'assets/mascot/guide_avatar.png',
  ),
  ConversationScenario(
    id: 'market_1',
    title: 'Silk Market Haggling',
    description: 'Try to get a better price for a souvenir.',
    initialAiMessage: '这件衣服质量特别好，只要两百块。',
    systemPrompt: 'Shrewd market vendor. Negotiate prices firmly but fairly.',
    targetHskLevel: 4,
    avatarAssetPath: 'assets/mascot/waiter_avatar.png',
  ),
  ConversationScenario(
    id: 'doctor_1',
    title: 'Medical Clinic',
    description: 'Explain your symptoms to a traditional doctor.',
    initialAiMessage: '你哪里不舒服？发烧了吗？',
    systemPrompt: 'Calm and professional doctor. Ask about health symptoms.',
    targetHskLevel: 4,
    avatarAssetPath: 'assets/mascot/guide_avatar.png',
  ),
  ConversationScenario(
    id: 'intro_1',
    title: 'Meeting a Friend',
    description: 'Introduce yourself and make small talk.',
    initialAiMessage: '你好！好久不见，你最近怎么样？',
    systemPrompt: 'A good friend. Keep responses casual and short.',
    targetHskLevel: 2,
    avatarAssetPath: 'assets/mascot/friend_avatar.png',
  ),
  ConversationScenario(
    id: 'job_1',
    title: 'Job Interview',
    description: 'Apply for a role at a tech company in Shanghai.',
    initialAiMessage: '请先自我介绍一下。你为什么想来我们公司工作？',
    systemPrompt: 'Strict HR manager. Ask professional questions about experience.',
    targetHskLevel: 5,
    avatarAssetPath: 'assets/mascot/guide_avatar.png',
  ),
];
