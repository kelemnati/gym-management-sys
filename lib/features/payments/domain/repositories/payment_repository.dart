import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<List<Payment>> getPayments();
  Future<void> addPayment(Payment payment);
  Future<List<Payment>> getPaymentsByMember(String memberId);
}
