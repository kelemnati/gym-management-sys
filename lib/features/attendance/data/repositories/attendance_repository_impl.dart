import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_data_source.dart';
import '../models/attendance_model.dart';
import '../../../../core/network/network_info.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AttendanceRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<List<Attendance>> getAttendance() async {
    if (await networkInfo.isConnected) {
      final attendance = await remoteDataSource.getAttendance();
      return attendance;
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> markAttendance(Attendance attendance) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.markAttendance(AttendanceModel(
        id: attendance.id,
        memberId: attendance.memberId,
        classId: attendance.classId,
        date: attendance.date,
        status: attendance.status,
      ));
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<Attendance>> getAttendanceByClass(String classId) async {
    if (await networkInfo.isConnected) {
      final attendance = await remoteDataSource.getAttendanceByClass(classId);
      return attendance;
    } else {
      throw Exception('No internet connection');
    }
  }
}
