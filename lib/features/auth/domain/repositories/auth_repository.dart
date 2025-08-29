import 'package:dartz/dartz.dart';
import 'package:gym_app/core/errors/failures.dart';
import 'package:gym_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}