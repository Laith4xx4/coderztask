import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coderz1/bloc/auth/auth_bloc.dart';
import 'package:coderz1/screens/login_screen.dart';
import 'package:coderz1/bloc/classroom_bloc/classroom_bloc.dart';
import 'package:coderz1/bloc/student_bloc/student_bloc.dart';
import 'package:coderz1/bloc/task_assignment_bloc/task_assignment_bloc.dart';
import 'package:coderz1/bloc/attendance_bloc/attendance_bloc.dart';

import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<ClassroomBloc>(create: (context) => ClassroomBloc()),
        BlocProvider<StudentBloc>(create: (context) => StudentBloc()),
        BlocProvider<TaskAssignmentBloc>(
          create: (context) => TaskAssignmentBloc(),
        ),
        BlocProvider<AttendanceBloc>(create: (context) => AttendanceBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Auth Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
        // home: const  DashboardScreen(),
      ),
    );
  }
}
//laithyassen1212@gmail.com---------->test
//123456------------------->test password
//BlocConsumer
//listener
//builder
//trailing
//mainAxisSize: MainAxisSize.min,
//picked
//showDatePicker
//validator
// DropdownButtonFormField
//