import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coderz1/bloc/models/student_model.dart';
import 'package:coderz1/bloc/models/classroom_model.dart';

class StudentApiService {
  final String _baseUrl = 'http://192.168.100.66:5086/api/Students';
  final String _classroomBaseUrl = 'http://192.168.100.66:5086/api/Classrooms';

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Student>.from(l.map((model) => Student.fromJson(model)));
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<Student> addStudent(Student student) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode == 201) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add student');
    }
  }

  Future<void> updateStudent(Student student) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${student.studentId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update student');
    }
  }

  Future<void> deleteStudent(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete student');
    }
  }

  Future<List<Classroom>> fetchClassrooms() async {
    final response = await http.get(Uri.parse(_classroomBaseUrl));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Classroom>.from(l.map((model) => Classroom.fromJson(model)));
    } else {
      throw Exception('Failed to load classrooms for dropdown');
    }
  }
}
