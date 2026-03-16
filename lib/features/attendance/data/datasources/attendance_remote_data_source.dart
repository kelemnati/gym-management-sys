import 'package:dio/dio.dart';
import '../models/attendance_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceModel>> getAttendance();
  Future<void> markAttendance(AttendanceModel attendance);
  Future<List<AttendanceModel>> getAttendanceByClass(String classId);
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final Dio dio;

  AttendanceRemoteDataSourceImpl(this.dio);

  @override
  Future<List<AttendanceModel>> getAttendance() async {
    // Mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      AttendanceModel(
        id: '1',
        memberId: '1',
        classId: '1',
        date: DateTime(2023, 12, 11),
        status: 'present',
      ),
      AttendanceModel(
        id: '2',
        memberId: '2',
        classId: '1',
        date: DateTime(2023, 12, 11),
        status: 'present',
      ),
      AttendanceModel(
        id: '3',
        memberId: '3',
        classId: '2',
        date: DateTime(2023, 12, 12),
        status: 'absent',
      ),
      AttendanceModel(
        id: '4',
        memberId: '4',
        classId: '2',
        date: DateTime(2023, 12, 12),
        status: 'present',
      ),
      AttendanceModel(
        id: '5',
        memberId: '5',
        classId: '3',
        date: DateTime(2023, 12, 13),
        status: 'present',
      ),
    ];
  }

  @override
  Future<void> markAttendance(AttendanceModel attendance) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<List<AttendanceModel>> getAttendanceByClass(String classId) async {
    final allAttendance = await getAttendance();
    return allAttendance.where((a) => a.classId == classId).toList();
  }
}
