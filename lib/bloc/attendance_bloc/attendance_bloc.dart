import 'package:bloc/bloc.dart';
import 'package:coderz1/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:coderz1/bloc/attendance_bloc/attendance_event.dart';
import 'package:coderz1/bloc/attendance_bloc/attendance_state.dart';
import 'package:coderz1/bloc/services/attendance_api_service.dart';
import 'package:coderz1/bloc/models/attendance_model.dart';
import 'package:coderz1/bloc/models/student_model.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceApiService _apiService = AttendanceApiService();

  AttendanceBloc() : super(AttendanceInitial()) {
    on<FetchAttendance>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final attendanceRecords = await _apiService.fetchAttendance();
        emit(AttendanceLoaded(attendanceRecords: attendanceRecords));
      } catch (e) {
        emit(AttendanceError(message: e.toString()));
      }
    });

    on<AddAttendance>((event, emit) async {
      emit(AttendanceLoading());
      try {
        await _apiService.addAttendance(event.attendance);
        emit(AttendanceActionSuccess(message: 'Attendance record added successfully'));
        add(FetchAttendance()); // Refresh list after adding
      } catch (e) {
        emit(AttendanceActionFailure(error: e.toString()));
      }
    });

    on<UpdateAttendance>((event, emit) async {
      emit(AttendanceLoading());
      try {
        await _apiService.updateAttendance(event.attendance);
        emit(AttendanceActionSuccess(message: 'Attendance record updated successfully'));
        add(FetchAttendance()); // Refresh list after updating
      } catch (e) {
        emit(AttendanceActionFailure(error: e.toString()));
      }
    });

    on<DeleteAttendance>((event, emit) async {
      emit(AttendanceLoading());
      try {
        await _apiService.deleteAttendance(event.id);
        emit(AttendanceActionSuccess(message: 'Attendance record deleted successfully'));
        add(FetchAttendance()); // Refresh list after deleting
      } catch (e) {
        emit(AttendanceActionFailure(error: e.toString()));
      }
    });
  }
}
