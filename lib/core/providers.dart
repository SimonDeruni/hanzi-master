import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
import 'package:hanzi_master/features/flashcards/data/repositories/flashcard_repository_impl.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/flashcard_repository.dart';
import 'package:hanzi_master/features/course/data/repositories/course_repository_impl.dart';
import 'package:hanzi_master/features/course/domain/repositories/course_repository.dart';
import 'package:hanzi_master/features/flashcards/data/repositories/global_dictionary_repository.dart';

// 1. Provider for the Hive Box (The physical database box)
final hiveBoxProvider = Provider<Box<FlashcardModel>>((ref) {
  return Hive.box<FlashcardModel>('flashcards');
});

// 2. Provider for the Repository (The mechanic who uses the box)
final flashcardRepositoryProvider = Provider<FlashcardRepository>((ref) {
  final box = ref.watch(hiveBoxProvider);
  return FlashcardRepositoryImpl(box);
});

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepositoryImpl();
});

final globalDictionaryRepositoryProvider = Provider<GlobalDictionaryRepository>((ref) {
  return GlobalDictionaryRepository();
});