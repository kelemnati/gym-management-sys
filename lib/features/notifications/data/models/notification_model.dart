import '../../domain/entities/notification.dart' as domain;

class NotificationModel extends domain.Notification {
  NotificationModel({
    required super.id,
    required super.memberId,
    required super.message,
    required super.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      memberId: json['memberId'],
      message: json['message'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'message': message,
      'date': date.toIso8601String(),
    };
  }
}
