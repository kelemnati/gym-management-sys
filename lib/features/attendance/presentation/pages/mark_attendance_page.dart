import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../../domain/entities/attendance.dart';
import '../../../../shared/widgets/custom_button.dart';

class MarkAttendancePage extends StatefulWidget {
  const MarkAttendancePage({super.key});

  @override
  State<MarkAttendancePage> createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _classIdController = TextEditingController();
  String _status = 'present';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _memberIdController,
              decoration: const InputDecoration(labelText: 'Member ID'),
            ),
            TextField(
              controller: _classIdController,
              decoration: const InputDecoration(labelText: 'Class ID'),
            ),
            DropdownButton<String>(
              value: _status,
              items: ['present', 'absent'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
            ),
            CustomButton(
              text: 'Mark',
              onPressed: () {
                final attendance = Attendance(
                  id: DateTime.now().toString(),
                  memberId: _memberIdController.text,
                  classId: _classIdController.text,
                  date: DateTime.now(),
                  status: _status,
                );
                context
                    .read<AttendanceBloc>()
                    .add(MarkAttendanceEvent(attendance));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
