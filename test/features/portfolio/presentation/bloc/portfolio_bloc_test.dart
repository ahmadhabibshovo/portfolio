import 'package:flutter_test/flutter_test.dart';
import 'package:ahmadhabibshovo/core/error/failures.dart';
import 'package:ahmadhabibshovo/core/utils/either.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/book_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/experience_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/highlight_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/profile_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/project_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/skill_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/social_link_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_books_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_experiences_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_highlights_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_profile_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_projects_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_skills_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_social_links_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/send_contact_message_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:ahmadhabibshovo/features/portfolio/presentation/bloc/portfolio_event.dart';
import 'package:ahmadhabibshovo/features/portfolio/presentation/bloc/portfolio_state.dart';

class MockPortfolioRepository implements PortfolioRepository {
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    return const Right(
      ProfileEntity(
        id: 1,
        name: 'Ahmad Habib',
        headline: 'Mobile App Developer',
        bio: 'Passionate developer from Bangladesh',
        email: 'ahmadhabibshovo@gmail.com',
        phone: '+8801700000000',
        location: 'Bangladesh',
        avatarUrl: '',
        cvUrl: '',
        github: '',
        linkedin: '',
        facebook: '',
        leetcode: '',
        hackerearth: '',
        website: '',
      ),
    );
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects({
    String? category,
    bool? featured,
  }) async {
    return const Right([
      ProjectEntity(
        id: 1,
        title: 'Flutter App',
        slug: 'flutter-app',
        description: 'Clean Architecture App',
        shortDescription: 'App',
        techStack: 'Flutter, Dart',
        imageUrl: '',
        githubUrl: '',
        liveUrl: '',
        playStoreUrl: '',
        category: 'Mobile',
        isFeatured: true,
        order: 1,
      ),
      ProjectEntity(
        id: 2,
        title: 'Web App',
        slug: 'web-app',
        description: 'Web Application',
        shortDescription: 'Web',
        techStack: 'React, Go',
        imageUrl: '',
        githubUrl: '',
        liveUrl: '',
        playStoreUrl: '',
        category: 'Web',
        isFeatured: false,
        order: 2,
      ),
    ]);
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(dynamic id) async {
    return const Right(
      ProjectEntity(
        id: 1,
        title: 'Flutter App',
        slug: 'flutter-app',
        description: 'Clean Architecture App',
        shortDescription: 'App',
        techStack: 'Flutter, Dart',
        imageUrl: '',
        githubUrl: '',
        liveUrl: '',
        playStoreUrl: '',
        category: 'Mobile',
        isFeatured: true,
        order: 1,
      ),
    );
  }

  @override
  Future<Either<Failure, List<SkillEntity>>> getSkills({
    String? category,
  }) async {
    return const Right([
      SkillEntity(
        id: 1,
        name: 'Flutter',
        category: 'Mobile App',
        iconUrl: '',
        proficiency: 90,
        order: 1,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<ExperienceEntity>>> getExperiences() async {
    return const Right([
      ExperienceEntity(
        id: 1,
        role: 'Mobile Developer',
        company: 'Independent',
        location: 'Dhaka',
        startDate: '2023',
        endDate: 'Present',
        isCurrent: true,
        description: 'Building apps',
        order: 1,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<SocialLinkEntity>>> getSocialLinks() async {
    return const Right([
      SocialLinkEntity(
        id: 1,
        platform: 'GitHub',
        url: 'https://github.com',
        icon: 'github',
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    return const Right([
      BookEntity(
        id: 1,
        title: 'Clean Architecture',
        author: 'Uncle Bob',
        coverUrl: '',
        linkUrl: '',
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<HighlightEntity>>> getHighlights() async {
    return const Right([
      HighlightEntity(
        id: 1,
        title: 'Clean Architecture',
        description: 'Separation of concerns',
        icon: 'architecture',
      ),
    ]);
  }

  @override
  Future<Either<Failure, String>> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    return const Right('Message sent successfully!');
  }
}

void main() {
  late PortfolioBloc bloc;
  late MockPortfolioRepository repo;

  setUp(() {
    repo = MockPortfolioRepository();
    bloc = PortfolioBloc(
      getProfileUseCase: GetProfileUseCase(repo),
      getProjectsUseCase: GetProjectsUseCase(repo),
      getSkillsUseCase: GetSkillsUseCase(repo),
      getExperiencesUseCase: GetExperiencesUseCase(repo),
      getSocialLinksUseCase: GetSocialLinksUseCase(repo),
      getBooksUseCase: GetBooksUseCase(repo),
      getHighlightsUseCase: GetHighlightsUseCase(repo),
      sendContactMessageUseCase: SendContactMessageUseCase(repo),
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be PortfolioLoaded with instant data', () {
    expect(bloc.state, isA<PortfolioLoaded>());
    expect((bloc.state as PortfolioLoaded).profile.name, equals('Ahmad Habib'));
  });

  test('FetchPortfolioDataEvent should emit PortfolioLoaded with syncing and fresh data', () async {
    final expectedStates = [isA<PortfolioLoaded>()];

    expectLater(bloc.stream, emitsInOrder(expectedStates));

    bloc.add(const FetchPortfolioDataEvent());
  });

  test(
    'FilterProjectsByCategoryEvent should filter projects in loaded state',
    () async {
      bloc.add(const FetchPortfolioDataEvent());
      await Future.delayed(const Duration(milliseconds: 100));

      expect(bloc.state, isA<PortfolioLoaded>());
      final loadedState = bloc.state as PortfolioLoaded;
      expect(loadedState.filteredProjects.length, 2);

      bloc.add(const FilterProjectsByCategoryEvent('Mobile'));
      await Future.delayed(const Duration(milliseconds: 50));

      final filteredState = bloc.state as PortfolioLoaded;
      expect(filteredState.selectedCategory, 'Mobile');
      expect(filteredState.filteredProjects.length, 1);
      expect(filteredState.filteredProjects.first.category, 'Mobile');
    },
  );

  test(
    'SubmitContactMessageEvent should emit submitting and success',
    () async {
      bloc.add(const FetchPortfolioDataEvent());
      await Future.delayed(const Duration(milliseconds: 100));

      bloc.add(
        const SubmitContactMessageEvent(
          name: 'John',
          email: 'john@example.com',
          subject: 'Inquiry',
          message: 'Hello',
        ),
      );

      await Future.delayed(const Duration(milliseconds: 100));

      final state = bloc.state as PortfolioLoaded;
      expect(state.contactStatus, ContactSubmissionStatus.success);
      expect(state.contactFeedback, 'Message sent successfully!');
    },
  );
}
