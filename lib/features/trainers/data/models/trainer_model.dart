import '../../domain/entities/trainer.dart';

class TrainerModel extends Trainer {
  TrainerModel({
    required super.id,
    required super.name,
    required super.specialization,
  });

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
    };
  }
}
