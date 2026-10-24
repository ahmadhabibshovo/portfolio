import 'package:equatable/equatable.dart';

class HighlightEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String icon;
  final String colorTag;
  final int order;

  const HighlightEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.colorTag = 'primary',
    this.order = 0,
  });

  @override
  List<Object?> get props => [id, title, description, icon, colorTag, order];
}
