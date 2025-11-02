import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/attendance_model.dart';

@immutable
abstract class AttendanceEvent {}

class FetchAttendance extends AttendanceEvent {}

class AddAttendance extends AttendanceEvent {
  final Attendance attendance;

  AddAttendance(this.attendance);
}

class UpdateAttendance extends AttendanceEvent {
  final Attendance attendance;

  UpdateAttendance(this.attendance);
}

class DeleteAttendance extends AttendanceEvent {
  final int id;

  DeleteAttendance(this.id);
}
