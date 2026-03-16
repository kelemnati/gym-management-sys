import '../../domain/entities/trainer.dart';

abstract class TrainerEvent {}

class LoadTrainers extends TrainerEvent {}

class AddTrainerEvent extends TrainerEvent {
  final Trainer trainer;

  AddTrainerEvent(this.trainer);
}
