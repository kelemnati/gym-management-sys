import '../../domain/entities/attendance.dart';

abstract class AttendanceEvent {}

class LoadAttendance extends AttendanceEvent {}

class MarkAttendanceEvent extends AttendanceEvent {
  final Attendance attendance;

  MarkAttendanceEvent(this.attendance);
}

class LoadAttendanceByClass extends AttendanceEvent {
  final String classId;

  LoadAttendanceByClass(this.classId);
}
