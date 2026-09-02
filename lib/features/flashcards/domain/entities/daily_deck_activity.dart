import 'package:equatable/equatable.dart';

class DailyDeckActivity extends Equatable {
  const DailyDeckActivity({
    required this.deckId,
    required this.dayKey,
    this.introducedCardIds = const {},
    this.reviewedCardIds = const {},
    this.modeIntroductionKeys = const {},
  });

  final String deckId;
  final String dayKey;
  final Set<String> introducedCardIds;
  final Set<String> reviewedCardIds;
  final Set<String> modeIntroductionKeys;

  @override
  List<Object?> get props => [
        deckId,
        dayKey,
        introducedCardIds,
        reviewedCardIds,
        modeIntroductionKeys,
      ];
}
