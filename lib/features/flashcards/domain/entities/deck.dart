import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
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

  String localizedName(BuildContext context) {
    if (id == 'default') return AppLocalizations.of(context)!.theMainLibrary;
    if (id == 'hsk1') return AppLocalizations.of(context)!.hsk1Foundation;
    if (id == 'hsk2') return AppLocalizations.of(context)!.hsk2Elementary;
    if (id == 'hsk3') return AppLocalizations.of(context)!.hsk3Intermediate;
    return name;
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
