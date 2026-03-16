// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/class_bloc.dart';
import '../bloc/class_event.dart';
import '../../domain/entities/gym_class.dart';
import '../../../../shared/widgets/custom_button.dart';

class AddClassPage extends StatefulWidget {
  const AddClassPage({super.key});

  @override
  State<AddClassPage> createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Class')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Class Name'),
            ),
            TextField(
              controller: _instructorController,
              decoration: const InputDecoration(labelText: 'Instructor'),
            ),
            TextField(
              controller: _capacityController,
              decoration: const InputDecoration(labelText: 'Capacity'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                if (!mounted) return;
                final localContext = context;

                final picked = await showDatePicker(
                  context: localContext,
                  initialDate: _selectedDateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (!mounted || picked == null) return;

                final time = await showTimePicker(
                  context: localContext,
                  initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
                );
                if (!mounted || time == null) return;

                setState(() {
                  _selectedDateTime = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    time.hour,
                    time.minute,
                  );
                });
              },
              child: Text('Select Date & Time: ${_selectedDateTime.toLocal()}'),
            ),
            CustomButton(
              text: 'Add',
              onPressed: () {
                final gymClass = GymClass(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  instructor: _instructorController.text,
                  dateTime: _selectedDateTime,
                  capacity: int.parse(_capacityController.text),
                  enrolled: 0,
                );
                context.read<ClassBloc>().add(AddClassEvent(gymClass));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
