import 'package:bloc/bloc.dart';
import 'package:coderz1/bloc/classroom_bloc/classroom_event.dart';
import 'package:coderz1/bloc/classroom_bloc/classroom_state.dart';
import 'package:coderz1/bloc/services/classroom_api_service.dart';
import 'package:coderz1/bloc/models/classroom_model.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  final ClassroomApiService _apiService = ClassroomApiService();

  ClassroomBloc() : super(ClassroomInitial()) {
    on<FetchClassrooms>((event, emit) async {
      emit(ClassroomLoading());
      try {
        final classrooms = await _apiService.fetchClassrooms();
        emit(ClassroomsLoaded(classrooms: classrooms));
      } catch (e) {
        emit(ClassroomError(message: e.toString()));
      }
    });

    on<AddClassroom>((event, emit) async {
      emit(ClassroomLoading());
      try {
        await _apiService.addClassroom(event.classroom);
        emit(ClassroomActionSuccess(message: 'Classroom added successfully'));
        add(FetchClassrooms()); // Refresh list after adding
      } catch (e) {
        emit(ClassroomActionFailure(error: e.toString()));
      }
    });

    on<UpdateClassroom>((event, emit) async {
      emit(ClassroomLoading());
      try {
        await _apiService.updateClassroom(event.classroom);
        emit(ClassroomActionSuccess(message: 'Classroom updated successfully'));
        add(FetchClassrooms()); // Refresh list after updating
      } catch (e) {
        emit(ClassroomActionFailure(error: e.toString()));
      }
    });

    on<DeleteClassroom>((event, emit) async {
      emit(ClassroomLoading());
      try {
        await _apiService.deleteClassroom(event.id);
        emit(ClassroomActionSuccess(message: 'Classroom deleted successfully'));
        add(FetchClassrooms()); // Refresh list after deleting
      } catch (e) {
        emit(ClassroomActionFailure(error: e.toString()));
      }
    });
  }
}
