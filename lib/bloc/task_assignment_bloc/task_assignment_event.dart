import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/task_assignment_model.dart';

@immutable
abstract class TaskAssignmentEvent {}

class FetchTaskAssignments extends TaskAssignmentEvent {}

class AddTaskAssignment extends TaskAssignmentEvent {
  final TaskAssignment taskAssignment;

  AddTaskAssignment(this.taskAssignment);
}

class UpdateTaskAssignment extends TaskAssignmentEvent {
  final TaskAssignment taskAssignment;

  UpdateTaskAssignment(this.taskAssignment);
}

class DeleteTaskAssignment extends TaskAssignmentEvent {
  final int id;

  DeleteTaskAssignment(this.id);
}
