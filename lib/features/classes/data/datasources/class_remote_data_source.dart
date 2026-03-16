import 'package:dio/dio.dart';
import '../models/gym_class_model.dart';

abstract class ClassRemoteDataSource {
  Future<List<GymClassModel>> getClasses();
  Future<void> addClass(GymClassModel gymClass);
}

class ClassRemoteDataSourceImpl implements ClassRemoteDataSource {
  final Dio dio;

  ClassRemoteDataSourceImpl(this.dio);

  @override
  Future<List<GymClassModel>> getClasses() async {
    // Mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      GymClassModel(
        id: '1',
        name: 'Yoga',
        instructor: 'Sarah Johnson',
        dateTime: DateTime(2023, 12, 18, 9, 0),
        capacity: 20,
        enrolled: 15,
      ),
      GymClassModel(
        id: '2',
        name: 'HIIT',
        instructor: 'Mike Chen',
        dateTime: DateTime(2023, 12, 19, 18, 0),
        capacity: 15,
        enrolled: 12,
      ),
      GymClassModel(
        id: '3',
        name: 'Pilates',
        instructor: 'Emma Davis',
        dateTime: DateTime(2023, 12, 20, 19, 0),
        capacity: 12,
        enrolled: 10,
      ),
      GymClassModel(
        id: '4',
        name: 'Strength Training',
        instructor: 'David Wilson',
        dateTime: DateTime(2023, 12, 21, 17, 0),
        capacity: 10,
        enrolled: 8,
      ),
      GymClassModel(
        id: '5',
        name: 'Cardio Dance',
        instructor: 'Lisa Brown',
        dateTime: DateTime(2023, 12, 22, 10, 0),
        capacity: 25,
        enrolled: 20,
      ),
    ];
  }

  @override
  Future<void> addClass(GymClassModel gymClass) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
