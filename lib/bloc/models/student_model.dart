import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/classroom_model.dart';

@immutable
class Student {
  final int studentId;
  final String username;
  final int classroomId;
  final Classroom? classroom;

  const Student({
    required this.studentId,
    required this.username,
    required this.classroomId,
    this.classroom,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'],
      username: json['username'],
      classroomId: json['classroomId'],
      classroom: json['classroom'] != null
          ? Classroom.fromJson(json['classroom'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'username': username,
      'classroomId': classroomId,
      // 'classroom': classroom?.toJson(), // We might not need to send the whole classroom object when posting/putting
    };
  }

  Student copyWith({
    int? studentId,
    String? username,
    int? classroomId,
    Classroom? classroom,
  }) {
    return Student(
      studentId: studentId ?? this.studentId,
      username: username ?? this.username,
      classroomId: classroomId ?? this.classroomId,
      classroom: classroom ?? this.classroom,
    );
  }
}
