import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../features/flashcards/data/models/flashcard_model.dart';
import '../features/flashcards/data/repositories/flashcard_repository_impl.dart';
import '../features/flashcards/domain/repositories/flashcard_repository.dart';

// 1. Provider for the Hive Box (The physical database box)
final hiveBoxProvider = Provider<Box<FlashcardModel>>((ref) {
  return Hive.box<FlashcardModel>('flashcards');
});

// 2. Provider for the Repository (The mechanic who uses the box)
final flashcardRepositoryProvider = Provider<FlashcardRepository>((ref) {
  final box = ref.watch(hiveBoxProvider);
  return FlashcardRepositoryImpl(box);
});