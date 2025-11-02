import 'package:bloc/bloc.dart';
import 'package:coderz1/bloc/task_assignment_bloc/task_assignment_event.dart';
import 'package:coderz1/bloc/task_assignment_bloc/task_assignment_state.dart';
import 'package:coderz1/bloc/services/task_assignment_api_service.dart';
import 'package:coderz1/bloc/models/task_assignment_model.dart';
import 'package:coderz1/bloc/models/student_model.dart';

class TaskAssignmentBloc extends Bloc<TaskAssignmentEvent, TaskAssignmentState> {
  final TaskAssignmentApiService _apiService = TaskAssignmentApiService();

  TaskAssignmentBloc() :
        super(TaskAssignmentInitial()) {on<FetchTaskAssignments>((event, emit) async {
      emit(TaskAssignmentLoading());
      try {
        final taskAssignments = await _apiService.fetchTaskAssignments();
        emit(TaskAssignmentsLoaded(taskAssignments: taskAssignments));
      } catch (e) {
        emit(TaskAssignmentError(message: e.toString()));
      }
    });

    on<AddTaskAssignment>((event, emit) async {
      emit(TaskAssignmentLoading());
      try {
        await _apiService.addTaskAssignment(event.taskAssignment);
        emit(TaskAssignmentActionSuccess(message: 'Task assignment added successfully'));
        add(FetchTaskAssignments());
      } catch (e) {
        emit(TaskAssignmentActionFailure(error: e.toString()));
      }
    });

    on<UpdateTaskAssignment>((event, emit) async {
      emit(TaskAssignmentLoading());
      try {
        await _apiService.updateTaskAssignment(event.taskAssignment);
        emit(TaskAssignmentActionSuccess(message: 'Task assignment updated successfully'));
        add(FetchTaskAssignments()); // Refresh list after updating
      } catch (e) {
        emit(TaskAssignmentActionFailure(error: e.toString()));
      }
    });

    on<DeleteTaskAssignment>((event, emit) async {
      emit(TaskAssignmentLoading());
      try {
        await _apiService.deleteTaskAssignment(event.id);
        emit(TaskAssignmentActionSuccess(message: 'Task assignment deleted successfully'));
        add(FetchTaskAssignments()); // Refresh list after deleting
      } catch (e) {
        emit(TaskAssignmentActionFailure(error: e.toString()));
      }
    });
  }
}
