import '../../domain/entities/equipment.dart';
import '../../domain/repositories/equipment_repository.dart';
import '../datasources/equipment_remote_data_source.dart';
import '../models/equipment_model.dart';
import '../../../../core/network/network_info.dart';

class EquipmentRepositoryImpl implements EquipmentRepository {
  final EquipmentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EquipmentRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<List<Equipment>> getEquipment() async {
    if (await networkInfo.isConnected) {
      final equipment = await remoteDataSource.getEquipment();
      return equipment;
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> addEquipment(Equipment equipment) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.addEquipment(EquipmentModel(
        id: equipment.id,
        name: equipment.name,
        type: equipment.type,
        status: equipment.status,
      ));
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> updateEquipmentStatus(String id, String status) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.updateEquipmentStatus(id, status);
    } else {
      throw Exception('No internet connection');
    }
  }
}
