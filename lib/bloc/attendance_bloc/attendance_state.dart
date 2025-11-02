import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/attendance_model.dart';

@immutable
abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<Attendance> attendanceRecords;

  AttendanceLoaded({required this.attendanceRecords});
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError({required this.message});
}

class AttendanceActionSuccess extends AttendanceState {
  final String message;

  AttendanceActionSuccess({required this.message});
}

class AttendanceActionFailure extends AttendanceState {
  final String error;

  AttendanceActionFailure({required this.error});
}
