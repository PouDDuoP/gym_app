class ServerException implements Exception {}
class CacheException implements Exception {}

/// Excepción para errores relacionados con la autenticación.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}