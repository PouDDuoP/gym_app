import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:gym_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:gym_app/features/auth/data/repositories/auth_repository_impl.dart';

// usecases
import 'package:gym_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:gym_app/features/auth/domain/usecases/register_usecase.dart';

import 'package:gym_app/features/auth/ui/bloc/auth_bloc.dart';
// import 'package:gym_app/features/auth/ui/pages/login_page.dart';
import 'package:gym_app/core/routes/routes.dart';

// Importa estilos generales
// import 'package:gym_app/core/widgets/app_colors.dart';

void main() {
  // Configuración de la inyección de dependencias
  final Dio dioClient = Dio();
  final AuthRemoteDataSourceImpl authRemoteDataSource = AuthRemoteDataSourceImpl(client: dioClient);
  final AuthRepositoryImpl authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource, client: dioClient);
  final LoginUsecase loginUsecase = LoginUsecase(authRepository);
  final RegisterUsecase registerUsecase = RegisterUsecase(authRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            loginUsecase: loginUsecase,
            registerUsecase: registerUsecase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STABILITY',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login,
      routes: routes,
    );
  }
}


// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         backgroundColor: AppColors.background,
//         // body: AuthBloc(),
//       ),
//     );
//   }
// }
