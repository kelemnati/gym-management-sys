import 'package:dio/dio.dart';
import '../models/equipment_model.dart';

abstract class EquipmentRemoteDataSource {
  Future<List<EquipmentModel>> getEquipment();
  Future<void> addEquipment(EquipmentModel equipment);
  Future<void> updateEquipmentStatus(String id, String status);
}

class EquipmentRemoteDataSourceImpl implements EquipmentRemoteDataSource {
  final Dio dio;

  EquipmentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<EquipmentModel>> getEquipment() async {
    // Mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      EquipmentModel(
        id: '1',
        name: 'Treadmill',
        type: 'Cardio',
        status: 'available',
      ),
      EquipmentModel(
        id: '2',
        name: 'Dumbbells Set',
        type: 'Strength',
        status: 'available',
      ),
      EquipmentModel(
        id: '3',
        name: 'Yoga Mats',
        type: 'Accessories',
        status: 'available',
      ),
      EquipmentModel(
        id: '4',
        name: 'Elliptical Machine',
        type: 'Cardio',
        status: 'maintenance',
      ),
      EquipmentModel(
        id: '5',
        name: 'Bench Press',
        type: 'Strength',
        status: 'available',
      ),
    ];
  }

  @override
  Future<void> addEquipment(EquipmentModel equipment) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> updateEquipmentStatus(String id, String status) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
