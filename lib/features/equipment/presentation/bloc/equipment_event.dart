import '../../domain/entities/equipment.dart';

abstract class EquipmentEvent {}

class LoadEquipment extends EquipmentEvent {}

class AddEquipmentEvent extends EquipmentEvent {
  final Equipment equipment;

  AddEquipmentEvent(this.equipment);
}

class UpdateEquipmentStatusEvent extends EquipmentEvent {
  final String id;
  final String status;

  UpdateEquipmentStatusEvent(this.id, this.status);
}
