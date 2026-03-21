import 'package:fpdart/fpdart.dart';
import '../entities/course_unit.dart';

abstract class CourseRepository {
  Future<Either<String, List<CourseUnit>>> getCourseStructure();
}
