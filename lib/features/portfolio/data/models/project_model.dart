import '../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.description,
    required super.shortDescription,
    required super.techStack,
    required super.imageUrl,
    required super.githubUrl,
    required super.liveUrl,
    required super.playStoreUrl,
    required super.category,
    required super.isFeatured,
    required super.order,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
      shortDescription: json['short_description'] as String? ?? '',
      techStack: json['tech_stack'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      githubUrl: json['github_url'] as String? ?? '',
      liveUrl: json['live_url'] as String? ?? '',
      playStoreUrl: json['play_store_url'] as String? ?? '',
      category: json['category'] as String? ?? 'Mobile',
      isFeatured: json['is_featured'] as bool? ?? false,
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'short_description': shortDescription,
      'tech_stack': techStack,
      'image_url': imageUrl,
      'github_url': githubUrl,
      'live_url': liveUrl,
      'play_store_url': playStoreUrl,
      'category': category,
      'is_featured': isFeatured,
      'order': order,
    };
  }
}
