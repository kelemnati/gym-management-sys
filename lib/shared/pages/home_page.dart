import 'package:flutter/material.dart';
import '../../features/members/presentation/pages/member_list_page.dart';
import '../../features/classes/presentation/pages/class_list_page.dart';
import '../../features/equipment/presentation/pages/equipment_list_page.dart';
import '../../features/payments/presentation/pages/payment_list_page.dart';
import '../../features/attendance/presentation/pages/attendance_list_page.dart';
import '../../features/trainers/presentation/pages/trainer_list_page.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/notifications/presentation/pages/notification_list_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/qr_checkin/presentation/pages/qr_check_in_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'title': 'Members',
        'icon': Icons.people,
        'page': const MemberListPage()
      },
      {
        'title': 'Classes',
        'icon': Icons.fitness_center,
        'page': const ClassListPage()
      },
      {
        'title': 'Equipment',
        'icon': Icons.build,
        'page': const EquipmentListPage()
      },
      {
        'title': 'Payments',
        'icon': Icons.payment,
        'page': const PaymentListPage()
      },
      {
        'title': 'Attendance',
        'icon': Icons.check_circle,
        'page': const AttendanceListPage()
      },
      {
        'title': 'Trainers',
        'icon': Icons.person,
        'page': const TrainerListPage()
      },
      {
        'title': 'Reports',
        'icon': Icons.bar_chart,
        'page': const ReportsPage()
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications,
        'page': const NotificationListPage()
      },
      {
        'title': 'Profile',
        'icon': Icons.account_circle,
        'page': const ProfilePage()
      },
      {
        'title': 'QR Check-In',
        'icon': Icons.qr_code_scanner,
        'page': const QrCheckInPage()
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('GymPro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout logic
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to GymPro',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Manage your gym efficiently',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => feature['page'] as Widget),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            feature['icon'] as IconData,
                            size: 48,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            feature['title'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
