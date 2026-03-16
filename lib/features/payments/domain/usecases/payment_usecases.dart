import '../entities/payment.dart';
import '../repositories/payment_repository.dart';

class GetPaymentsUseCase {
  final PaymentRepository repository;

  GetPaymentsUseCase(this.repository);

  Future<List<Payment>> call() {
    return repository.getPayments();
  }
}

class AddPaymentUseCase {
  final PaymentRepository repository;

  AddPaymentUseCase(this.repository);

  Future<void> call(Payment payment) {
    return repository.addPayment(payment);
  }
}

class GetPaymentsByMemberUseCase {
  final PaymentRepository repository;

  GetPaymentsByMemberUseCase(this.repository);

  Future<List<Payment>> call(String memberId) {
    return repository.getPaymentsByMember(memberId);
  }
}
