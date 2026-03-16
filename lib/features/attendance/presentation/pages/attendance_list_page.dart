import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_view.dart';
import 'mark_attendance_page.dart';

class AttendanceListPage extends StatelessWidget {
  const AttendanceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          if (state is AttendanceInitial) {
            context.read<AttendanceBloc>().add(LoadAttendance());
            return const LoadingIndicator();
          } else if (state is AttendanceLoading) {
            return const LoadingIndicator();
          } else if (state is AttendanceLoaded) {
            return ListView.builder(
              itemCount: state.attendance.length,
              itemBuilder: (context, index) {
                final att = state.attendance[index];
                return ListTile(
                  title: Text('Member: ${att.memberId}'),
                  subtitle: Text(
                      'Class: ${att.classId} - ${att.status} - ${att.date}'),
                );
              },
            );
          } else if (state is AttendanceError) {
            return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<AttendanceBloc>().add(LoadAttendance());
                });
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const MarkAttendancePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
