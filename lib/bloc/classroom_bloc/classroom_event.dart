import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/classroom_model.dart';

@immutable
abstract class ClassroomEvent {}

class FetchClassrooms extends ClassroomEvent {}

class AddClassroom extends ClassroomEvent {
  final Classroom classroom;

  AddClassroom(this.classroom);
}

class UpdateClassroom extends ClassroomEvent {
  final Classroom classroom;

  UpdateClassroom(this.classroom);
}

class DeleteClassroom extends ClassroomEvent {
  final int id;

  DeleteClassroom(this.id);
}
