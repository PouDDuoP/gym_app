import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

// Importa las clases de tu módulo de autenticación
import 'package:gym_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:gym_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:gym_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:gym_app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:gym_app/features/auth/ui/pages/login_page.dart';

// import 'package:gym_app/core/widgets/app_colors.dart';

void main() {
  // Configuración de la inyección de dependencias (para este ejemplo, manual)
  final dio = Dio();
  final authRemoteDataSource = AuthRemoteDataSourceImpl(dio);
  final authRepository = AuthRepositoryImpl(authRemoteDataSource);
  final loginUsecase = LoginUsecase(authRepository);

  // Ejecuta la aplicación
  runApp(
    MultiBlocProvider(
      providers: [
        // Provee el AuthBloc a toda la aplicación
        BlocProvider(
          create: (context) => AuthBloc(loginUsecase: loginUsecase),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo de Autenticación',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Replace with a valid MaterialColor
      ),
      home: LoginPage(),
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
