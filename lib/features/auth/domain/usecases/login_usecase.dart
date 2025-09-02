import 'package:dartz/dartz.dart';
import 'package:gym_app/core/errors/failures.dart';
import 'package:gym_app/features/auth/domain/entities/user.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}