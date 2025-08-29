
import 'package:dartz/dartz.dart';
import 'package:gym_app/core/errors/failures.dart';
// import 'package:gym_app//core/errors/exceptions.dart';
import 'package:gym_app/features/auth/domain/entities/user.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:gym_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // Si tuvieras una fuente de datos local, también la inyectarías aquí:
  // final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } on AuthException catch (e) {
      if (e.message == 'invalid_credentials') {
        return Left(InvalidCredentialsFailure());
      }
      return Left(NetworkFailure());
    }
  }
}