import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceUseCase {
  final AttendanceRepository repository;

  GetAttendanceUseCase(this.repository);

  Future<List<Attendance>> call() {
    return repository.getAttendance();
  }
}

class MarkAttendanceUseCase {
  final AttendanceRepository repository;

  MarkAttendanceUseCase(this.repository);

  Future<void> call(Attendance attendance) {
    return repository.markAttendance(attendance);
  }
}

class GetAttendanceByClassUseCase {
  final AttendanceRepository repository;

  GetAttendanceByClassUseCase(this.repository);

  Future<List<Attendance>> call(String classId) {
    return repository.getAttendanceByClass(classId);
  }
}
