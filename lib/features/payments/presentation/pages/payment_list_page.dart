import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_view.dart';
import 'add_payment_page.dart';

class PaymentListPage extends StatelessWidget {
  const PaymentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentInitial) {
            context.read<PaymentBloc>().add(LoadPayments());
            return const LoadingIndicator();
          } else if (state is PaymentLoading) {
            return const LoadingIndicator();
          } else if (state is PaymentLoaded) {
            return ListView.builder(
              itemCount: state.payments.length,
              itemBuilder: (context, index) {
                final payment = state.payments[index];
                return ListTile(
                  title: Text('Member: ${payment.memberId}'),
                  subtitle: Text(
                      'Amount: \$${payment.amount} - ${payment.status} - ${payment.date}'),
                );
              },
            );
          } else if (state is PaymentError) {
            return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<PaymentBloc>().add(LoadPayments());
                });
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddPaymentPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
