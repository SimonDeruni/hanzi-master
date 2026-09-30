import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import '../../../../core/services/localized_deck_service.dart';
class Deck extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final int dailyNewCardsLimit;
  final int dailyReviewLimit;

  const Deck({
    required this.id,
    required this.name,
    this.description = '',
    required this.createdAt,
    this.dailyNewCardsLimit = 20,
    this.dailyReviewLimit = 100,
  });

  /// The deck's name in the reader's own language.
  ///
  /// Deck names are **content**, not chrome: the 20 thematic decks carry an
  /// English `title` in `thematic_decks_data.dart` and their translations live in
  /// `assets/data/l10n/deck_descriptions_<locale>.json`, read by
  /// [LocalizedDeckService]. The six HSK levels are chrome and come from
  /// `lib/l10n/*.arb`.
  ///
  /// This used to handle `default` and levels 1–3 and then `return name`, so
  /// **HSK 4–6 and every thematic deck showed their English name** — the deck
  /// library looked French (it calls [LocalizedDeckService.deckTitle] itself)
  /// while the deck it opened was headed "Fitness & Modern Training".
  String localizedName(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    switch (id) {
      case 'default':
        return l10n.theMainLibrary;
      case 'hsk1':
        return l10n.hsk1Foundation;
      case 'hsk2':
        return l10n.hsk2Elementary;
      case 'hsk3':
        return l10n.hsk3Intermediate;
      case 'hsk4':
        return l10n.hsk4UpperIntermediate;
      case 'hsk5':
        return l10n.hsk5Advanced;
      case 'hsk6':
        return l10n.hsk6Mastery;
    }
    return LocalizedDeckService.deckTitle(deckId: id, fallbackEn: name);
  }

  Deck copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    int? dailyNewCardsLimit,
    int? dailyReviewLimit,
  }) {
    return Deck(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      dailyNewCardsLimit: dailyNewCardsLimit ?? this.dailyNewCardsLimit,
      dailyReviewLimit: dailyReviewLimit ?? this.dailyReviewLimit,
    );
  }

  @override
  List<Object?> get props => [id, name, description, createdAt, dailyNewCardsLimit, dailyReviewLimit];
}
