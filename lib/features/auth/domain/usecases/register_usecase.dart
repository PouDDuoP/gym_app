import 'package:dartz/dartz.dart';
import 'package:gym_app/core/errors/failures.dart';
import 'package:gym_app/features/auth/domain/entities/user.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, User>> call(String email, String password, String firstName, String lastName, String birthdate) async {
    return await repository.register(email, password, firstName, lastName, birthdate);
  }
}