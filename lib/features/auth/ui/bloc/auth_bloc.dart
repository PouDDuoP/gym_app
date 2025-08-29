import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/errors/failures.dart';
import 'package:gym_app/features/auth/domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc({required this.loginUsecase}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUsecase(event.email, event.password);
    result.fold(
      (failure){
        if (failure is InvalidCredentialsFailure) {
          emit(const AuthError('Email o contraseña inválidos.'));
        } else {
          emit(const AuthError('Error de red. Inténtalo de nuevo.'));
        }
      },
      (user) => emit(AuthSuccess(user)),
    );
  }
}
