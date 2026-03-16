import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_view.dart';
import 'send_notification_page.dart';

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationInitial) {
            context.read<NotificationBloc>().add(LoadNotifications());
            return const LoadingIndicator();
          } else if (state is NotificationLoading) {
            return const LoadingIndicator();
          } else if (state is NotificationLoaded) {
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final notif = state.notifications[index];
                return ListTile(
                  title: Text('To: ${notif.memberId}'),
                  subtitle: Text('${notif.message} - ${notif.date}'),
                );
              },
            );
          } else if (state is NotificationError) {
            return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<NotificationBloc>().add(LoadNotifications());
                });
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SendNotificationPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
