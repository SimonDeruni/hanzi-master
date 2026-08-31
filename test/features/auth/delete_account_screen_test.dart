import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/auth/presentation/screens/delete_account_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  Widget buildSubject({
    required bool usesPassword,
    required AccountDeletionCallback onDelete,
  }) {
    return ProviderScope(
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: DeleteAccountScreen(
          usesPassword: usesPassword,
          onDelete: onDelete,
        ),
      ),
    );
  }

  Future<void> scrollToSubmit(WidgetTester tester) async {
    await tester.scrollUntilVisible(
      find.byKey(const Key('delete-account-submit')),
      250,
      scrollable: find.byType(Scrollable).first,
    );
  }

  testWidgets('shows retained local data and subscription warnings',
      (tester) async {
    await tester.pumpWidget(buildSubject(
      usesPassword: false,
      onDelete: (_) async {},
    ));

    expect(find.text('Data on this device will remain'), findsOneWidget);
    expect(find.textContaining('Study progress'), findsOneWidget);
    expect(find.text('Subscriptions are not canceled'), findsOneWidget);
    expect(find.textContaining('does not cancel an App Store subscription'),
        findsOneWidget);
    expect(find.text('Manage App Store Subscription'), findsOneWidget);
  });

  testWidgets('requires password before confirmation', (tester) async {
    var deletionCalls = 0;
    await tester.pumpWidget(buildSubject(
      usesPassword: true,
      onDelete: (_) async => deletionCalls++,
    ));

    await scrollToSubmit(tester);
    await tester.tap(find.byKey(const Key('delete-account-submit')));
    await tester.pump();

    expect(
        find.text('Enter your current password to continue.'), findsOneWidget);
    expect(find.text('Final confirmation'), findsNothing);
    expect(deletionCalls, 0);
  });

  testWidgets('canceling final confirmation does not delete', (tester) async {
    var deletionCalls = 0;
    await tester.pumpWidget(buildSubject(
      usesPassword: false,
      onDelete: (_) async => deletionCalls++,
    ));

    await scrollToSubmit(tester);
    await tester.tap(find.byKey(const Key('delete-account-submit')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(deletionCalls, 0);
    expect(find.byType(DeleteAccountScreen), findsOneWidget);
  });

  testWidgets('passes password and closes after successful deletion',
      (tester) async {
    String? receivedPassword;
    await tester.pumpWidget(buildSubject(
      usesPassword: true,
      onDelete: (password) async => receivedPassword = password,
    ));

    await tester.scrollUntilVisible(
      find.byKey(const Key('delete-account-password')),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(
      find.byKey(const Key('delete-account-password')),
      'secret-password',
    );
    await scrollToSubmit(tester);
    await tester.tap(find.byKey(const Key('delete-account-submit')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Account Permanently').last);
    await tester.pumpAndSettle();

    expect(receivedPassword, 'secret-password');
    expect(find.byType(DeleteAccountScreen), findsNothing);
  });

  testWidgets('shows actionable error and re-enables deletion after failure',
      (tester) async {
    final deletionStarted = Completer<void>();
    final finishDeletion = Completer<void>();
    await tester.pumpWidget(buildSubject(
      usesPassword: false,
      onDelete: (_) async {
        deletionStarted.complete();
        await finishDeletion.future;
        throw Exception('failure');
      },
    ));

    await scrollToSubmit(tester);
    await tester.tap(find.byKey(const Key('delete-account-submit')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Account Permanently').last);
    await deletionStarted.future;
    await tester.pump();

    expect(find.text('Deleting account...'), findsOneWidget);
    finishDeletion.complete();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('delete-account-error')), findsOneWidget);
    expect(find.textContaining('Your account remains active'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('delete-account-submit')))
          .onPressed,
      isNotNull,
    );
  });
}
