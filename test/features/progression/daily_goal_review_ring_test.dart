import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/progression/presentation/widgets/daily_goal_review_ring.dart';

void main() {
  testWidgets('DailyGoalReviewRing renders progress percentage and card counts',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DailyGoalReviewRing(
            progress: 0.5,
            todayCards: 10,
            goalCards: 20,
            duration: Duration.zero,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('50%'), findsOneWidget);
    expect(find.text('10/20'), findsOneWidget);
  });
}
