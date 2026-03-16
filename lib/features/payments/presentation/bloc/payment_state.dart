import '../../domain/entities/payment.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<Payment> payments;

  PaymentLoaded(this.payments);
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError(this.message);
}
