import 'package:equatable/equatable.dart';

import '../../data/datasources/portfolio_initial_data.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/highlight_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/social_link_entity.dart';

enum ContactSubmissionStatus { initial, submitting, success, failure }

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final ProfileEntity profile;
  final List<ProjectEntity> allProjects;
  final List<ProjectEntity> filteredProjects;
  final List<SkillEntity> skills;
  final List<ExperienceEntity> experiences;
  final List<SocialLinkEntity> socialLinks;
  final List<BookEntity> books;
  final List<HighlightEntity> highlights;
  final String selectedCategory;
  final ContactSubmissionStatus contactStatus;
  final String? contactFeedback;
  final bool isSyncing;

  const PortfolioLoaded({
    required this.profile,
    required this.allProjects,
    required this.filteredProjects,
    required this.skills,
    required this.experiences,
    this.socialLinks = const [],
    this.books = const [],
    this.highlights = const [],
    this.selectedCategory = 'All',
    this.contactStatus = ContactSubmissionStatus.initial,
    this.contactFeedback,
    this.isSyncing = false,
  });

  /// Factory for Instant 0ms Load with pre-seeded data
  factory PortfolioLoaded.initial({bool isSyncing = false}) {
    final projects = PortfolioInitialData.defaultProjects;
    return PortfolioLoaded(
      profile: PortfolioInitialData.defaultProfile,
      allProjects: projects,
      filteredProjects: projects,
      skills: PortfolioInitialData.defaultSkills,
      experiences: PortfolioInitialData.defaultExperiences,
      socialLinks: PortfolioInitialData.defaultSocialLinks,
      books: PortfolioInitialData.defaultBooks,
      highlights: PortfolioInitialData.defaultHighlights,
      isSyncing: isSyncing,
    );
  }

  PortfolioLoaded copyWith({
    ProfileEntity? profile,
    List<ProjectEntity>? allProjects,
    List<ProjectEntity>? filteredProjects,
    List<SkillEntity>? skills,
    List<ExperienceEntity>? experiences,
    List<SocialLinkEntity>? socialLinks,
    List<BookEntity>? books,
    List<HighlightEntity>? highlights,
    String? selectedCategory,
    ContactSubmissionStatus? contactStatus,
    String? contactFeedback,
    bool? isSyncing,
  }) {
    return PortfolioLoaded(
      profile: profile ?? this.profile,
      allProjects: allProjects ?? this.allProjects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      skills: skills ?? this.skills,
      experiences: experiences ?? this.experiences,
      socialLinks: socialLinks ?? this.socialLinks,
      books: books ?? this.books,
      highlights: highlights ?? this.highlights,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      contactStatus: contactStatus ?? this.contactStatus,
      contactFeedback: contactFeedback,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }

  @override
  List<Object?> get props => [
        profile,
        allProjects,
        filteredProjects,
        skills,
        experiences,
        socialLinks,
        books,
        highlights,
        selectedCategory,
        contactStatus,
        contactFeedback,
        isSyncing,
      ];
}

class PortfolioError extends PortfolioState {
  final String message;
  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}
