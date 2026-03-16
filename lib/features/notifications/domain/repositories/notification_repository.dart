import '../entities/notification.dart' as domain;

abstract class NotificationRepository {
  Future<List<domain.Notification>> getNotifications();
  Future<void> sendNotification(domain.Notification notification);
}
