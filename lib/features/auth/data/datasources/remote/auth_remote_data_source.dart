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
      )
    );
  }
}

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Aquí se usaría un cliente HTTP como Dio para hacer la llamada a la API.
  final Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  /*
  // Lista de usuarios simulada con datos completos y contraseñas hasheadas.
  // Nota: El campo 'plainPassword' es solo para fines de prueba
  final List<Map<String, String>> _storedUsers = [
    {
      'id': '1',
      'fistName': 'Kevin',
      'lastName': 'Alvarado',
      'email': 'kevin.alvarado@example.com',
      'plainPassword': 'password1',
      'password': r'$2a$12$UyQj/rfgvTPmnwWM4cUz6OH0O7jGXWcm6Cyc.sm97Q7XkC8xbasky' // HASH de "password1"
    },
    {
      'id': '2',
      'fistName': 'Maria',
      'lastName': 'Gomez',
      'email': 'maria.gomez@example.com',
      'plainPassword': 'password2',
      'password': r'$2a$12$m39O6/MheWTyWvbU6Kr3zu02piW1Yoq4R.jQzk6pMvBG2PKYHgy9q' // HASH de "password2"
    },
    {
      'id': '3',
      'fistName': 'Carlos',
      'lastName': 'Rodriguez',
      'email': 'carlos.rodriguez@example.com',
      'plainPassword': 'password3',
      'password': r'$2a$12$TsCXol3PzIXMXk38yG5FWuw3ewjLDWI.DOfdDG/go9qaehdGFy/Je' // HASH de "password3"
    },
    {
      'id': '4',
      'fistName': 'Ana',
      'lastName': 'Lopez',
      'email': 'ana.lopez@example.com',
      'plainPassword': 'password4',
      'password': r'$2a$12$HVVv74hiXK1fVqupjA4IQe6Z86SMeNkg1.UZWQt5.ciCBCI6p116W' // HASH de "password4"
    },
    {
      'id': '5',
      'fistName': 'Luis',
      'lastName': 'Fernandez',
      'email': 'luis.fernandez@example.com',
      'plainPassword': 'password5',
      'password': r'$2a$12$JZVT0QINTcz1vvc3NWy/oezJSn8.sh6t00CzNvMwwNz/v8Mk5CMQu' // HASH de "password5"
    },
    {
      'id': '6',
      'fistName': 'Sofia',
      'lastName': 'Ramirez',
      'email': 'sofia.ramirez@example.com',
      'plainPassword': 'password6',
      'password': r'$2a$12$LlmpqWzs0TSfibftUk30EOi4QbQ5Mh8OCdnw5Q5xTVmTn.0Z9.5wG' // HASH de "password6"
    },
    {
      'id': '7',
      'fistName': 'Diego',
      'lastName': 'Torres',
      'email': 'diego.torres@example.com',
      'plainPassword': 'password7',
      'password': r'$2a$12$cAM99B42mCKBdo8nLOGNQupt8szZLstKQ/SAhfiSVOy4OlAoVI0Wu' // HASH de "password7"
    },
    {
      'id': '8',
      'fistName': 'Valeria',
      'lastName': 'Vargas',
      'email': 'valeria.vargas@example.com',
      'plainPassword': 'password8',
      'password': r'$2a$12$cAM99B42mCKBdo8nLOGNQupt8szZLstKQ/SAhfiSVOy4OlAoVI0Wu' // HASH de "password8"
    },
    {
      'id': '9',
      'fistName': 'Ricardo',
      'lastName': 'Herrera',
      'email': 'ricardo.herrera@example.com',
      'plainPassword': 'password9',
      'password': r'$2a$12$sO9vKAb5wGxVNQZivirDweeulWBcsRg1FBapG6my.FW4JYcgiWaea' // HASH de "password9"
    },
    {
      'id': '10',
      'fistName': 'Camila',
      'lastName': 'Castro',
      'email': 'camila.castro@example.com',
      'plainPassword': 'password0',
      'password': r'$2a$12$60UCEH4az6QPvFv5qblpv.0ySaVBesXChoDQ4nPRU8UcAYWn3JcgO' // HASH de "password0"
    }
  ];

  @override
  Future<User> login(String email, String password) async {
    // Simular un retraso de red
    await Future.delayed(const Duration(seconds: 2));

    // Buscar al usuario por email en la lista simulada
    final userMatch = _storedUsers.firstWhere(
      (user) => user['email'] == email,
      orElse: () => {},
    );

    // final String passwordTest = 'password1';
    // final String salt = BCrypt.gensalt(logRounds: 12);

    // final String hashedPassword = BCrypt.hashpw(passwordTest, salt);
    // final hashedPasswordTest = BCrypt.checkpw(passwordTest, hashedPassword);
    
  

    // print(hashedPassword);
    // print(hashedPasswordTest);

    // print(userMatch);
    // print(userMatch['password']);
    // print(password);
    // print(BCrypt.checkpw(password, userMatch['password']!));

    if (userMatch.isNotEmpty) {
      final hashedPassword = userMatch['password']!;
      final isPasswordValid = BCrypt.checkpw(password, hashedPassword);
      if (isPasswordValid) {
        return User(
          id: userMatch['id']!,
          email: userMatch['email']!,
          fistName: userMatch['fistName']!,
          lastName: userMatch['lastName']!,
        );
      }
    }
    throw const AuthException('invalid_credentials');
  }
  */

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
}