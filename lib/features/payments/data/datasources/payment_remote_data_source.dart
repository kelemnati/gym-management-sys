import 'package:dio/dio.dart';
import '../models/payment_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentModel>> getPayments();
  Future<void> addPayment(PaymentModel payment);
  Future<List<PaymentModel>> getPaymentsByMember(String memberId);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final Dio dio;

  PaymentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PaymentModel>> getPayments() async {
    // Mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      PaymentModel(
        id: '1',
        memberId: '1',
        amount: 50.0,
        date: DateTime(2023, 12, 1),
        status: 'paid',
      ),
      PaymentModel(
        id: '2',
        memberId: '2',
        amount: 30.0,
        date: DateTime(2023, 12, 5),
        status: 'paid',
      ),
      PaymentModel(
        id: '3',
        memberId: '3',
        amount: 50.0,
        date: DateTime(2023, 12, 10),
        status: 'pending',
      ),
      PaymentModel(
        id: '4',
        memberId: '4',
        amount: 30.0,
        date: DateTime(2023, 11, 28),
        status: 'overdue',
      ),
      PaymentModel(
        id: '5',
        memberId: '5',
        amount: 50.0,
        date: DateTime(2023, 12, 15),
        status: 'paid',
      ),
    ];
  }

  @override
  Future<void> addPayment(PaymentModel payment) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<List<PaymentModel>> getPaymentsByMember(String memberId) async {
    final allPayments = await getPayments();
    return allPayments.where((p) => p.memberId == memberId).toList();
  }
}
