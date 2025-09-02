
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gym_app/core/errors/failures.dart';
import 'package:gym_app/core/errors/exceptions.dart';
import 'package:gym_app/features/auth/domain/entities/user.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:gym_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final Dio client;

  AuthRepositoryImpl({required this.remoteDataSource, required this.client});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final response = await remoteDataSource.login(email, password);

      // Clean Architecture: Actualizar token dinámicamente en ApiService (ejemplo)
      // NOTA: No tengo la implemenacion de updateBearerToken
      // await api.updateBearerToken(response.accessToken);

      // Guardar datos adicionales en SharedPreferences
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('refreshToken', response.refreshToken);

      // Limpia cualquier valor previo de 'role' para evitar errores de tipo
      await prefs.remove('role');

      final roleName = response.user.role;

      try {
        await prefs.setString('role', roleName);
      } catch (e) {
        rethrow;
      }

      await prefs.setString('userId', response.user.id);
      await prefs.setString('userEmail', response.user.email);
      
      return Right(response.user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password, String firstName, String lastName, String birthdate) async {
    try {
      final response = await remoteDataSource.register(email, password, firstName, lastName, birthdate);
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('refreshToken', response.refreshToken);
      await prefs.remove('role');

      final roleName = response.user.role;

      try {
        await prefs.setString('role', roleName);
      } catch (e) {
        rethrow;
      }
      await prefs.setString('userId', response.user.id);
      await prefs.setString('userEmail', response.user.email);

      return Right(response.user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}