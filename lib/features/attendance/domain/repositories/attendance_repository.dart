import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<List<Attendance>> getAttendance();
  Future<void> markAttendance(Attendance attendance);
  Future<List<Attendance>> getAttendanceByClass(String classId);
}
