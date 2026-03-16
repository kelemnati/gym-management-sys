import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/equipment_bloc.dart';
import '../bloc/equipment_event.dart';
import '../../domain/entities/equipment.dart';
import '../../../../shared/widgets/custom_button.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({super.key});

  @override
  State<AddEquipmentPage> createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Equipment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Equipment Name'),
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            CustomButton(
              text: 'Add',
              onPressed: () {
                final equipment = Equipment(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  type: _typeController.text,
                  status: 'available',
                );
                context.read<EquipmentBloc>().add(AddEquipmentEvent(equipment));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
