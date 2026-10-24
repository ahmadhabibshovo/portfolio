import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../portfolio/data/models/book_model.dart';
import '../../../portfolio/data/models/experience_model.dart';
import '../../../portfolio/data/models/highlight_model.dart';
import '../../../portfolio/data/models/profile_model.dart';
import '../../../portfolio/data/models/project_model.dart';
import '../../../portfolio/data/models/skill_model.dart';
import '../../../portfolio/data/models/social_link_model.dart';
import '../../../portfolio/domain/entities/book_entity.dart';
import '../../../portfolio/domain/entities/experience_entity.dart';
import '../../../portfolio/domain/entities/highlight_entity.dart';
import '../../../portfolio/domain/entities/profile_entity.dart';
import '../../../portfolio/domain/entities/project_entity.dart';
import '../../../portfolio/domain/entities/skill_entity.dart';
import '../../../portfolio/domain/entities/social_link_entity.dart';
import '../../domain/entities/contact_message_entity.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_data_source.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
    ProfileEntity profile,
  ) async {
    try {
      final model = ProfileModel(
        id: profile.id,
        name: profile.name,
        headline: profile.headline,
        bio: profile.bio,
        email: profile.email,
        phone: profile.phone,
        location: profile.location,
        avatarUrl: profile.avatarUrl,
        cvUrl: profile.cvUrl,
        github: profile.github,
        linkedin: profile.linkedin,
        facebook: profile.facebook,
        leetcode: profile.leetcode,
        hackerearth: profile.hackerearth,
        website: profile.website,
        isAvailable: profile.isAvailable,
        availabilityStatus: profile.availabilityStatus,
      );
      final res = await remoteDataSource.updateProfile(model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> createProject(
    ProjectEntity project,
  ) async {
    try {
      final model = ProjectModel(
        id: 0,
        title: project.title,
        slug: project.slug,
        description: project.description,
        shortDescription: project.shortDescription,
        techStack: project.techStack,
        imageUrl: project.imageUrl,
        githubUrl: project.githubUrl,
        liveUrl: project.liveUrl,
        playStoreUrl: project.playStoreUrl,
        category: project.category,
        isFeatured: project.isFeatured,
        order: project.order,
      );
      final res = await remoteDataSource.createProject(model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> updateProject(
    ProjectEntity project,
  ) async {
    try {
      final model = ProjectModel(
        id: project.id,
        title: project.title,
        slug: project.slug,
        description: project.description,
        shortDescription: project.shortDescription,
        techStack: project.techStack,
        imageUrl: project.imageUrl,
        githubUrl: project.githubUrl,
        liveUrl: project.liveUrl,
        playStoreUrl: project.playStoreUrl,
        category: project.category,
        isFeatured: project.isFeatured,
        order: project.order,
      );
      final res = await remoteDataSource.updateProject(
        project.id,
        model.toJson(),
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(int id) async {
    try {
      await remoteDataSource.deleteProject(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SkillEntity>> createSkill(SkillEntity skill) async {
    try {
      final model = SkillModel(
        id: 0,
        name: skill.name,
        category: skill.category,
        iconUrl: skill.iconUrl,
        proficiency: skill.proficiency,
        order: skill.order,
      );
      final res = await remoteDataSource.createSkill(model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SkillEntity>> updateSkill(SkillEntity skill) async {
    try {
      final model = SkillModel(
        id: skill.id,
        name: skill.name,
        category: skill.category,
        iconUrl: skill.iconUrl,
        proficiency: skill.proficiency,
        order: skill.order,
      );
      final res = await remoteDataSource.updateSkill(skill.id, model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSkill(int id) async {
    try {
      await remoteDataSource.deleteSkill(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExperienceEntity>> createExperience(
    ExperienceEntity experience,
  ) async {
    try {
      final model = ExperienceModel(
        id: 0,
        role: experience.role,
        company: experience.company,
        location: experience.location,
        startDate: experience.startDate,
        endDate: experience.endDate,
        isCurrent: experience.isCurrent,
        description: experience.description,
        order: experience.order,
      );
      final res = await remoteDataSource.createExperience(model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExperienceEntity>> updateExperience(
    ExperienceEntity experience,
  ) async {
    try {
      final model = ExperienceModel(
        id: experience.id,
        role: experience.role,
        company: experience.company,
        location: experience.location,
        startDate: experience.startDate,
        endDate: experience.endDate,
        isCurrent: experience.isCurrent,
        description: experience.description,
        order: experience.order,
      );
      final res = await remoteDataSource.updateExperience(
        experience.id,
        model.toJson(),
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExperience(int id) async {
    try {
      await remoteDataSource.deleteExperience(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ContactMessageEntity>>> getMessages({
    bool? unreadOnly,
  }) async {
    try {
      final msgs = await remoteDataSource.getMessages(unreadOnly: unreadOnly);
      return Right(msgs);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageRead(int id, bool isRead) async {
    try {
      await remoteDataSource.markMessageRead(id, isRead);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(int id) async {
    try {
      await remoteDataSource.deleteMessage(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile(
    List<int> fileBytes,
    String fileName,
  ) async {
    try {
      final url = await remoteDataSource.uploadFile(fileBytes, fileName);
      return Right(url);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Social Links
  @override
  Future<Either<Failure, List<SocialLinkEntity>>> getSocialLinks() async {
    try {
      final links = await remoteDataSource.getSocialLinks();
      return Right(links);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SocialLinkEntity>> createSocialLink(
    SocialLinkEntity link,
  ) async {
    try {
      final model = SocialLinkModel(
        id: 0,
        platform: link.platform,
        url: link.url,
        icon: link.icon,
        isActive: link.isActive,
        order: link.order,
      );
      final res = await remoteDataSource.createSocialLink(model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SocialLinkEntity>> updateSocialLink(
    SocialLinkEntity link,
  ) async {
    try {
      final model = SocialLinkModel(
        id: link.id,
        platform: link.platform,
        url: link.url,
        icon: link.icon,
        isActive: link.isActive,
        order: link.order,
      );
      final res = await remoteDataSource.updateSocialLink(
        link.id,
        model.toJson(),
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSocialLink(int id) async {
    try {
      await remoteDataSource.deleteSocialLink(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Books
  @override
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    try {
      final books = await remoteDataSource.getBooks();
      return Right(books);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookEntity>> createBook(BookEntity book) async {
    try {
      final model = BookModel(
        id: 0,
        title: book.title,
        author: book.author,
        coverUrl: book.coverUrl,
        linkUrl: book.linkUrl,
        status: book.status,
        rating: book.rating,
        review: book.review,
        order: book.order,
      );
      final res = await remoteDataSource.createBook(model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookEntity>> updateBook(BookEntity book) async {
    try {
      final model = BookModel(
        id: book.id,
        title: book.title,
        author: book.author,
        coverUrl: book.coverUrl,
        linkUrl: book.linkUrl,
        status: book.status,
        rating: book.rating,
        review: book.review,
        order: book.order,
      );
      final res = await remoteDataSource.updateBook(book.id, model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBook(int id) async {
    try {
      await remoteDataSource.deleteBook(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Highlights
  @override
  Future<Either<Failure, List<HighlightEntity>>> getHighlights() async {
    try {
      final highlights = await remoteDataSource.getHighlights();
      return Right(highlights);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HighlightEntity>> createHighlight(
    HighlightEntity highlight,
  ) async {
    try {
      final model = HighlightModel(
        id: 0,
        title: highlight.title,
        description: highlight.description,
        icon: highlight.icon,
        colorTag: highlight.colorTag,
        order: highlight.order,
      );
      final res = await remoteDataSource.createHighlight(model.toJson());
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HighlightEntity>> updateHighlight(
    HighlightEntity highlight,
  ) async {
    try {
      final model = HighlightModel(
        id: highlight.id,
        title: highlight.title,
        description: highlight.description,
        icon: highlight.icon,
        colorTag: highlight.colorTag,
        order: highlight.order,
      );
      final res = await remoteDataSource.updateHighlight(
        highlight.id,
        model.toJson(),
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHighlight(int id) async {
    try {
      await remoteDataSource.deleteHighlight(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
