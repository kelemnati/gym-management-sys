import '../../domain/entities/notification.dart' as domain;

abstract class NotificationEvent {}

class LoadNotifications extends NotificationEvent {}

class SendNotificationEvent extends NotificationEvent {
  final domain.Notification notification;

  SendNotificationEvent(this.notification);
}
