import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/class_bloc.dart';
import '../bloc/class_event.dart';
import '../bloc/class_state.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_view.dart';
import 'add_class_page.dart';

class ClassListPage extends StatelessWidget {
  const ClassListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Classes')),
      body: BlocBuilder<ClassBloc, ClassState>(
        builder: (context, state) {
          if (state is ClassInitial) {
            context.read<ClassBloc>().add(LoadClasses());
            return const LoadingIndicator();
          } else if (state is ClassLoading) {
            return const LoadingIndicator();
          } else if (state is ClassLoaded) {
            return ListView.builder(
              itemCount: state.classes.length,
              itemBuilder: (context, index) {
                final gymClass = state.classes[index];
                return ListTile(
                  title: Text(gymClass.name),
                  subtitle: Text(
                      '${gymClass.instructor} - ${gymClass.dateTime} - ${gymClass.enrolled}/${gymClass.capacity}'),
                );
              },
            );
          } else if (state is ClassError) {
            return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<ClassBloc>().add(LoadClasses());
                });
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddClassPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
