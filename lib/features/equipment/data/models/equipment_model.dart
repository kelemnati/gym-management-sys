import '../../domain/entities/equipment.dart';

class EquipmentModel extends Equipment {
  EquipmentModel({
    required super.id,
    required super.name,
    required super.type,
    required super.status,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) {
    return EquipmentModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'status': status,
    };
  }
}
