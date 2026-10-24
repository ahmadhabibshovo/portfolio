import '../../domain/entities/social_link_entity.dart';

class SocialLinkModel extends SocialLinkEntity {
  const SocialLinkModel({
    required super.id,
    required super.platform,
    required super.url,
    required super.icon,
    super.isActive = true,
    super.order = 0,
  });

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) {
    return SocialLinkModel(
      id: json['id'] as int? ?? 0,
      platform: json['platform'] as String? ?? '',
      url: json['url'] as String? ?? '',
      icon: json['icon'] as String? ?? 'globe',
      isActive: json['is_active'] as bool? ?? true,
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platform': platform,
      'url': url,
      'icon': icon,
      'is_active': isActive,
      'order': order,
    };
  }
}
