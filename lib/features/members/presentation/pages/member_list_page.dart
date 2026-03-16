import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/member_bloc.dart';
import '../bloc/member_event.dart';
import '../bloc/member_state.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_view.dart';
import 'add_member_page.dart';

class MemberListPage extends StatelessWidget {
  const MemberListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Members')),
      body: BlocBuilder<MemberBloc, MemberState>(
        builder: (context, state) {
          if (state is MemberInitial) {
            context.read<MemberBloc>().add(LoadMembers());
            return const LoadingIndicator();
          } else if (state is MemberLoading) {
            return const LoadingIndicator();
          } else if (state is MemberLoaded) {
            return ListView.builder(
              itemCount: state.members.length,
              itemBuilder: (context, index) {
                final member = state.members[index];
                return ListTile(
                  title: Text(member.name),
                  subtitle: Text('${member.email} - ${member.membershipType}'),
                );
              },
            );
          } else if (state is MemberError) {
            return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<MemberBloc>().add(LoadMembers());
                });
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddMemberPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
