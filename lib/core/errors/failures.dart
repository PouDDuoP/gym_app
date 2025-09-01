import 'package:equatable/equatable.dart';

/// Fallo para errores de la lógica de negocio.
abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}
class CacheFailure extends Failure {}

/// Fallo que indica que el email o la contraseña son inválidos.
class InvalidCredentialsFailure extends Failure {}

/// Fallo que indica que no se pudo acceder a la red.
class NetworkFailure extends Failure {}