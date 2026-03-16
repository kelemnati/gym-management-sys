import '../entities/equipment.dart';
import '../repositories/equipment_repository.dart';

class GetEquipmentUseCase {
  final EquipmentRepository repository;

  GetEquipmentUseCase(this.repository);

  Future<List<Equipment>> call() {
    return repository.getEquipment();
  }
}
