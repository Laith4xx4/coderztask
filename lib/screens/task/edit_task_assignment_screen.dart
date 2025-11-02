import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:coderz1/bloc/models/task_assignment_model.dart';
import 'package:coderz1/bloc/models/student_model.dart';
import 'package:coderz1/bloc/services/task_assignment_api_service.dart';

class EditTaskAssignmentScreen extends StatefulWidget {
  final TaskAssignment taskAssignment;

  const EditTaskAssignmentScreen({super.key, required this.taskAssignment});

  @override
  State<EditTaskAssignmentScreen> createState() =>
      _EditTaskAssignmentScreenState();
}

class _EditTaskAssignmentScreenState extends State<EditTaskAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  int? _selectedStudentId;
  List<Student> _students = [];
  late DateTime _selectedDueDate;
  late bool _isCompleted;
  bool _isLoading = true;
  final TaskAssignmentApiService _apiService = TaskAssignmentApiService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.taskAssignment.title);
    _descriptionController = TextEditingController(
      text: widget.taskAssignment.description,
    );
    _selectedStudentId = widget.taskAssignment.studentId;
    _selectedDueDate = widget.taskAssignment.dueDate;
    _isCompleted = widget.taskAssignment.isCompleted;
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    try {
      final students = await _apiService.fetchStudents();
      setState(() {
        _students = students;
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load students: $e');
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load students: $e')));
      }
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  Future<void> _updateTaskAssignment() async {
    if (_formKey.currentState!.validate()) {
      final updatedAssignment = widget.taskAssignment.copyWith(
        studentId: _selectedStudentId!,
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _selectedDueDate,
        isCompleted: _isCompleted,
      );

      try {
        await _apiService.updateTaskAssignment(updatedAssignment);
        if (mounted) {
          Navigator.pop(context, true); // Pop with true to indicate success
        }
      } catch (e) {
        print('Failed to update task assignment: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update task assignment: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Task Assignment'),
      content: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<int?>(
                    value: _selectedStudentId,
                    decoration: const InputDecoration(labelText: 'Student'),
                    items: _students.map((student) {
                      return DropdownMenuItem<int?>(
                        value: student.studentId,
                        child: Text(student.username),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedStudentId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a student';
                      }
                      return null;
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Due Date: ${DateFormat('yyyy-MM-dd').format(_selectedDueDate)}",
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDueDate(context),
                  ),
                  CheckboxListTile(
                    title: const Text('Is Completed'),
                    value: _isCompleted,
                    onChanged: (bool? value) {
                      setState(() {
                        _isCompleted = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Dismiss the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _updateTaskAssignment,
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
