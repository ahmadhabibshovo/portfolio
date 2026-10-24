import '../../domain/entities/highlight_entity.dart';

class HighlightModel extends HighlightEntity {
  const HighlightModel({
    required super.id,
    required super.title,
    required super.description,
    required super.icon,
    super.colorTag = 'primary',
    super.order = 0,
  });

  factory HighlightModel.fromJson(Map<String, dynamic> json) {
    return HighlightModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? 'architecture',
      colorTag: json['color_tag'] as String? ?? 'primary',
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'color_tag': colorTag,
      'order': order,
    };
  }
}
