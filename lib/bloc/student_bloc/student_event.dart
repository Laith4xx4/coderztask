import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/student_model.dart';

@immutable
abstract class StudentEvent {}

class FetchStudents extends StudentEvent {}

class AddStudent extends StudentEvent {
  final Student student;

  AddStudent(this.student);
}

class UpdateStudent extends StudentEvent {
  final Student student;

  UpdateStudent(this.student);
}

class DeleteStudent extends StudentEvent {
  final int id;

  DeleteStudent(this.id);
}
