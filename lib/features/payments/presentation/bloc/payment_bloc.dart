import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/payment_usecases.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentsUseCase getPaymentsUseCase;
  final AddPaymentUseCase addPaymentUseCase;
  final GetPaymentsByMemberUseCase getPaymentsByMemberUseCase;

  PaymentBloc(this.getPaymentsUseCase, this.addPaymentUseCase,
      this.getPaymentsByMemberUseCase)
      : super(PaymentInitial()) {
    on<LoadPayments>((event, emit) async {
      emit(PaymentLoading());
      try {
        final payments = await getPaymentsUseCase();
        emit(PaymentLoaded(payments));
      } catch (e) {
        emit(PaymentError(e.toString()));
      }
    });
    on<AddPaymentEvent>((event, emit) async {
      emit(PaymentLoading());
      try {
        await addPaymentUseCase(event.payment);
        final payments = await getPaymentsUseCase();
        emit(PaymentLoaded(payments));
      } catch (e) {
        emit(PaymentError(e.toString()));
      }
    });
    on<LoadPaymentsByMember>((event, emit) async {
      emit(PaymentLoading());
      try {
        final payments = await getPaymentsByMemberUseCase(event.memberId);
        emit(PaymentLoaded(payments));
      } catch (e) {
        emit(PaymentError(e.toString()));
      }
    });
  }
}
