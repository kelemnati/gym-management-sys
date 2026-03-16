import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/attendance_usecases.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetAttendanceUseCase getAttendanceUseCase;
  final MarkAttendanceUseCase markAttendanceUseCase;
  final GetAttendanceByClassUseCase getAttendanceByClassUseCase;

  AttendanceBloc(this.getAttendanceUseCase, this.markAttendanceUseCase,
      this.getAttendanceByClassUseCase)
      : super(AttendanceInitial()) {
    on<LoadAttendance>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final attendance = await getAttendanceUseCase();
        emit(AttendanceLoaded(attendance));
      } catch (e) {
        emit(AttendanceError(e.toString()));
      }
    });
    on<MarkAttendanceEvent>((event, emit) async {
      emit(AttendanceLoading());
      try {
        await markAttendanceUseCase(event.attendance);
        final attendance = await getAttendanceUseCase();
        emit(AttendanceLoaded(attendance));
      } catch (e) {
        emit(AttendanceError(e.toString()));
      }
    });
    on<LoadAttendanceByClass>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final attendance = await getAttendanceByClassUseCase(event.classId);
        emit(AttendanceLoaded(attendance));
      } catch (e) {
        emit(AttendanceError(e.toString()));
      }
    });
  }
}
