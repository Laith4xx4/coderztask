import 'package:coderz1/bloc/models/task_assignment_model.dart';
import 'package:coderz1/bloc/task_assignment_bloc/task_assignment_bloc.dart';
import 'package:coderz1/bloc/task_assignment_bloc/task_assignment_event.dart';
import 'package:coderz1/bloc/task_assignment_bloc/task_assignment_state.dart';
import 'package:coderz1/screens/task/add_task_assignment_screen.dart'; // Import new screen
import 'package:coderz1/screens/task/edit_task_assignment_screen.dart'; // Import new screen
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskAssignmentsScreen extends StatefulWidget {
  const TaskAssignmentsScreen({super.key});

  @override
  State<TaskAssignmentsScreen> createState() => _TaskAssignmentsScreenState();
}

class _TaskAssignmentsScreenState extends State<TaskAssignmentsScreen> {
  // Removed: _titleController, _descriptionController, _selectedTaskAssignment, _selectedStudentId, _students, _apiService, _selectedDueDate, _isCompleted
  // List<Student> _students = []; // Removed - moved to Add/Edit screens
  // final TaskAssignmentApiService _apiService = TaskAssignmentApiService(); // Removed - moved to Add/Edit screens

  @override
  void initState() {
    super.initState();
    context.read<TaskAssignmentBloc>().add(FetchTaskAssignments());
  }

  void _showAddTaskAssignmentDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const AddTaskAssignmentScreen(),
    );
    if (result == true) {
      if (mounted) {
        context.read<TaskAssignmentBloc>().add(FetchTaskAssignments());
      }
    }
  }

  void _showEditTaskAssignmentDialog(TaskAssignment taskAssignment) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          EditTaskAssignmentScreen(taskAssignment: taskAssignment),
    );
    if (result == true) {
      if (mounted) {
        context.read<TaskAssignmentBloc>().add(FetchTaskAssignments());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Assignments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTaskAssignmentDialog,
          ),
        ],
      ),
      body: BlocConsumer<TaskAssignmentBloc, TaskAssignmentState>(
        listener: (context, state) {
          if (state is TaskAssignmentActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is TaskAssignmentActionFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          } else if (state is TaskAssignmentError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is TaskAssignmentLoading && state is! TaskAssignmentsLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskAssignmentsLoaded) {
            return ListView.builder(
              itemCount: state.taskAssignments.length,
              itemBuilder: (context, index) {
                final taskAssignment = state.taskAssignments[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(taskAssignment.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(taskAssignment.description),
                        Text(
                          'Student: ${taskAssignment.student?.username ?? 'N/A'}',
                        ),
                        Text(
                          'Due Date: ${DateFormat('yyyy-MM-dd').format(taskAssignment.dueDate)}',
                        ),
                        Text(
                          'Completed: ${taskAssignment.isCompleted ? 'Yes' : 'No'}',
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showEditTaskAssignmentDialog(taskAssignment),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<TaskAssignmentBloc>().add(
                              DeleteTaskAssignment(
                                taskAssignment.taskAssignmentId,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is TaskAssignmentError) {
            return Center(
              child: Text('Failed to load task assignments: ${state.message}'),
            );
          } else if (state is TaskAssignmentActionFailure) {
            return Center(child: Text('Action failed: ${state.error}'));
          }
          return const Center(child: Text('No task assignments loaded.'));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
