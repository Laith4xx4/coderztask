import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/student_model.dart';

@immutable
abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentsLoaded extends StudentState {
  final List<Student> students;

  StudentsLoaded({required this.students});
}

class StudentError extends StudentState {
  final String message;

  StudentError({required this.message});
}

class StudentActionSuccess extends StudentState {
  final String message;

  StudentActionSuccess({required this.message});
}

class StudentActionFailure extends StudentState {
  final String error;

  StudentActionFailure({required this.error});
}
