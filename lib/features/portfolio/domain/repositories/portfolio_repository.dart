import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/book_entity.dart';
import '../entities/experience_entity.dart';
import '../entities/highlight_entity.dart';
import '../entities/profile_entity.dart';
import '../entities/project_entity.dart';
import '../entities/skill_entity.dart';
import '../entities/social_link_entity.dart';

abstract class PortfolioRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, List<ProjectEntity>>> getProjects({
    String? category,
    bool? featured,
  });

  Future<Either<Failure, ProjectEntity>> getProjectById(String idOrSlug);

  Future<Either<Failure, List<SkillEntity>>> getSkills({String? category});

  Future<Either<Failure, List<ExperienceEntity>>> getExperiences();

  Future<Either<Failure, List<SocialLinkEntity>>> getSocialLinks();

  Future<Either<Failure, List<BookEntity>>> getBooks();

  Future<Either<Failure, List<HighlightEntity>>> getHighlights();

  Future<Either<Failure, String>> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  });
}
