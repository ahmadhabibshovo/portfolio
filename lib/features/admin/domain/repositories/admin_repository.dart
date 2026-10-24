import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../portfolio/domain/entities/book_entity.dart';
import '../../../portfolio/domain/entities/experience_entity.dart';
import '../../../portfolio/domain/entities/highlight_entity.dart';
import '../../../portfolio/domain/entities/profile_entity.dart';
import '../../../portfolio/domain/entities/project_entity.dart';
import '../../../portfolio/domain/entities/skill_entity.dart';
import '../../../portfolio/domain/entities/social_link_entity.dart';
import '../entities/contact_message_entity.dart';

abstract class AdminRepository {
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity profile);

  Future<Either<Failure, ProjectEntity>> createProject(ProjectEntity project);
  Future<Either<Failure, ProjectEntity>> updateProject(ProjectEntity project);
  Future<Either<Failure, void>> deleteProject(int id);

  Future<Either<Failure, SkillEntity>> createSkill(SkillEntity skill);
  Future<Either<Failure, SkillEntity>> updateSkill(SkillEntity skill);
  Future<Either<Failure, void>> deleteSkill(int id);

  Future<Either<Failure, ExperienceEntity>> createExperience(
    ExperienceEntity experience,
  );
  Future<Either<Failure, ExperienceEntity>> updateExperience(
    ExperienceEntity experience,
  );
  Future<Either<Failure, void>> deleteExperience(int id);

  Future<Either<Failure, List<ContactMessageEntity>>> getMessages({
    bool? unreadOnly,
  });
  Future<Either<Failure, void>> markMessageRead(int id, bool isRead);
  Future<Either<Failure, void>> deleteMessage(int id);

  Future<Either<Failure, List<SocialLinkEntity>>> getSocialLinks();
  Future<Either<Failure, SocialLinkEntity>> createSocialLink(
    SocialLinkEntity link,
  );
  Future<Either<Failure, SocialLinkEntity>> updateSocialLink(
    SocialLinkEntity link,
  );
  Future<Either<Failure, void>> deleteSocialLink(int id);

  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, BookEntity>> createBook(BookEntity book);
  Future<Either<Failure, BookEntity>> updateBook(BookEntity book);
  Future<Either<Failure, void>> deleteBook(int id);

  Future<Either<Failure, List<HighlightEntity>>> getHighlights();
  Future<Either<Failure, HighlightEntity>> createHighlight(
    HighlightEntity highlight,
  );
  Future<Either<Failure, HighlightEntity>> updateHighlight(
    HighlightEntity highlight,
  );
  Future<Either<Failure, void>> deleteHighlight(int id);

  Future<Either<Failure, String>> uploadFile(
    List<int> fileBytes,
    String fileName,
  );
}
