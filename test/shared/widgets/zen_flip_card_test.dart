import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/shared/widgets/zen_flip_card.dart';

void main() {
  testWidgets('ZenFlipCard displays front when isFlipped is false',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ZenFlipCard(
            isFlipped: false,
            front: Text('Front Content'),
            back: Text('Back Content'),
          ),
        ),
      ),
    );

    expect(find.text('Front Content'), findsOneWidget);
    expect(find.text('Back Content'), findsNothing);
  });

  testWidgets('ZenFlipCard displays back when isFlipped is true',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ZenFlipCard(
            isFlipped: true,
            front: Text('Front Content'),
            back: Text('Back Content'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Back Content'), findsOneWidget);
    expect(find.text('Front Content'), findsNothing);
  });
}
