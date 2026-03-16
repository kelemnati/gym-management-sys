import 'package:dio/dio.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> sendNotification(NotificationModel notification);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final Dio dio;

  NotificationRemoteDataSourceImpl(this.dio);

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      NotificationModel(
        id: '1',
        memberId: '1',
        message: 'Your Yoga class starts in 30 minutes!',
        date: DateTime(2023, 12, 15, 8, 30),
      ),
      NotificationModel(
        id: '2',
        memberId: '2',
        message: 'Payment reminder: Your membership fee is due.',
        date: DateTime(2023, 12, 14, 10, 0),
      ),
      NotificationModel(
        id: '3',
        memberId: '3',
        message: 'New HIIT class available for booking.',
        date: DateTime(2023, 12, 13, 14, 0),
      ),
      NotificationModel(
        id: '4',
        memberId: '4',
        message:
            'Equipment maintenance: Treadmill will be unavailable tomorrow.',
        date: DateTime(2023, 12, 12, 16, 0),
      ),
      NotificationModel(
        id: '5',
        memberId: '5',
        message: 'Congratulations! You\'ve completed 10 classes this month.',
        date: DateTime(2023, 12, 11, 12, 0),
      ),
    ];
  }

  @override
  Future<void> sendNotification(NotificationModel notification) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
