import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/notification_permission_screen.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('renders the onboarding notification prompt on a small screen',
      (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotificationPermissionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Never Miss a Stroke'), findsOneWidget);
    expect(find.text('Daily Drop'), findsOneWidget);
    expect(find.text('Review Reminders'), findsOneWidget);
    expect(find.text('Enable Notifications'), findsOneWidget);
    expect(find.text('Maybe Later'), findsOneWidget);
    expect(
      tester
          .getTopLeft(find.byKey(const Key('notification_permission_title')))
          .dy,
      OnboardingDesign.topPadding,
    );
    expect(
      tester
          .getTopLeft(find.byKey(const Key('notification_permission_title')))
          .dx,
      OnboardingDesign.horizontalPadding,
    );
    expect(
      tester
          .widget<Text>(
            find.byKey(const Key('notification_permission_title')),
          )
          .style
          ?.fontSize,
      OnboardingDesign.titleFontSize,
    );
    expect(
      tester
          .getSize(find.byKey(const Key('enable_notifications_button')))
          .height,
      OnboardingDesign.primaryButtonHeight,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('configured state keeps the shared onboarding layout',
      (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationServiceProvider.overrideWithValue(
            _FakeNotificationService(),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotificationPermissionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const Key('enable_notifications_button')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('enable_notifications_button')));
    await tester.pump();
    await tester.pump();

    final configuredTitle =
        find.byKey(const Key('notifications_configured_title'));
    expect(configuredTitle, findsOneWidget);
    expect(find.text('Notifications Configured'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
    expect(find.text('Maybe Later'), findsNothing);
    expect(
      tester.getTopLeft(configuredTitle).dx,
      OnboardingDesign.horizontalPadding,
    );
    expect(
      tester.widget<Text>(configuredTitle).style?.fontSize,
      OnboardingDesign.titleFontSize,
    );
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 600));
  });
}

class _FakeNotificationService extends NotificationService {
  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> setPracticeReminder({
    required bool enabled,
    required int hour,
    required int minute,
  }) async {}
}
