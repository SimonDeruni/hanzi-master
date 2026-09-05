import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/main.dart';

void main() {
  testWidgets('releases the first frame when initialization completes',
      (tester) async {
    final completer = Completer<ProviderContainer>();
    final container = ProviderContainer();
    addTearDown(container.dispose);
    var releaseCount = 0;

    await tester.pumpWidget(
      HanziMasterBootstrapApp(
        initializeServices: () => completer.future,
        bootstrapTimeout: const Duration(seconds: 5),
        appBuilder: (_) => const MaterialApp(home: Text('Ready')),
        onFirstFrameReady: () => releaseCount++,
      ),
    );

    expect(find.text('Ready'), findsNothing);
    expect(releaseCount, 0);

    completer.complete(container);
    await tester.pump();
    await tester.pump();

    expect(find.text('Ready'), findsOneWidget);
    expect(releaseCount, 1);

    await tester.pump();
    expect(releaseCount, 1);
  });

  testWidgets('shows timeout recovery and resumes the existing attempt',
      (tester) async {
    final completer = Completer<ProviderContainer>();
    final container = ProviderContainer();
    addTearDown(container.dispose);
    var attemptCount = 0;

    await tester.pumpWidget(
      HanziMasterBootstrapApp(
        initializeServices: () {
          attemptCount++;
          return completer.future;
        },
        bootstrapTimeout: const Duration(seconds: 1),
        appBuilder: (_) => const MaterialApp(home: Text('Ready')),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(StartupErrorScreen), findsOneWidget);
    expect(find.textContaining('longer than expected'), findsOneWidget);

    await tester.tap(find.byKey(const Key('startupRetryButton')));
    await tester.pump();
    expect(attemptCount, 1);
    expect(find.byType(StartupErrorScreen), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Ready'), findsNothing);

    completer.complete(container);
    await tester.pump();
    expect(find.text('Ready'), findsOneWidget);
  });

  testWidgets('retries with a new attempt after initialization fails',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    var attemptCount = 0;

    await tester.pumpWidget(
      HanziMasterBootstrapApp(
        initializeServices: () async {
          attemptCount++;
          if (attemptCount == 1) throw StateError('initialization failed');
          return container;
        },
        bootstrapTimeout: const Duration(seconds: 5),
        appBuilder: (_) => const MaterialApp(home: Text('Ready')),
      ),
    );
    await tester.pump();

    expect(find.byType(StartupErrorScreen), findsOneWidget);
    await tester.tap(find.byKey(const Key('startupRetryButton')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));

    expect(attemptCount, 2);
    expect(find.text('Ready'), findsOneWidget);
  });
}
