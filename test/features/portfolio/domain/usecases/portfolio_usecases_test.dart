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
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_profile_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/get_projects_usecase.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/usecases/send_contact_message_usecase.dart';

class FakePortfolioRepository implements PortfolioRepository {
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    return const Right(
      ProfileEntity(
        id: 1,
        name: 'Ahmad Habib',
        headline: 'Mobile App Developer',
        bio: 'Passionate developer',
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
        description: 'Test app',
        shortDescription: 'Test',
        techStack: 'Flutter',
        imageUrl: '',
        githubUrl: '',
        liveUrl: '',
        playStoreUrl: '',
        category: 'Mobile',
        isFeatured: true,
        order: 1,
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
        description: 'Test app',
        shortDescription: 'Test',
        techStack: 'Flutter',
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
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<ExperienceEntity>>> getExperiences() async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<SocialLinkEntity>>> getSocialLinks() async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<HighlightEntity>>> getHighlights() async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, String>> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    return const Right('Message sent successfully');
  }
}

void main() {
  late FakePortfolioRepository repo;

  setUp(() {
    repo = FakePortfolioRepository();
  });

  test('GetProfileUseCase should return ProfileEntity', () async {
    final useCase = GetProfileUseCase(repo);
    final result = await useCase();

    expect(result.isRight, true);
    result.fold(
      (failure) => fail('Should not fail'),
      (profile) => expect(profile.name, 'Ahmad Habib'),
    );
  });

  test('GetProjectsUseCase should return projects list', () async {
    final useCase = GetProjectsUseCase(repo);
    final result = await useCase();

    expect(result.isRight, true);
    result.fold(
      (failure) => fail('Should not fail'),
      (projects) => expect(projects.length, 1),
    );
  });

  test('SendContactMessageUseCase should return success message', () async {
    final useCase = SendContactMessageUseCase(repo);
    final result = await useCase(
      name: 'John',
      email: 'john@example.com',
      subject: 'Inquiry',
      message: 'Hello',
    );

    expect(result.isRight, true);
    result.fold(
      (failure) => fail('Should not fail'),
      (msg) => expect(msg, 'Message sent successfully'),
    );
  });
}
