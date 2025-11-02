import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coderz1/bloc/student_bloc/student_bloc.dart';
import 'package:coderz1/bloc/student_bloc/student_event.dart';
import 'package:coderz1/bloc/student_bloc/student_state.dart';
import 'package:coderz1/bloc/models/student_model.dart';
import 'package:coderz1/screens/add_student_screen.dart'; // Import the new screen
import 'package:coderz1/screens/edit_student_screen.dart'; // Import the new screen

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  // final TextEditingController _nameController = TextEditingController(); // Removed
  // final TextEditingController _ageController = TextEditingController(); // Removed
  // Student? _selectedStudent; // Removed
  // int? _selectedClassroomId; // Removed
  // List<Classroom> _classrooms = []; // Removed
  // final StudentApiService _apiService = StudentApiService(); // Removed

  @override
  void initState() {
    super.initState();
    // _fetchClassrooms(); // Removed
    context.read<StudentBloc>().add(FetchStudents());
  }

  // Future<void> _fetchClassrooms() async { // Removed
  //   try {
  //     _classrooms = await _apiService.fetchClassrooms();
  //     setState(() {});
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to load classrooms: $e')),
  //     );
  //   }
  // } // Removed

  void _showAddStudentDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const AddStudentScreen(),
    );
    if (result == true) {
      // If a student was successfully added, refresh the list
      if (mounted) {
        context.read<StudentBloc>().add(FetchStudents());
      }
    }
  }

  void _showEditStudentDialog(Student student) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => EditStudentScreen(student: student),
    );
    if (result == true) {
      // If a student was successfully updated, refresh the list
      if (mounted) {
        context.read<StudentBloc>().add(FetchStudents());
      }
    }
  }

  // void _showStudentDialog({Student? student}) { // Removed
  //   _selectedStudent = student;
  //   if (student != null) {
  //     _nameController.text = student.name;
  //     _ageController.text = student.age.toString();
  //     _selectedClassroomId = student.classroomId;
  //   } else {
  //     _nameController.clear();
  //     _ageController.clear();
  //     _selectedClassroomId = null;
  //   }
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text(student == null ? 'Add Student' : 'Edit Student'),
  //       content: SingleChildScrollView(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: _nameController,
  //               decoration: const InputDecoration(labelText: 'Student Name'),
  //             ),
  //             TextField(
  //               controller: _ageController,
  //               keyboardType: TextInputType.number,
  //               decoration: const InputDecoration(labelText: 'Age'),
  //             ),
  //             DropdownButtonFormField<int?>(
  //               value: _selectedClassroomId,
  //               decoration: const InputDecoration(labelText: 'Classroom'),
  //               items: _classrooms.map((classroom) {
  //                 return DropdownMenuItem<int?>(
  //                   value: classroom.classroomId,
  //                   child: Text(classroom.name),
  //                 );
  //               }).toList(),
  //               onChanged: (value) {
  //                 setState(() {
  //                   _selectedClassroomId = value;
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             final name = _nameController.text;
  //             final age = int.tryParse(_ageController.text);
  //             final classroomId = _selectedClassroomId;
  //
  //             if (name.isNotEmpty && age != null && classroomId != null) {
  //               if (_selectedStudent == null) {
  //                 context.read<StudentBloc>().add(AddStudent(Student(
  //                       studentId: 0,
  //                       name: name,
  //                       age: age,
  //                       classroomId: classroomId,
  //                     )));
  //               } else {
  //                 context.read<StudentBloc>().add(UpdateStudent(_selectedStudent!.copyWith(
  //                       name: name,
  //                       age: age,
  //                       classroomId: classroomId,
  //                     )));
  //               }
  //               Navigator.pop(context);
  //             }
  //           },
  //           child: Text(student == null ? 'Add' : 'Save'),
  //         ),
  //       ],
  //     ),
  //   );
  // } // Removed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddStudentDialog,
          ),
        ],
      ),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is StudentActionFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          } else if (state is StudentError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is StudentLoading && state is! StudentsLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentsLoaded) {
            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(student.username),
                    subtitle: Text(
                      'Classroom: ${student.classroom?.name ?? 'N/A'}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditStudentDialog(student);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<StudentBloc>().add(
                              DeleteStudent(student.studentId),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is StudentError) {
            return Center(
              child: Text('Failed to load students: ${state.message}'),
            );
          } else if (state is StudentActionFailure) {
            return Center(child: Text('Action failed: ${state.error}'));
          }
          return const Center(child: Text('No students loaded.'));
        },
      ),
    );
  }

  @override
  void dispose() {
    // _nameController.dispose(); // Removed
    // _ageController.dispose(); // Removed
    super.dispose();
  }
}
