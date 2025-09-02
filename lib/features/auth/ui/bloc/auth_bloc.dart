import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/errors/failures.dart';
import 'package:gym_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:gym_app/features/auth/domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
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

  void _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUsecase(event.email, event.password, event.firstName, event.lastName, event.birthdate);
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Error del servidor. Por favor, inténtalo de nuevo más tarde.';
    } else {
      return 'Ocurrió un error inesperado.';
    }
  }

}
