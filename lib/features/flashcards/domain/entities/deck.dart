import 'package:equatable/equatable.dart';

class Deck extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;

  const Deck({
    required this.id,
    required this.name,
    this.description = '',
    required this.createdAt,
  });

  Deck copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
  }) {
    return Deck(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, description, createdAt];
}
