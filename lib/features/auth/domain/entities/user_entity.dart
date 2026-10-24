import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String role;
  final bool isActive;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.role,
    required this.isActive,
  });

  String get fullName => '$firstName $lastName'.trim();
  bool get isAdmin => role.toLowerCase() == 'admin';

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    phone,
    role,
    isActive,
  ];
}
