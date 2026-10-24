import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final int id;
  final String role;
  final String company;
  final String location;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final String description;
  final int order;

  const ExperienceEntity({
    required this.id,
    required this.role,
    required this.company,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.description,
    required this.order,
  });

  @override
  List<Object?> get props => [
    id,
    role,
    company,
    location,
    startDate,
    endDate,
    isCurrent,
    description,
    order,
  ];
}
