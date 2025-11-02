import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coderz1/bloc/classroom_bloc/classroom_bloc.dart';
import 'package:coderz1/screens/classrooms_screen.dart';
import 'package:coderz1/bloc/student_bloc/student_bloc.dart';
import 'package:coderz1/screens/students_screen.dart';
import 'package:coderz1/bloc/task_assignment_bloc/task_assignment_bloc.dart';
import 'package:coderz1/screens/task/task_assignments_screen.dart';
import 'package:coderz1/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:coderz1/screens/attendance_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => ClassroomBloc(),
      child: const ClassroomsScreen(),
    ),
    BlocProvider(
      create: (context) => StudentBloc(),
      child: const StudentsScreen(),
    ),
    BlocProvider(
      create: (context) => TaskAssignmentBloc(),
      child: const TaskAssignmentsScreen(),
    ),
    BlocProvider(
      create: (context) => AttendanceBloc(),
      child: const AttendanceScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.class_), // Classrooms
            label: 'Classrooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people), // Students
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment), // Task Assignments
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box), // Attendance
            label: 'Attendance',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
