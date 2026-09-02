import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_review_session_screen.dart';

void main() {
  testWidgets('session screen exposes the requested deck and mode',
      (tester) async {
    const screen = DeckReviewSessionScreen(
      deckId: 'deck-a',
      mode: StudyMode.reading,
    );

    expect(screen.deckId, 'deck-a');
    expect(screen.mode, StudyMode.reading);
    expect(screen.studyAhead, isFalse);
    expect(screen.createState(), isNotNull);
  });
}
