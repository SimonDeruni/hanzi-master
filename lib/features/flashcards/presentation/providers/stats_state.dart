import 'package:equatable/equatable.dart';

class StatsState extends Equatable {
  final int total;
  final int mastered;
  final int learning;
  final int newCards;
  final double accuracy;

  const StatsState({
    required this.total,
    required this.mastered,
    required this.learning,
    required this.newCards,
    required this.accuracy,
  });

  factory StatsState.empty() {
    return const StatsState(
      total: 0,
      mastered: 0,
      learning: 0,
      newCards: 0,
      accuracy: 0.0,
    );
  }

  @override
  List<Object?> get props => [total, mastered, learning, newCards, accuracy];
}
