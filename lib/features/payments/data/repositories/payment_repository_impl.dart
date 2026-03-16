import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';
import '../models/payment_model.dart';
import '../../../../core/network/network_info.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PaymentRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<List<Payment>> getPayments() async {
    if (await networkInfo.isConnected) {
      final payments = await remoteDataSource.getPayments();
      return payments;
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> addPayment(Payment payment) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.addPayment(PaymentModel(
        id: payment.id,
        memberId: payment.memberId,
        amount: payment.amount,
        date: payment.date,
        status: payment.status,
      ));
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<Payment>> getPaymentsByMember(String memberId) async {
    if (await networkInfo.isConnected) {
      final payments = await remoteDataSource.getPaymentsByMember(memberId);
      return payments;
    } else {
      throw Exception('No internet connection');
    }
  }
}
