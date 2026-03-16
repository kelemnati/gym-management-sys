import '../../domain/entities/notification.dart' as domain;
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_data_source.dart';
import '../models/notification_model.dart';
import '../../../../core/network/network_info.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NotificationRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<List<domain.Notification>> getNotifications() async {
    if (await networkInfo.isConnected) {
      final notifications = await remoteDataSource.getNotifications();
      return notifications;
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> sendNotification(domain.Notification notification) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.sendNotification(NotificationModel(
        id: notification.id,
        memberId: notification.memberId,
        message: notification.message,
        date: notification.date,
      ));
    } else {
      throw Exception('No internet connection');
    }
  }
}
