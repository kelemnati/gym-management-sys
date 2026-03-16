import '../entities/trainer.dart';

abstract class TrainerRepository {
  Future<List<Trainer>> getTrainers();
  Future<void> addTrainer(Trainer trainer);
}
