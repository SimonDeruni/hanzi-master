import 'package:flutter/widgets.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class ConversationScenario {
  final String id;
  final String title;
  final String description;
  final String initialAiMessage;
  final String systemPrompt;
  final int targetHskLevel;
  final String avatarAssetPath;
  final String? backgroundAudioPath;
  final bool isCustom;
  final String voiceName;

  ConversationScenario({
    required this.id,
    required this.title,
    required this.description,
    required this.initialAiMessage,
    required this.systemPrompt,
    required this.targetHskLevel,
    required this.avatarAssetPath,
    this.backgroundAudioPath,
    this.isCustom = false,
    this.voiceName = 'Puck',
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
      'backgroundAudioPath': backgroundAudioPath,
      'isCustom': isCustom,
      'voiceName': voiceName,
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
      backgroundAudioPath: json['backgroundAudioPath'],
      isCustom: json['isCustom'] ?? false,
      voiceName: json['voiceName'] ?? 'Puck',
    );
  }
}

// Pre-defined scenarios
List<ConversationScenario> getDefaultScenarios(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return [
    ConversationScenario(
      id: 'food_1',
      title: l10n.scenarioLocalRestaurant,
      description: l10n.scenarioLocalRestaurantDesc,
      initialAiMessage: '你好！欢迎光临。请问你要点什么？',
      systemPrompt: 'Friendly but busy waiter at a Chinese restaurant. Respond naturally.',
      targetHskLevel: 2,
      avatarAssetPath: 'assets/mascot/waiter_avatar.png',
      voiceName: 'Fenrir',
    ),
    ConversationScenario(
      id: 'taxi_1',
      title: l10n.scenarioTaxiAirport,
      description: l10n.scenarioTaxiAirportDesc,
      initialAiMessage: '你好，去哪儿？今天路上有点儿堵。',
      systemPrompt: 'Talkative Beijing taxi driver. Use casual Mandarin.',
      targetHskLevel: 3,
      avatarAssetPath: 'assets/mascot/taxi_driver_avatar.png',
      voiceName: 'Charon',
    ),
    ConversationScenario(
      id: 'market_1',
      title: l10n.scenarioSilkMarket,
      description: l10n.scenarioSilkMarketDesc,
      initialAiMessage: '这件衣服质量特别好，只要两百块。',
      systemPrompt: 'Shrewd market vendor. Negotiate prices firmly but fairly.',
      targetHskLevel: 4,
      avatarAssetPath: 'assets/mascot/market_vendor_avatar.png',
      voiceName: 'Kore',
    ),
    ConversationScenario(
      id: 'doctor_1',
      title: l10n.scenarioMedicalClinic,
      description: l10n.scenarioMedicalClinicDesc,
      initialAiMessage: '你哪里不舒服？发烧了吗？',
      systemPrompt: 'Calm and professional doctor. Ask about health symptoms.',
      targetHskLevel: 4,
      avatarAssetPath: 'assets/mascot/doctor_avatar.png',
      voiceName: 'Fenrir',
    ),
    ConversationScenario(
      id: 'intro_1',
      title: l10n.scenarioMeetingFriend,
      description: l10n.scenarioMeetingFriendDesc,
      initialAiMessage: '你好！好久不见，你最近怎么样？',
      systemPrompt: 'A good friend. Keep responses casual and short.',
      targetHskLevel: 2,
      avatarAssetPath: 'assets/mascot/friend_avatar.png',
      voiceName: 'Aoede',
    ),
    ConversationScenario(
      id: 'job_1',
      title: l10n.scenarioJobInterview,
      description: l10n.scenarioJobInterviewDesc,
      initialAiMessage: '请先自我介绍一下。你为什么想来我们公司工作？',
      systemPrompt: 'Strict HR manager. Ask professional questions about experience.',
      targetHskLevel: 5,
      avatarAssetPath: 'assets/mascot/hr_manager_avatar.png',
      voiceName: 'Kore',
    ),
  ];
}
