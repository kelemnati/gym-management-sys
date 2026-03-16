import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/trainer_bloc.dart';
import '../bloc/trainer_event.dart';
import '../../domain/entities/trainer.dart';
import '../../../../shared/widgets/custom_button.dart';

class AddTrainerPage extends StatefulWidget {
  const AddTrainerPage({super.key});

  @override
  State<AddTrainerPage> createState() => _AddTrainerPageState();
}

class _AddTrainerPageState extends State<AddTrainerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Trainer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _specializationController,
              decoration: const InputDecoration(labelText: 'Specialization'),
            ),
            CustomButton(
              text: 'Add',
              onPressed: () {
                final trainer = Trainer(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  specialization: _specializationController.text,
                );
                context.read<TrainerBloc>().add(AddTrainerEvent(trainer));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
