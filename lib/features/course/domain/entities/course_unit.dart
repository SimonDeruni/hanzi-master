import 'package:equatable/equatable.dart';

class CourseUnit extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<CourseNode> nodes;

  const CourseUnit({
    required this.id,
    required this.title,
    required this.description,
    required this.nodes,
  });

  @override
  List<Object?> get props => [id, title, description, nodes];
}

class CourseNode extends Equatable {
  final String uuid;
  final String hanzi;
  final String? parentUuid;

  const CourseNode({
    required this.uuid,
    required this.hanzi,
    this.parentUuid,
  });

  @override
  List<Object?> get props => [uuid, hanzi, parentUuid];
}
