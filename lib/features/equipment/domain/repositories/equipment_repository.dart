import '../entities/equipment.dart';

abstract class EquipmentRepository {
  Future<List<Equipment>> getEquipment();
  Future<void> addEquipment(Equipment equipment);
  Future<void> updateEquipmentStatus(String id, String status);
}
