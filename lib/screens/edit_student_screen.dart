import 'package:flutter/material.dart';
import 'package:coderz1/bloc/models/student_model.dart';
import 'package:coderz1/bloc/models/classroom_model.dart';
import 'package:coderz1/bloc/services/student_api_service.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  const EditStudentScreen({super.key, required this.student});

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  Classroom? _selectedClassroom;
  List<Classroom> _classrooms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.student.username);
    _fetchClassrooms();
  }

  Future<void> _fetchClassrooms() async {
    try {
      final apiService = StudentApiService();
      final classrooms = await apiService.fetchClassrooms();
      setState(() {
        _classrooms = classrooms;
        _selectedClassroom = classrooms.firstWhere(
          (c) => c.classroomId == widget.student.classroomId,
          orElse: () => classrooms.first, // Fallback if classroom not found
        );
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load classrooms: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateStudent() async {
    if (_formKey.currentState!.validate()) {
      final updatedStudent = widget.student.copyWith(
        username: _usernameController.text,
        classroomId: _selectedClassroom!.classroomId,
      );

      try {
        final apiService = StudentApiService();
        await apiService.updateStudent(updatedStudent);
        if (mounted) {
          Navigator.pop(context, true); // Pop with true to indicate success
        }
      } catch (e) {
        print('Failed to update student: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update student: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Student'),
      content: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<Classroom>(
                    decoration: const InputDecoration(labelText: 'Classroom'),
                    value: _selectedClassroom,
                    onChanged: (Classroom? newValue) {
                      setState(() {
                        _selectedClassroom = newValue;
                      });
                    },
                    items: _classrooms.map<DropdownMenuItem<Classroom>>((
                      Classroom classroom,
                    ) {
                      return DropdownMenuItem<Classroom>(
                        value: classroom,
                        child: Text(classroom.name),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a classroom';
                      }
                      return null;
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
          onPressed: _isLoading ? null : _updateStudent,
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
