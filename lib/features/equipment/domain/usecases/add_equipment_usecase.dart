import '../entities/equipment.dart';
import '../repositories/equipment_repository.dart';

class AddEquipmentUseCase {
  final EquipmentRepository repository;

  AddEquipmentUseCase(this.repository);

  Future<void> call(Equipment equipment) {
    return repository.addEquipment(equipment);
  }
}
