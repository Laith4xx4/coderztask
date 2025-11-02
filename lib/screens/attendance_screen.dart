import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coderz1/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:coderz1/bloc/attendance_bloc/attendance_event.dart';
import 'package:coderz1/bloc/attendance_bloc/attendance_state.dart';
import 'package:coderz1/bloc/models/attendance_model.dart';
import 'package:coderz1/bloc/models/student_model.dart';
import 'package:coderz1/bloc/services/attendance_api_service.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Attendance? _selectedAttendance;
  int? _selectedStudentId;
  List<Student> _students = [];
  final AttendanceApiService _apiService = AttendanceApiService();
  DateTime _selectedDate = DateTime.now();
  bool _isPresent = false;

  @override
  void initState() {
    super.initState();
    _fetchStudents();
    context.read<AttendanceBloc>().add(FetchAttendance());
  }

  Future<void> _fetchStudents() async {
    try {
      _students = await _apiService.fetchStudents();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load students: $e')));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showAttendanceDialog({Attendance? attendance}) {
    _selectedAttendance = attendance;
    if (attendance != null) {
      _selectedStudentId = attendance.studentId;
      _selectedDate = attendance.date;
      _isPresent = attendance.isPresent;
    } else {
      _selectedStudentId = null;
      _selectedDate = DateTime.now();
      _isPresent = false;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              attendance == null ? 'Add Attendance' : 'Edit Attendance',
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  ),
                  ListTile(
                    title: Text(
                      "Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  CheckboxListTile(
                    title: const Text('Is Present'),
                    value: _isPresent,
                    onChanged: (bool? value) {
                      setState(() {
                        _isPresent = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final studentId = _selectedStudentId;

                  if (studentId != null) {
                    if (_selectedAttendance == null) {
                      context.read<AttendanceBloc>().add(
                        AddAttendance(
                          Attendance(
                            attendanceId: 0,
                            studentId: studentId,
                            date: _selectedDate,
                            isPresent: _isPresent,
                          ),
                        ),
                      );
                    } else {
                      context.read<AttendanceBloc>().add(
                        UpdateAttendance(
                          _selectedAttendance!.copyWith(
                            studentId: studentId,
                            date: _selectedDate,
                            isPresent: _isPresent,
                          ),
                        ),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(attendance == null ? 'Add' : 'Save'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAttendanceDialog(),
          ),
        ],
      ),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AttendanceActionFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          } else if (state is AttendanceError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is AttendanceLoading && state is! AttendanceLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceLoaded) {
            return ListView.builder(
              itemCount: state.attendanceRecords.length,
              itemBuilder: (context, index) {
                final attendance = state.attendanceRecords[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      DateFormat('yyyy-MM-dd').format(attendance.date),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status: ${attendance.isPresent ? 'Present' : 'Absent'}',
                        ),
                        Text(
                          'Student: ${attendance.student?.username ?? 'N/A'}',
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showAttendanceDialog(attendance: attendance),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<AttendanceBloc>().add(
                              DeleteAttendance(attendance.attendanceId),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is AttendanceError) {
            return Center(
              child: Text(
                'Failed to load attendance records: ${state.message}',
              ),
            );
          } else if (state is AttendanceActionFailure) {
            return Center(child: Text('Action failed: ${state.error}'));
          }
          return const Center(child: Text('No attendance records loaded.'));
        },
      ),
    );
  }
}
