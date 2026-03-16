import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/member_bloc.dart';
import '../bloc/member_event.dart';
import '../../domain/entities/member.dart';
import '../../../../shared/widgets/custom_button.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key});

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _membershipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Member')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _membershipController,
              decoration: const InputDecoration(labelText: 'Membership Type'),
            ),
            CustomButton(
              text: 'Add',
              onPressed: () {
                final member = Member(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  email: _emailController.text,
                  membershipType: _membershipController.text,
                );
                context.read<MemberBloc>().add(AddMemberEvent(member));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
