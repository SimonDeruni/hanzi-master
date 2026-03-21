import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_master/core/providers.dart';
import '../../domain/entities/course_unit.dart';

part 'course_controller.g.dart';

@riverpod
class CourseController extends _$CourseController {
  @override
  Future<List<CourseUnit>> build() async {
    final repository = ref.read(courseRepositoryProvider);
    final result = await repository.getCourseStructure();
    return result.fold(
      (error) => [],
      (units) => units, // Return deterministic order (sorted by size/theme)
    );
  }
}
