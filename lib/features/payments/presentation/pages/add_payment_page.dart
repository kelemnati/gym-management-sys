import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../../domain/entities/payment.dart';
import '../../../../shared/widgets/custom_button.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({super.key});

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _status = 'paid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _memberIdController,
              decoration: const InputDecoration(labelText: 'Member ID'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _status,
              items: ['paid', 'pending', 'overdue'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
            ),
            CustomButton(
              text: 'Add',
              onPressed: () {
                final payment = Payment(
                  id: DateTime.now().toString(),
                  memberId: _memberIdController.text,
                  amount: double.parse(_amountController.text),
                  date: DateTime.now(),
                  status: _status,
                );
                context.read<PaymentBloc>().add(AddPaymentEvent(payment));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
