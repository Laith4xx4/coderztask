import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/classroom_model.dart';

@immutable
abstract class ClassroomState {}

class ClassroomInitial extends ClassroomState {}

class ClassroomLoading extends ClassroomState {}

class ClassroomsLoaded extends ClassroomState {
  final List<Classroom> classrooms;

  ClassroomsLoaded({required this.classrooms});
}

class ClassroomError extends ClassroomState {
  final String message;

  ClassroomError({required this.message});
}

class ClassroomActionSuccess extends ClassroomState {
  final String message;

  ClassroomActionSuccess({required this.message});
}

class ClassroomActionFailure extends ClassroomState {
  final String error;

  ClassroomActionFailure({required this.error});
}
