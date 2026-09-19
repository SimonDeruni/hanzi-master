import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  const maleVoices = {'Fenrir', 'Charon', 'Puck', 'zh-CN-YunxiNeural', 'zh-CN-YunyangNeural', 'zh-CN-YunjianNeural'};
  const femaleVoices = {'Kore', 'Aoede', 'zh-CN-XiaoxiaoNeural', 'zh-CN-XiaoyiNeural'};

  const maleAvatars = {
    'assets/mascot/doctor_avatar.png',
    'assets/mascot/waiter_avatar.png',
    'assets/mascot/taxi_driver_avatar.png',
    'assets/mascot/interviewer_avatar.png',
  };

  const femaleAvatars = {
    'assets/mascot/friend_avatar.png',
    'assets/mascot/guide_avatar.png',
    'assets/mascot/market_vendor_avatar.png',
  };

  group('Echo Hall Avatar and Voice Gender Parity', () {
    testWidgets('all built-in scenarios have matching avatar and voice genders',
        (tester) async {
      late List<ConversationScenario> scenarios;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(builder: (context) {
            scenarios = getDefaultScenarios(context);
            return const SizedBox();
          }),
        ),
      );

      for (final scenario in scenarios) {
        final avatar = scenario.avatarAssetPath;
        final voice = scenario.voiceName;

        if (maleAvatars.contains(avatar)) {
          expect(maleVoices.contains(voice), isTrue,
              reason:
                  'Scenario ${scenario.id} has male avatar $avatar but voice $voice is not male');
        } else if (femaleAvatars.contains(avatar)) {
          expect(femaleVoices.contains(voice), isTrue,
              reason:
                  'Scenario ${scenario.id} has female avatar $avatar but voice $voice is not female');
        }
      }
    });

    test('Dr. Zhang clinic scenario specifically pairs male doctor avatar with male voice', () {
      final (avatar, voice) =
          ConversationScenario.pickAvatarAndVoice('Dr. Zhang', 'Medical Clinic');
      expect(avatar, equals('assets/mascot/doctor_avatar.png'));
      expect(maleVoices.contains(voice), isTrue);
      expect(voice, equals('Charon'));
    });

    test('female personas are assigned female avatars and voices', () {
      final femaleTestCases = [
        ('Grandma Liu', 'Handmade Dumpling Feast'),
        ('Auntie Ma', 'Street Food Night Market'),
        ('Waitress Xiao Li', 'Teahouse in Chengdu'),
        ('Nurse Wang', 'Health Consultation'),
        ('Tour Guide Li Mei', 'Forbidden City Tour'),
        ('My Sister', 'Catching up at home'),
        ('阿姨', '买菜'),
      ];

      for (final (persona, title) in femaleTestCases) {
        final (avatar, voice) =
            ConversationScenario.pickAvatarAndVoice(persona, title);
        expect(femaleAvatars.contains(avatar), isTrue,
            reason: '$persona in $title got non-female avatar $avatar');
        expect(femaleVoices.contains(voice), isTrue,
            reason: '$persona in $title got non-female voice $voice');
      }
    });

    test('male personas are assigned male avatars and voices', () {
      final maleTestCases = [
        ('Master Zhao', 'Tea Tasting in Chengdu'),
        ('Driver Wang', 'Taxi to Airport'),
        ('Manager Liu', 'Job Interview'),
        ('Dr. Zhang', 'Clinic Visit'),
        ('My Brother', 'Chatting about games'),
        ('Uncle Chen', 'Family Dinner'),
        ('师傅', '修车'),
      ];

      for (final (persona, title) in maleTestCases) {
        final (avatar, voice) =
            ConversationScenario.pickAvatarAndVoice(persona, title);
        expect(maleAvatars.contains(avatar), isTrue,
            reason: '$persona in $title got non-male avatar $avatar');
        expect(maleVoices.contains(voice), isTrue,
            reason: '$persona in $title got non-male voice $voice');
      }
    });

    test('hasAvatar returns true for valid avatar paths even when isCustom is true', () {
      final customScenario = ConversationScenario(
        id: 'custom-1',
        title: 'Custom Persona',
        description: 'Testing avatar',
        initialAiMessage: '你好',
        systemPrompt: 'You are custom',
        targetHskLevel: 2,
        avatarAssetPath: 'assets/mascot/doctor_avatar.png',
        isCustom: true,
      );

      expect(customScenario.hasAvatar, isTrue);
      expect(customScenario.resolvedAvatarAssetPath,
          equals('assets/mascot/doctor_avatar.png'));
    });
  });
}
