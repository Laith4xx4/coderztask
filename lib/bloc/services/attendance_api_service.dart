import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coderz1/bloc/models/attendance_model.dart';
import 'package:coderz1/bloc/models/student_model.dart';

class AttendanceApiService {
  final String _baseUrl = 'http://192.168.100.66:5086/api/Attendances';
  final String _studentBaseUrl = 'http://192.168.100.66:5086/api/Students';

  Future<List<Attendance>> fetchAttendance() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Attendance>.from(
        l.map((model) => Attendance.fromJson(model)),
      );
    } else {
      print(
        'Failed to load attendance records. Status code: ${response.statusCode}',
      );
      print('Response body: ${response.body}');
      throw Exception('Failed to load attendance records');
    }
  }

  Future<Attendance> addAttendance(Attendance attendance) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(attendance.toJson()),
    );

    if (response.statusCode == 201) {
      return Attendance.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add attendance record');
    }
  }

  Future<void> updateAttendance(Attendance attendance) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${attendance.attendanceId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(attendance.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update attendance record');
    }
  }

  Future<void> deleteAttendance(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete attendance record');
    }
  }

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse(_studentBaseUrl));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Student>.from(l.map((model) => Student.fromJson(model)));
    } else {
      throw Exception('Failed to load students for dropdown');
    }
  }
}
