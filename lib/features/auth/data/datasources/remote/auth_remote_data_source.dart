import 'package:dio/dio.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:gym_app/core/errors/failures.dart';
import 'package:gym_app/core/errors/exceptions.dart';
import 'package:gym_app/features/auth/domain/entities/user.dart';

// LoginResponse es para la respuesta completa de la API, integrando todos los valores de respuesta como tokens y usuario.
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'], 
      refreshToken: json['refreshToken'], 
      user: User(
        id: json['user']['id'], 
        email: json['user']['email'], 
        firstName: json['user']['firstName'], 
        lastName: json['user']['lastName'],
        role: json['user']['role'],
        birthdate: json['user']['birthdate'],
      )
    );
  }
}

// Clase para el respueta del registro
class RegisterResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  RegisterResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: User(
        id: json['user']['id'], 
        email: json['user']['email'], 
        firstName: json['user']['firstName'], 
        lastName: json['user']['lastName'],
        role: json['user']['role'],
        birthdate: json['user']['birthdate'],
      ),
    );
  }
}

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String email, String password);
  Future<RegisterResponse> register(String email, String password, String firstName, String lastName, String birthdate);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Aquí se usaría un cliente HTTP como Dio para hacer la llamada a la API.
  final Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  // login
  @override
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await client.post(
        '/authentication/login', 
        data: {
          'email': email,
          'password': password,
        }
      );
      return LoginResponse.fromJson(response.data);
    } on DioException {
      throw ServerException();
    }
  }

  // register
  @override
  Future<RegisterResponse> register(String email, String password, String firstName, String lastName, String birthdate) async {
    try {
      final response = await client.post(
        '/authentication/register', 
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'birthdate': birthdate,
        }
      );
      return RegisterResponse.fromJson(response.data);
    } on DioException {
      throw ServerException();
    }
  }
}