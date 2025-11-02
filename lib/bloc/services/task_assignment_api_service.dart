import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coderz1/bloc/models/task_assignment_model.dart';
import 'package:coderz1/bloc/models/student_model.dart';

class TaskAssignmentApiService {
  final String _baseUrl = 'http://192.168.100.66:5086/api/TaskAssignments';
  final String _studentBaseUrl = 'http://192.168.100.66:5086/api/Students';

  Future<List<TaskAssignment>> fetchTaskAssignments() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<TaskAssignment>.from(
        l.map((model) => TaskAssignment.fromJson(model)),
      );
    } else {
      throw Exception('Failed to load task assignments');
    }
  }

  Future<TaskAssignment> addTaskAssignment(TaskAssignment taskAssignment,) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(taskAssignment.toJson()),
    );

    if (response.statusCode == 201) {
      return TaskAssignment.fromJson(json.decode(response.body));
    } else {
      print(
        'Failed to add task assignment. Status code: ${response.statusCode}',
      );
      print('Response body: ${response.body}');
      throw Exception('Failed to add task assignment');
    }
  }

  Future<void> updateTaskAssignment(TaskAssignment taskAssignment) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${taskAssignment.taskAssignmentId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(taskAssignment.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update task assignment');
    }
  }

  Future<void> deleteTaskAssignment(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete task assignment');
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
