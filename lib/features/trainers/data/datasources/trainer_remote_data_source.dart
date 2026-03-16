import 'package:dio/dio.dart';
import '../models/trainer_model.dart';

abstract class TrainerRemoteDataSource {
  Future<List<TrainerModel>> getTrainers();
  Future<void> addTrainer(TrainerModel trainer);
}

class TrainerRemoteDataSourceImpl implements TrainerRemoteDataSource {
  final Dio dio;

  TrainerRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TrainerModel>> getTrainers() async {
    // Mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      TrainerModel(
        id: '1',
        name: 'Sarah Johnson',
        specialization: 'Yoga & Pilates',
      ),
      TrainerModel(
        id: '2',
        name: 'Mike Chen',
        specialization: 'HIIT & Cardio',
      ),
      TrainerModel(
        id: '3',
        name: 'Emma Davis',
        specialization: 'Strength Training',
      ),
      TrainerModel(
        id: '4',
        name: 'David Wilson',
        specialization: 'CrossFit',
      ),
      TrainerModel(
        id: '5',
        name: 'Lisa Brown',
        specialization: 'Dance Fitness',
      ),
    ];
  }

  @override
  Future<void> addTrainer(TrainerModel trainer) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
