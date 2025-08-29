import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Aquí se usaría un cliente HTTP como Dio para hacer la llamada a la API.
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<User> login(String email, String password) async {
    // Ejemplo de una llamada ficticia a una API
    try {
      // final response = await dio.post(
      //   '/login',
      //   data: {'email': email, 'password': password},
      // );
      
      // Simulamos una respuesta exitosa. En un proyecto real,
      // se parsearía la respuesta del servidor a una entidad User.
      return User(id: '123', email: email);
    } catch (e) {
      throw ServerException();
    }
  }
}