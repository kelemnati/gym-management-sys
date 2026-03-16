import '../entities/trainer.dart';
import '../repositories/trainer_repository.dart';

class GetTrainersUseCase {
  final TrainerRepository repository;

  GetTrainersUseCase(this.repository);

  Future<List<Trainer>> call() {
    return repository.getTrainers();
  }
}

class AddTrainerUseCase {
  final TrainerRepository repository;

  AddTrainerUseCase(this.repository);

  Future<void> call(Trainer trainer) {
    return repository.addTrainer(trainer);
  }
}
