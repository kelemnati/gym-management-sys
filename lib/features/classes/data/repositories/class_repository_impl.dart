import '../../domain/entities/gym_class.dart';
import '../../domain/repositories/class_repository.dart';
import '../datasources/class_remote_data_source.dart';
import '../models/gym_class_model.dart';
import '../../../../core/network/network_info.dart';

class ClassRepositoryImpl implements ClassRepository {
  final ClassRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ClassRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<List<GymClass>> getClasses() async {
    if (await networkInfo.isConnected) {
      final classes = await remoteDataSource.getClasses();
      return classes;
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> addClass(GymClass gymClass) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.addClass(GymClassModel(
        id: gymClass.id,
        name: gymClass.name,
        instructor: gymClass.instructor,
        dateTime: gymClass.dateTime,
        capacity: gymClass.capacity,
        enrolled: gymClass.enrolled,
      ));
    } else {
      throw Exception('No internet connection');
    }
  }
}
