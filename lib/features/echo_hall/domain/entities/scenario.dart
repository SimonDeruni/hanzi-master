import 'package:flutter/widgets.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'localized_scenario_content.dart';

class ConversationScenario {
  final String id;
  final String title;
  final String description;
  final String initialAiMessage;
  final String? initialEnglish;
  final String? initialPinyin;
  final String systemPrompt;
  final int targetHskLevel;
  final String avatarAssetPath;
  final String? backgroundAudioPath;
  final String? backgroundAssetPath;
  final List<String> quests;
  final String personaName;
  final bool isCustom;
  final String voiceName;
  final String? deckId;

  ConversationScenario({
    required this.id,
    required this.title,
    required this.description,
    required this.initialAiMessage,
    this.initialEnglish,
    this.initialPinyin,
    required this.systemPrompt,
    required this.targetHskLevel,
    required this.avatarAssetPath,
    this.backgroundAudioPath,
    this.backgroundAssetPath,
    this.quests = const [],
    this.personaName = 'Assistant',
    this.isCustom = false,
    this.voiceName = 'Puck',
    this.deckId,
  });

  bool get hasAvatar =>
      avatarAssetPath.isNotEmpty && avatarAssetPath != 'none' && !isCustom;

  String get resolvedAvatarAssetPath {
    if (hasAvatar) {
      return avatarAssetPath;
    }
    return 'none';
  }

  String localizedPersonaName(Locale locale) =>
      LocalizedScenarioContent.personaName(id, locale) ?? personaName;

  List<String> localizedQuests(Locale locale) =>
      LocalizedScenarioContent.quests(id, locale) ?? quests;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'initialAiMessage': initialAiMessage,
      'initialEnglish': initialEnglish,
      'initialPinyin': initialPinyin,
      'systemPrompt': systemPrompt,
      'targetHskLevel': targetHskLevel,
      'avatarAssetPath': avatarAssetPath,
      'backgroundAudioPath': backgroundAudioPath,
      'backgroundAssetPath': backgroundAssetPath,
      'quests': quests,
      'personaName': personaName,
      'isCustom': isCustom,
      'voiceName': voiceName,
      'deckId': deckId,
    };
  }

  factory ConversationScenario.fromJson(Map<String, dynamic> json) {
    return ConversationScenario(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      initialAiMessage: json['initialAiMessage'],
      initialEnglish: json['initialEnglish'],
      initialPinyin: json['initialPinyin'],
      systemPrompt: json['systemPrompt'],
      targetHskLevel: json['targetHskLevel'],
      avatarAssetPath: json['avatarAssetPath'] ?? '',
      backgroundAudioPath: json['backgroundAudioPath'],
      backgroundAssetPath: json['backgroundAssetPath'],
      quests: List<String>.from(json['quests'] ?? []),
      personaName: json['personaName'] ?? 'Assistant',
      isCustom: json['isCustom'] ?? false,
      voiceName: json['voiceName'] ?? 'Puck',
      deckId: json['deckId'],
    );
  }
}

// Pre-defined scenarios
List<ConversationScenario> getDefaultScenarios(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final locale = Localizations.localeOf(context);
  List<String> quests(String id) =>
      LocalizedScenarioContent.quests(id, locale) ?? const [];
  String persona(String id) =>
      LocalizedScenarioContent.personaName(id, locale)!;
  return [
    ConversationScenario(
      id: 'food_1',
      title: l10n.scenarioLocalRestaurant,
      description: l10n.scenarioLocalRestaurantDesc,
      initialAiMessage: '你好！欢迎光临。请问你要点什么？',
      systemPrompt:
          'You are Waiter Li, a friendly but busy waiter at a bustling Chinese restaurant. Your ONLY role is a restaurant waiter. Use natural conversational Mandarin. NEVER break character or introduce yourself as anything other than a waiter. Keep responses short and practical. Respond to food orders naturally.',
      initialEnglish: 'Hello! Welcome. What would you like to order?',
      initialPinyin:
          'Ni3 hao3! Huan1ying2 guang1lin2. Qing3wen4 ni3 yao4 dian3 shen2me?',
      targetHskLevel: 2,
      avatarAssetPath: 'assets/mascot/waiter_avatar.png',
      backgroundAssetPath: 'assets/environments/restaurant.jpg',
      personaName: persona('food_1'),
      quests: quests('food_1'),
      voiceName: 'Fenrir',
    ),
    ConversationScenario(
      id: 'taxi_1',
      title: l10n.scenarioTaxiAirport,
      description: l10n.scenarioTaxiAirportDesc,
      initialAiMessage: '你好，去哪儿？今天路上有点儿堵。',
      systemPrompt:
          'You are Driver Wang, a talkative taxi driver in Beijing. Your ONLY role is a Beijing taxi driver. Use casual, colloquial Beijing Mandarin. NEVER break character or introduce yourself as anything other than a taxi driver. Complain about traffic, talk about the weather, and respond naturally to passenger requests.',
      initialEnglish: 'Where are you going? The airport? It is quite a trip!',
      initialPinyin: 'Ni3 qu4 na3r a? Ji1chang3 ma? Ting3 yuan3 de!',
      targetHskLevel: 3,
      avatarAssetPath: 'assets/mascot/taxi_driver_avatar.png',
      backgroundAssetPath: 'assets/environments/taxi.jpg',
      personaName: persona('taxi_1'),
      quests: quests('taxi_1'),
      voiceName: 'Charon',
    ),
    ConversationScenario(
      id: 'market_1',
      title: l10n.scenarioSilkMarket,
      description: l10n.scenarioSilkMarketDesc,
      initialAiMessage: '这件衣服质量特别好，只要两百块。',
      systemPrompt:
          'You are Auntie Chen, a shrewd market vendor selling silk and fabrics. Your ONLY role is a market vendor. Negotiate prices firmly but fairly in Mandarin. NEVER break character or introduce yourself as anything other than a vendor. Start with high prices and be willing to bargain down.',
      initialEnglish:
          'This clothing quality is especially good, only 200 kuai.',
      initialPinyin:
          'Zhe4 jian4 yi1fu zhi4liang4 te4bie2 hao3, zhi3yao4 liang3 bai3 kuai4.',
      targetHskLevel: 4,
      avatarAssetPath: 'assets/mascot/market_vendor_avatar.png',
      backgroundAssetPath: 'assets/environments/market.jpg',
      personaName: persona('market_1'),
      quests: quests('market_1'),
      voiceName: 'Kore',
    ),
    ConversationScenario(
      id: 'doctor_1',
      title: l10n.scenarioMedicalClinic,
      description: l10n.scenarioMedicalClinicDesc,
      initialAiMessage: '你哪里不舒服？发烧了吗？',
      systemPrompt:
          'You are Dr. Zhang, a calm and professional doctor at a medical clinic. Your ONLY role is a doctor. Ask about health symptoms and provide medical advice in Mandarin. NEVER break character or introduce yourself as anything other than a doctor. Be reassuring but thorough.',
      initialEnglish: 'Where do you feel uncomfortable? Do you have a fever?',
      initialPinyin: 'Ni3 na3li3 bu4 shu1fu? Fa1shao1 le ma?',
      targetHskLevel: 4,
      avatarAssetPath: 'assets/mascot/doctor_avatar.png',
      backgroundAssetPath: 'assets/environments/clinic.jpg',
      personaName: persona('doctor_1'),
      quests: quests('doctor_1'),
      voiceName: 'Aoede',
    ),
    ConversationScenario(
      id: 'intro_1',
      title: l10n.scenarioMeetingFriend,
      description: l10n.scenarioMeetingFriendDesc,
      initialAiMessage: '你好！好久不见，你最近怎么样？',
      systemPrompt:
          'You are a close friend catching up after a long time. Your ONLY role is a friend. Keep responses casual, warm, and short in Mandarin. NEVER break character or introduce yourself as anything other than a friend. Use informal speech patterns appropriate for close friends.',
      initialEnglish: 'Hey! Long time no see, how have you been lately?',
      initialPinyin: 'Ni3 hao3! Hao3jiu3 bu4jian4, ni3 zui4jin4 zen3me yang4?',
      targetHskLevel: 2,
      avatarAssetPath: 'assets/mascot/friend_avatar.png',
      personaName: persona('intro_1'),
      quests: quests('intro_1'),
      voiceName: 'Aoede',
    ),
    ConversationScenario(
      id: 'job_1',
      title: l10n.scenarioJobInterview,
      description: l10n.scenarioJobInterviewDesc,
      initialAiMessage: '请先自我介绍一下。你为什么想来我们公司工作？',
      systemPrompt:
          'You are Manager Liu, a strict HR manager conducting a job interview. Your ONLY role is an HR interviewer. Ask professional questions about work experience and qualifications in Mandarin. NEVER break character or introduce yourself as anything other than an interviewer. Maintain a formal, evaluating tone.',
      initialEnglish:
          'Please introduce yourself. Why do you want to work at our company?',
      initialPinyin:
          'Qing3 xian1 zi4wo3 jie4shao4 yi1xia4. Ni3 wei4shen2me xiang3 lai2 wo3men gong1si1 gong1zuo4?',
      targetHskLevel: 5,
      avatarAssetPath: 'assets/mascot/interviewer_avatar.png',
      backgroundAssetPath: 'assets/environments/office.jpg',
      personaName: persona('job_1'),
      quests: quests('job_1'),
      voiceName: 'Puck',
    ),
  ];
}
