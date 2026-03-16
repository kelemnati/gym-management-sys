import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/equipment_bloc.dart';
import '../bloc/equipment_event.dart';
import '../bloc/equipment_state.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_view.dart';
import 'add_equipment_page.dart';

class EquipmentListPage extends StatelessWidget {
  const EquipmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Equipment')),
      body: BlocBuilder<EquipmentBloc, EquipmentState>(
        builder: (context, state) {
          if (state is EquipmentInitial) {
            context.read<EquipmentBloc>().add(LoadEquipment());
            return const LoadingIndicator();
          } else if (state is EquipmentLoading) {
            return const LoadingIndicator();
          } else if (state is EquipmentLoaded) {
            return ListView.builder(
              itemCount: state.equipment.length,
              itemBuilder: (context, index) {
                final eq = state.equipment[index];
                return ListTile(
                  title: Text(eq.name),
                  subtitle: Text('${eq.type} - ${eq.status}'),
                  trailing: PopupMenuButton<String>(
                    onSelected: (status) {
                      context
                          .read<EquipmentBloc>()
                          .add(UpdateEquipmentStatusEvent(eq.id, status));
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: 'available', child: Text('Available')),
                      const PopupMenuItem(
                          value: 'in_use', child: Text('In Use')),
                      const PopupMenuItem(
                          value: 'maintenance', child: Text('Maintenance')),
                    ],
                  ),
                );
              },
            );
          } else if (state is EquipmentError) {
            return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<EquipmentBloc>().add(LoadEquipment());
                });
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddEquipmentPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
