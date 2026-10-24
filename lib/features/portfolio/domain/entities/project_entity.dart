import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String description;
  final String shortDescription;
  final String techStack;
  final String imageUrl;
  final String githubUrl;
  final String liveUrl;
  final String playStoreUrl;
  final String category;
  final bool isFeatured;
  final int order;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.shortDescription,
    required this.techStack,
    required this.imageUrl,
    required this.githubUrl,
    required this.liveUrl,
    required this.playStoreUrl,
    required this.category,
    required this.isFeatured,
    required this.order,
  });

  List<String> get techStackList {
    if (techStack.isEmpty) return [];
    return techStack.split(',').map((e) => e.trim()).toList();
  }

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    description,
    shortDescription,
    techStack,
    imageUrl,
    githubUrl,
    liveUrl,
    playStoreUrl,
    category,
    isFeatured,
    order,
  ];
}
