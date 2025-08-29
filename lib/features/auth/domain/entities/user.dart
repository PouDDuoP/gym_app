import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fistName;
  final String lastName;

  const User({
    required this.id,
    required this.email,
    required this.fistName,
    required this.lastName,
  });

  @override
  @override
  List<Object?> get props => [id, email, fistName, lastName];
}