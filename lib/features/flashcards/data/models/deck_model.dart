import 'package:hive/hive.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';

part 'deck_model.g.dart';

@HiveType(typeId: 1)
class DeckModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime createdAt;

  DeckModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.createdAt,
  });

  factory DeckModel.fromDomain(Deck deck) {
    return DeckModel(
      id: deck.id,
      name: deck.name,
      description: deck.description,
      createdAt: deck.createdAt,
    );
  }

  Deck toDomain() {
    return Deck(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
    );
  }
}
