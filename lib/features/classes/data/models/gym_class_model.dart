import '../../domain/entities/gym_class.dart';

class GymClassModel extends GymClass {
  GymClassModel({
    required super.id,
    required super.name,
    required super.instructor,
    required super.dateTime,
    required super.capacity,
    required super.enrolled,
  });

  factory GymClassModel.fromJson(Map<String, dynamic> json) {
    return GymClassModel(
      id: json['id'],
      name: json['name'],
      instructor: json['instructor'],
      dateTime: DateTime.parse(json['dateTime']),
      capacity: json['capacity'],
      enrolled: json['enrolled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'instructor': instructor,
      'dateTime': dateTime.toIso8601String(),
      'capacity': capacity,
      'enrolled': enrolled,
    };
  }
}
