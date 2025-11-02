import 'package:flutter/foundation.dart';
import 'package:coderz1/bloc/models/task_assignment_model.dart';

@immutable
abstract class TaskAssignmentState {}

class TaskAssignmentInitial extends TaskAssignmentState {}

class TaskAssignmentLoading extends TaskAssignmentState {}

class TaskAssignmentsLoaded extends TaskAssignmentState {
  final List<TaskAssignment> taskAssignments;

  TaskAssignmentsLoaded({required this.taskAssignments});
}

class TaskAssignmentError extends TaskAssignmentState {
  final String message;

  TaskAssignmentError({required this.message});
}

class TaskAssignmentActionSuccess extends TaskAssignmentState {
  final String message;

  TaskAssignmentActionSuccess({required this.message});
}

class TaskAssignmentActionFailure extends TaskAssignmentState {
  final String error;

  TaskAssignmentActionFailure({required this.error});
}
