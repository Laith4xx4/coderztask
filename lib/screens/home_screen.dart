import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coderz1/bloc/classroom_bloc/classroom_bloc.dart';
import 'package:coderz1/screens/classrooms_screen.dart';
import 'package:coderz1/bloc/student_bloc/student_bloc.dart';
import 'package:coderz1/screens/students_screen.dart';
import 'package:coderz1/bloc/task_assignment_bloc/task_assignment_bloc.dart';
import 'package:coderz1/screens/task/task_assignments_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome! You are logged in.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ClassroomBloc(),
                      child: const ClassroomsScreen(),
                    ),
                  ),
                );
              },
              child: const Text('Manage Classrooms'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => StudentBloc(),
                      child: const StudentsScreen(),
                    ),
                  ),
                );
              },
              child: const Text('Manage Students'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => TaskAssignmentBloc(),
                      child: const TaskAssignmentsScreen(),
                    ),
                  ),
                );
              },
              child: const Text('Manage Task Assignments'),
            ),
          ],
        ),
      ),
    );
  }
}
