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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'nodes': nodes.map((n) => n.toJson()).toList(),
    };
  }

  factory CourseUnit.fromJson(Map<String, dynamic> json) {
    return CourseUnit(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      nodes: (json['nodes'] as List<dynamic>).map((e) => CourseNode.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

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

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'hanzi': hanzi,
      'parentUuid': parentUuid,
    };
  }

  factory CourseNode.fromJson(Map<String, dynamic> json) {
    return CourseNode(
      uuid: json['uuid'] as String,
      hanzi: json['hanzi'] as String,
      parentUuid: json['parentUuid'] as String?,
    );
  }

  @override
  List<Object?> get props => [uuid, hanzi, parentUuid];
}
