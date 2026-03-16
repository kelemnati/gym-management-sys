import '../../domain/entities/equipment.dart';

abstract class EquipmentState {}

class EquipmentInitial extends EquipmentState {}

class EquipmentLoading extends EquipmentState {}

class EquipmentLoaded extends EquipmentState {
  final List<Equipment> equipment;

  EquipmentLoaded(this.equipment);
}

class EquipmentError extends EquipmentState {
  final String message;

  EquipmentError(this.message);
}
