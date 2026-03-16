import '../../domain/entities/trainer.dart';
import '../../domain/repositories/trainer_repository.dart';
import '../datasources/trainer_remote_data_source.dart';
import '../models/trainer_model.dart';
import '../../../../core/network/network_info.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final TrainerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TrainerRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<List<Trainer>> getTrainers() async {
    if (await networkInfo.isConnected) {
      final trainers = await remoteDataSource.getTrainers();
      return trainers;
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> addTrainer(Trainer trainer) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.addTrainer(TrainerModel(
        id: trainer.id,
        name: trainer.name,
        specialization: trainer.specialization,
      ));
    } else {
      throw Exception('No internet connection');
    }
  }
}
