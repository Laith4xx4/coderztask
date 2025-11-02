import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/student_model.dart';

@immutable
class Attendance {
  final int attendanceId;
  final int studentId;
  final Student? student;
  final DateTime date;
  final bool isPresent;

  const Attendance({
    required this.attendanceId,
    required this.studentId,
    this.student,
    required this.date,
    required this.isPresent,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendanceId: json['attendanceId'],
      studentId: json['studentId'],
      student: json['student'] != null
          ? Student.fromJson(json['student'])
          : null,
      date: DateTime.parse(json['date']),
      isPresent: json['isPresent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendanceId': attendanceId,
      'studentId': studentId,
      // 'student': student?.toJson(), // We might not need to send the whole student object when posting/putting
      'date': date.toIso8601String(),
      'isPresent': isPresent,
    };
  }

  Attendance copyWith({
    int? attendanceId,
    int? studentId,
    Student? student,
    DateTime? date,
    bool? isPresent,
  }) {
    return Attendance(
      attendanceId: attendanceId ?? this.attendanceId,
      studentId: studentId ?? this.studentId,
      student: student ?? this.student,
      date: date ?? this.date,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
