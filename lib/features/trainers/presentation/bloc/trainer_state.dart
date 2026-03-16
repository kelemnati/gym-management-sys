import '../../domain/entities/trainer.dart';

abstract class TrainerState {}

class TrainerInitial extends TrainerState {}

class TrainerLoading extends TrainerState {}

class TrainerLoaded extends TrainerState {
  final List<Trainer> trainers;

  TrainerLoaded(this.trainers);
}

class TrainerError extends TrainerState {
  final String message;

  TrainerError(this.message);
}
