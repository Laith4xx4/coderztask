import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coderz1/bloc/models/classroom_model.dart';

class ClassroomApiService {
  final String _baseUrl = 'http://192.168.100.66:5086/api/Classrooms';

  Future<List<Classroom>> fetchClassrooms() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Classroom>.from(l.map((model) => Classroom.fromJson(model)));
    } else {
      throw Exception('Failed to load classrooms');
    }
  }

  Future<Classroom> addClassroom(Classroom classroom) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(classroom.toJson()),
    );

    if (response.statusCode == 201) {
      return Classroom.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add classroom');
    }
  }

  Future<void> updateClassroom(Classroom classroom) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${classroom.classroomId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(classroom.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update classroom');
    }
  }

  Future<void> deleteClassroom(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete classroom');
    }
  }
}
