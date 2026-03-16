import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/trainer_bloc.dart';
import '../bloc/trainer_event.dart';
import '../bloc/trainer_state.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_view.dart';
import 'add_trainer_page.dart';

class TrainerListPage extends StatelessWidget {
  const TrainerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trainers')),
      body: BlocBuilder<TrainerBloc, TrainerState>(
        builder: (context, state) {
          if (state is TrainerInitial) {
            context.read<TrainerBloc>().add(LoadTrainers());
            return const LoadingIndicator();
          } else if (state is TrainerLoading) {
            return const LoadingIndicator();
          } else if (state is TrainerLoaded) {
            return ListView.builder(
              itemCount: state.trainers.length,
              itemBuilder: (context, index) {
                final trainer = state.trainers[index];
                return ListTile(
                  title: Text(trainer.name),
                  subtitle: Text(trainer.specialization),
                );
              },
            );
          } else if (state is TrainerError) {
            return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<TrainerBloc>().add(LoadTrainers());
                });
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddTrainerPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
