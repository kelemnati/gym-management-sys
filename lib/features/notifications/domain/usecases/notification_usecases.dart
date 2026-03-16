import '../entities/notification.dart' as domain;
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<List<domain.Notification>> call() {
    return repository.getNotifications();
  }
}

class SendNotificationUseCase {
  final NotificationRepository repository;

  SendNotificationUseCase(this.repository);

  Future<void> call(domain.Notification notification) {
    return repository.sendNotification(notification);
  }
}
