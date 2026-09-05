import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_card_picker_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class _EmptyFlashcardController extends FlashcardController {
  @override
  Future<List<Flashcard>> build() async => [];
}

void main() {
  testWidgets('renders the evaluated French add-to title', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          flashcardControllerProvider
              .overrideWith(_EmptyFlashcardController.new),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: DeckCardPickerScreen(
            deckId: 'deck-id',
            deckName: 'Favoris',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ajouter à Favoris'), findsOneWidget);
    expect(find.textContaining('Closure:'), findsNothing);
  });
}
