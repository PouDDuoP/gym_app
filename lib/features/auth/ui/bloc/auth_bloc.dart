// import 'package:flutter/material.dart';
// // import 'package:gym_app/feature/auth/ui/pages/login_page.dart';
// import 'package:gym_app/feature/auth/ui/pages/login_page_gem.dart';

// class AuthBloc extends StatefulWidget {
//   const AuthBloc({super.key});

//   @override
//   State<AuthBloc> createState() => _AuthBlocState();
// }

// class _AuthBlocState extends State<AuthBloc> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // LogoComponenet(),
//         LoginPage()
//       ],
//     );
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc({required this.loginUsecase}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUsecase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
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
