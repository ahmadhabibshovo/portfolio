import '../../domain/entities/contact_message_entity.dart';

class ContactMessageModel extends ContactMessageEntity {
  const ContactMessageModel({
    required super.id,
    required super.name,
    required super.email,
    required super.subject,
    required super.message,
    required super.isRead,
    required super.createdAt,
  });

  factory ContactMessageModel.fromJson(Map<String, dynamic> json) {
    return ContactMessageModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      message: json['message'] as String? ?? '',
      isRead: json['is_read'] as bool? ?? false,
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}
