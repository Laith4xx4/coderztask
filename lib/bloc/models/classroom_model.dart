import 'package:flutter/foundation.dart';

@immutable
class Classroom {
  final int classroomId;
  final String name;
  // For simplicity, we are not including the 'Students' navigation property in Flutter model
  // as it would require defining a Student model as well and might overcomplicate the current task.

  const Classroom({required this.classroomId, required this.name});

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(classroomId: json['classroomId'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'classroomId': classroomId, 'name': name};
  }

  Classroom copyWith({int? classroomId, String? name}) {
    return Classroom(
      classroomId: classroomId ?? this.classroomId,
      name: name ?? this.name,
    );
  }
}
