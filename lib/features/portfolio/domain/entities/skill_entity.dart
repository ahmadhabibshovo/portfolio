import 'package:equatable/equatable.dart';

class SkillEntity extends Equatable {
  final int id;
  final String name;
  final String category;
  final String iconUrl;
  final int proficiency;
  final int order;

  const SkillEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.iconUrl,
    required this.proficiency,
    required this.order,
  });

  @override
  List<Object?> get props => [id, name, category, iconUrl, proficiency, order];
}
