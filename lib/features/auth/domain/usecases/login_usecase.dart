import 'package:dartz/dartz.dart';
import 'package:stability_front/core/errors/failures.dart';
import 'package:stability_front/features/auth/domain/entities/user.dart';
import 'package:stability_front/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}