import 'package:equatable/equatable.dart';

class ContactMessageEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final bool isRead;
  final String createdAt;

  const ContactMessageEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    subject,
    message,
    isRead,
    createdAt,
  ];
}
