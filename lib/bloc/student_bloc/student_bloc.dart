import 'package:bloc/bloc.dart';
import 'package:coderz1/bloc/student_bloc/student_event.dart';
import 'package:coderz1/bloc/student_bloc/student_state.dart';
import 'package:coderz1/bloc/services/student_api_service.dart';
import 'package:coderz1/bloc/models/student_model.dart';
import 'package:coderz1/bloc/models/classroom_model.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentApiService _apiService = StudentApiService();

  StudentBloc() : super(StudentInitial()) {
    on<FetchStudents>((event, emit) async {
      emit(StudentLoading());
      try {
        final students = await _apiService.fetchStudents();
        emit(StudentsLoaded(students: students));
      } catch (e) {
        emit(StudentError(message: e.toString()));
      }
    });

    on<AddStudent>((event, emit) async {
      emit(StudentLoading());
      try {
        await _apiService.addStudent(event.student);
        emit(StudentActionSuccess(message: 'Student added successfully'));
        add(FetchStudents()); // Refresh list after adding
      } catch (e) {
        emit(StudentActionFailure(error: e.toString()));
      }
    });

    on<UpdateStudent>((event, emit) async {
      emit(StudentLoading());
      try {
        await _apiService.updateStudent(event.student);
        emit(StudentActionSuccess(message: 'Student updated successfully'));
        add(FetchStudents()); // Refresh list after updating
      } catch (e) {
        emit(StudentActionFailure(error: e.toString()));
      }
    });

    on<DeleteStudent>((event, emit) async {
      emit(StudentLoading());
      try {
        await _apiService.deleteStudent(event.id);
        emit(StudentActionSuccess(message: 'Student deleted successfully'));
        add(FetchStudents()); // Refresh list after deleting
      } catch (e) {
        emit(StudentActionFailure(error: e.toString()));
      }
    });
  }
}
