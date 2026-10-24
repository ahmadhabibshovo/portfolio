import '../../domain/entities/skill_entity.dart';

class SkillModel extends SkillEntity {
  const SkillModel({
    required super.id,
    required super.name,
    required super.category,
    required super.iconUrl,
    required super.proficiency,
    required super.order,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? 'Tools & Platforms',
      iconUrl: json['icon_url'] as String? ?? '',
      proficiency: json['proficiency'] as int? ?? 80,
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'icon_url': iconUrl,
      'proficiency': proficiency,
      'order': order,
    };
  }
}
