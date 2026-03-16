import '../repositories/equipment_repository.dart';

class UpdateEquipmentStatusUseCase {
  final EquipmentRepository repository;

  UpdateEquipmentStatusUseCase(this.repository);

  Future<void> call(String id, String status) {
    return repository.updateEquipmentStatus(id, status);
  }
}
