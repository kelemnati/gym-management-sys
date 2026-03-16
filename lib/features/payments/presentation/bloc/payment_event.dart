import '../../domain/entities/payment.dart';

abstract class PaymentEvent {}

class LoadPayments extends PaymentEvent {}

class AddPaymentEvent extends PaymentEvent {
  final Payment payment;

  AddPaymentEvent(this.payment);
}

class LoadPaymentsByMember extends PaymentEvent {
  final String memberId;

  LoadPaymentsByMember(this.memberId);
}
