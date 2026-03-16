import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/trainer_usecases.dart';
import 'trainer_event.dart';
import 'trainer_state.dart';

class TrainerBloc extends Bloc<TrainerEvent, TrainerState> {
  final GetTrainersUseCase getTrainersUseCase;
  final AddTrainerUseCase addTrainerUseCase;

  TrainerBloc(this.getTrainersUseCase, this.addTrainerUseCase)
      : super(TrainerInitial()) {
    on<LoadTrainers>((event, emit) async {
      emit(TrainerLoading());
      try {
        final trainers = await getTrainersUseCase();
        emit(TrainerLoaded(trainers));
      } catch (e) {
        emit(TrainerError(e.toString()));
      }
    });
    on<AddTrainerEvent>((event, emit) async {
      emit(TrainerLoading());
      try {
        await addTrainerUseCase(event.trainer);
        final trainers = await getTrainersUseCase();
        emit(TrainerLoaded(trainers));
      } catch (e) {
        emit(TrainerError(e.toString()));
      }
    });
  }
}
