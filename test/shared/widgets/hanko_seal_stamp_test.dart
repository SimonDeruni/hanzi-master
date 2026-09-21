import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/shared/widgets/hanko_seal_stamp.dart';

void main() {
  testWidgets('HankoSealStamp displays correct characters and labels for each grade',
      (tester) async {
    for (final grade in [0, 2, 4, 5]) {
      final data = HankoSealData.fromGrade(grade);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HankoSealStamp(data: data),
          ),
        ),
      );

      expect(find.text(data.sealCharacters), findsOneWidget);
      expect(find.text(data.label), findsOneWidget);
    }
  });
}
