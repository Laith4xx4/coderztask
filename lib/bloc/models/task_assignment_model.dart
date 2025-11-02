import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/student_model.dart';

@immutable
class TaskAssignment {
  final int taskAssignmentId;
  final int studentId;
  final Student? student;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  const TaskAssignment({
    required this.taskAssignmentId,
    required this.studentId,
    this.student,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
  });

  factory TaskAssignment.fromJson(Map<String, dynamic> json) {
    return TaskAssignment(
      taskAssignmentId: json['taskAssignmentId'],
      studentId: json['studentId'],
      student: json['student'] != null
          ? Student.fromJson(json['student'])
          : null,
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskAssignmentId': taskAssignmentId,
      'studentId': studentId,
      // 'student': student?.toJson(), // We might not need to send the whole student object when posting/putting
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  TaskAssignment copyWith({
    int? taskAssignmentId,
    int? studentId,
    Student? student,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return TaskAssignment(
      taskAssignmentId: taskAssignmentId ?? this.taskAssignmentId,
      studentId: studentId ?? this.studentId,
      student: student ?? this.student,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
