import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_equipment_usecase.dart';
import '../../domain/usecases/add_equipment_usecase.dart';
import '../../domain/usecases/update_equipment_status_usecase.dart';
import 'equipment_event.dart';
import 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  final GetEquipmentUseCase getEquipmentUseCase;
  final AddEquipmentUseCase addEquipmentUseCase;
  final UpdateEquipmentStatusUseCase updateEquipmentStatusUseCase;

  EquipmentBloc(this.getEquipmentUseCase, this.addEquipmentUseCase,
      this.updateEquipmentStatusUseCase)
      : super(EquipmentInitial()) {
    on<LoadEquipment>((event, emit) async {
      emit(EquipmentLoading());
      try {
        final equipment = await getEquipmentUseCase();
        emit(EquipmentLoaded(equipment));
      } catch (e) {
        emit(EquipmentError(e.toString()));
      }
    });
    on<AddEquipmentEvent>((event, emit) async {
      emit(EquipmentLoading());
      try {
        await addEquipmentUseCase(event.equipment);
        final equipment = await getEquipmentUseCase();
        emit(EquipmentLoaded(equipment));
      } catch (e) {
        emit(EquipmentError(e.toString()));
      }
    });
    on<UpdateEquipmentStatusEvent>((event, emit) async {
      emit(EquipmentLoading());
      try {
        await updateEquipmentStatusUseCase(event.id, event.status);
        final equipment = await getEquipmentUseCase();
        emit(EquipmentLoaded(equipment));
      } catch (e) {
        emit(EquipmentError(e.toString()));
      }
    });
  }
}
