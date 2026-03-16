import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../../domain/entities/notification.dart' as domain;
import '../../../../shared/widgets/custom_button.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Notification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _memberIdController,
              decoration: const InputDecoration(labelText: 'Member ID'),
            ),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Message'),
            ),
            CustomButton(
              text: 'Send',
              onPressed: () {
                final notification = domain.Notification(
                  id: DateTime.now().toString(),
                  memberId: _memberIdController.text,
                  message: _messageController.text,
                  date: DateTime.now(),
                );
                context
                    .read<NotificationBloc>()
                    .add(SendNotificationEvent(notification));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
