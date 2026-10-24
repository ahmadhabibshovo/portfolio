import '../../domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.id,
    required super.role,
    required super.company,
    required super.location,
    required super.startDate,
    required super.endDate,
    required super.isCurrent,
    required super.description,
    required super.order,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as int? ?? 0,
      role: json['role'] as String? ?? '',
      company: json['company'] as String? ?? '',
      location: json['location'] as String? ?? '',
      startDate: json['start_date'] as String? ?? '',
      endDate: json['end_date'] as String? ?? '',
      isCurrent: json['is_current'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'company': company,
      'location': location,
      'start_date': startDate,
      'end_date': endDate,
      'is_current': isCurrent,
      'description': description,
      'order': order,
    };
  }
}
