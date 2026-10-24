import 'package:flutter_test/flutter_test.dart';
import 'package:ahmadhabibshovo/core/error/failures.dart';
import 'package:ahmadhabibshovo/core/utils/either.dart';
import 'package:ahmadhabibshovo/features/admin/domain/entities/contact_message_entity.dart';
import 'package:ahmadhabibshovo/features/admin/domain/repositories/admin_repository.dart';
import 'package:ahmadhabibshovo/features/admin/domain/usecases/admin_usecases.dart';
import 'package:ahmadhabibshovo/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:ahmadhabibshovo/features/admin/presentation/bloc/admin_event.dart';
import 'package:ahmadhabibshovo/features/admin/presentation/bloc/admin_state.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/book_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/experience_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/highlight_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/profile_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/project_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/skill_entity.dart';
import 'package:ahmadhabibshovo/features/portfolio/domain/entities/social_link_entity.dart';

class FakeAdminRepository implements AdminRepository {
  bool shouldFail = false;

  final testProfile = const ProfileEntity(
    id: 1,
    name: 'Ahmad Habib',
    headline: 'Senior Flutter Engineer',
    bio: 'Software engineer',
    email: 'ahmadhabibshovo@gmail.com',
    phone: '+8801700000000',
    location: 'Dhaka',
    avatarUrl: '',
    cvUrl: '',
    github: '',
    linkedin: '',
    facebook: '',
    leetcode: '',
    hackerearth: '',
    website: '',
  );

  final testProject = const ProjectEntity(
    id: 1,
    title: 'New Project',
    slug: 'new-project',
    description: 'Description',
    shortDescription: 'Short',
    techStack: 'Flutter',
    imageUrl: '',
    githubUrl: '',
    liveUrl: '',
    playStoreUrl: '',
    category: 'Mobile',
    isFeatured: true,
    order: 1,
  );

  final testSkill = const SkillEntity(
    id: 1,
    name: 'Go',
    category: 'Backend',
    iconUrl: '',
    proficiency: 95,
    order: 1,
  );

  final testExperience = const ExperienceEntity(
    id: 1,
    role: 'Lead Architect',
    company: 'Tech Corp',
    location: 'Remote',
    startDate: '2022',
    endDate: '2024',
    isCurrent: false,
    description: 'Architecture',
    order: 1,
  );

  final testMessage = const ContactMessageEntity(
    id: 1,
    name: 'Client',
    email: 'client@example.com',
    subject: 'Hire',
    message: 'We want to hire you',
    isRead: false,
    createdAt: '2026-01-01',
  );

  final testSocialLink = const SocialLinkEntity(
    id: 1,
    platform: 'HackerRank',
    url: 'https://hackerrank.com',
    icon: 'hackerrank',
  );

  final testBook = const BookEntity(
    id: 1,
    title: 'Clean Architecture',
    author: 'Uncle Bob',
    coverUrl: '',
    linkUrl: '',
  );

  final testHighlight = const HighlightEntity(
    id: 1,
    title: 'Clean Architecture',
    description: 'Clean separation',
    icon: 'architecture',
  );

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
    ProfileEntity profile,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Profile update error'));
    return Right(profile);
  }

  @override
  Future<Either<Failure, ProjectEntity>> createProject(
    ProjectEntity project,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Create project error'));
    return Right(project);
  }

  @override
  Future<Either<Failure, ProjectEntity>> updateProject(
    ProjectEntity project,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Update project error'));
    return Right(project);
  }

  @override
  Future<Either<Failure, void>> deleteProject(int id) async {
    if (shouldFail) return const Left(ServerFailure('Delete project error'));
    return const Right(null);
  }

  @override
  Future<Either<Failure, SkillEntity>> createSkill(SkillEntity skill) async {
    if (shouldFail) return const Left(ServerFailure('Create skill error'));
    return Right(skill);
  }

  @override
  Future<Either<Failure, SkillEntity>> updateSkill(SkillEntity skill) async {
    if (shouldFail) return const Left(ServerFailure('Update skill error'));
    return Right(skill);
  }

  @override
  Future<Either<Failure, void>> deleteSkill(int id) async {
    if (shouldFail) return const Left(ServerFailure('Delete skill error'));
    return const Right(null);
  }

  @override
  Future<Either<Failure, ExperienceEntity>> createExperience(
    ExperienceEntity experience,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Create experience error'));
    return Right(experience);
  }

  @override
  Future<Either<Failure, ExperienceEntity>> updateExperience(
    ExperienceEntity experience,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Update experience error'));
    return Right(experience);
  }

  @override
  Future<Either<Failure, void>> deleteExperience(int id) async {
    if (shouldFail) return const Left(ServerFailure('Delete experience error'));
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<ContactMessageEntity>>> getMessages({
    bool? unreadOnly,
  }) async {
    if (shouldFail) return const Left(ServerFailure('Get messages error'));
    return Right([testMessage]);
  }

  @override
  Future<Either<Failure, void>> markMessageRead(int id, bool isRead) async {
    if (shouldFail) return const Left(ServerFailure('Mark read error'));
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteMessage(int id) async {
    if (shouldFail) return const Left(ServerFailure('Delete message error'));
    return const Right(null);
  }

  @override
  Future<Either<Failure, String>> uploadFile(
    List<int> fileBytes,
    String fileName,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Upload error'));
    return const Right('http://localhost:8080/uploads/file.png');
  }

  // Social Links
  @override
  Future<Either<Failure, List<SocialLinkEntity>>> getSocialLinks() async {
    if (shouldFail) return const Left(ServerFailure('Get links error'));
    return Right([testSocialLink]);
  }

  @override
  Future<Either<Failure, SocialLinkEntity>> createSocialLink(
    SocialLinkEntity link,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Create link error'));
    return Right(link);
  }

  @override
  Future<Either<Failure, SocialLinkEntity>> updateSocialLink(
    SocialLinkEntity link,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Update link error'));
    return Right(link);
  }

  @override
  Future<Either<Failure, void>> deleteSocialLink(int id) async {
    if (shouldFail) return const Left(ServerFailure('Delete link error'));
    return const Right(null);
  }

  // Books
  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    if (shouldFail) return const Left(ServerFailure('Get books error'));
    return Right([testBook]);
  }

  @override
  Future<Either<Failure, BookEntity>> createBook(BookEntity book) async {
    if (shouldFail) return const Left(ServerFailure('Create book error'));
    return Right(book);
  }

  @override
  Future<Either<Failure, BookEntity>> updateBook(BookEntity book) async {
    if (shouldFail) return const Left(ServerFailure('Update book error'));
    return Right(book);
  }

  @override
  Future<Either<Failure, void>> deleteBook(int id) async {
    if (shouldFail) return const Left(ServerFailure('Delete book error'));
    return const Right(null);
  }

  // Highlights
  @override
  Future<Either<Failure, List<HighlightEntity>>> getHighlights() async {
    if (shouldFail) return const Left(ServerFailure('Get highlights error'));
    return Right([testHighlight]);
  }

  @override
  Future<Either<Failure, HighlightEntity>> createHighlight(
    HighlightEntity highlight,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Create highlight error'));
    return Right(highlight);
  }

  @override
  Future<Either<Failure, HighlightEntity>> updateHighlight(
    HighlightEntity highlight,
  ) async {
    if (shouldFail) return const Left(ServerFailure('Update highlight error'));
    return Right(highlight);
  }

  @override
  Future<Either<Failure, void>> deleteHighlight(int id) async {
    if (shouldFail) return const Left(ServerFailure('Delete highlight error'));
    return const Right(null);
  }
}

void main() {
  late FakeAdminRepository repo;
  late AdminBloc bloc;

  setUp(() {
    repo = FakeAdminRepository();
    bloc = AdminBloc(
      updateProfileUseCase: UpdateProfileAdminUseCase(repo),
      createProjectUseCase: CreateProjectAdminUseCase(repo),
      updateProjectUseCase: UpdateProjectAdminUseCase(repo),
      deleteProjectUseCase: DeleteProjectAdminUseCase(repo),
      createSkillUseCase: CreateSkillAdminUseCase(repo),
      updateSkillUseCase: UpdateSkillAdminUseCase(repo),
      deleteSkillUseCase: DeleteSkillAdminUseCase(repo),
      createExperienceUseCase: CreateExperienceAdminUseCase(repo),
      updateExperienceUseCase: UpdateExperienceAdminUseCase(repo),
      deleteExperienceUseCase: DeleteExperienceAdminUseCase(repo),
      getAdminMessagesUseCase: GetAdminMessagesUseCase(repo),
      markAdminMessageReadUseCase: MarkAdminMessageReadUseCase(repo),
      deleteAdminMessageUseCase: DeleteAdminMessageUseCase(repo),
      uploadFileUseCase: UploadFileUseCase(repo),
      getSocialLinksUseCase: GetAdminSocialLinksUseCase(repo),
      createSocialLinkUseCase: CreateSocialLinkUseCase(repo),
      updateSocialLinkUseCase: UpdateSocialLinkUseCase(repo),
      deleteSocialLinkUseCase: DeleteSocialLinkUseCase(repo),
      getBooksUseCase: GetAdminBooksUseCase(repo),
      createBookUseCase: CreateBookUseCase(repo),
      updateBookUseCase: UpdateBookUseCase(repo),
      deleteBookUseCase: DeleteBookUseCase(repo),
      getHighlightsUseCase: GetAdminHighlightsUseCase(repo),
      createHighlightUseCase: CreateHighlightUseCase(repo),
      updateHighlightUseCase: UpdateHighlightUseCase(repo),
      deleteHighlightUseCase: DeleteHighlightUseCase(repo),
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('Initial state is AdminInitialState', () {
    expect(bloc.state, equals(AdminInitialState()));
  });

  test('LoadAdminDataEvent emits AdminLoadingState and AdminLoadedState with messages and dynamic data', () async {
    expectLater(
      bloc.stream,
      emitsInOrder([isA<AdminLoadingState>(), isA<AdminLoadedState>()]),
    );

    bloc.add(LoadAdminDataEvent());
  });

  test('CreateProjectEvent updates feedbackMessage in loaded state', () async {
    bloc.add(LoadAdminDataEvent());
    await Future.delayed(const Duration(milliseconds: 50));

    bloc.add(CreateProjectEvent(repo.testProject));
    await Future.delayed(const Duration(milliseconds: 50));

    expect(bloc.state, isA<AdminLoadedState>());
    final loaded = bloc.state as AdminLoadedState;
    expect(loaded.feedbackMessage, 'Project created successfully!');
  });

  test('DeleteProjectEvent updates feedbackMessage in loaded state', () async {
    bloc.add(LoadAdminDataEvent());
    await Future.delayed(const Duration(milliseconds: 50));

    bloc.add(const DeleteProjectEvent(1));
    await Future.delayed(const Duration(milliseconds: 50));

    expect(bloc.state, isA<AdminLoadedState>());
    final loaded = bloc.state as AdminLoadedState;
    expect(loaded.feedbackMessage, 'Project deleted successfully!');
  });

  test('UploadFileEvent emits AdminLoadedState with uploaded url', () async {
    bloc.add(LoadAdminDataEvent());
    await Future.delayed(const Duration(milliseconds: 50));

    bloc.add(const UploadFileEvent([1, 2, 3], 'avatar.png'));
    await Future.delayed(const Duration(milliseconds: 50));

    expect(bloc.state, isA<AdminLoadedState>());
    final loaded = bloc.state as AdminLoadedState;
    expect(loaded.uploadedFileUrl, 'http://localhost:8080/uploads/file.png');
  });

  test('Error state emitted when repository fails', () async {
    repo.shouldFail = true;

    expectLater(
      bloc.stream,
      emitsInOrder([isA<AdminLoadingState>(), isA<AdminFailureState>()]),
    );

    bloc.add(LoadAdminDataEvent());
  });
}
