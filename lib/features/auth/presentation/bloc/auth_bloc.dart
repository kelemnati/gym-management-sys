import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../../../core/services/session_manager.dart';
import '../../../../core/events/app_event_bus.dart';
import '../../../../core/events/app_events.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SessionManager sessionManager;
  final AppEventBus eventBus;

  AuthBloc(this.loginUseCase, this.sessionManager, this.eventBus)
      : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase(event.email, event.password);
        sessionManager.setToken('token'); // Assume token from response
        sessionManager.setLoggedIn(true);
        eventBus.fire(UserLoggedIn(user.id));
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
