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
import '../repositories/admin_repository.dart';

class UpdateProfileAdminUseCase {
  final AdminRepository repository;
  const UpdateProfileAdminUseCase(this.repository);
  Future<Either<Failure, ProfileEntity>> call(ProfileEntity profile) =>
      repository.updateProfile(profile);
}

class CreateProjectAdminUseCase {
  final AdminRepository repository;
  const CreateProjectAdminUseCase(this.repository);
  Future<Either<Failure, ProjectEntity>> call(ProjectEntity project) =>
      repository.createProject(project);
}

class UpdateProjectAdminUseCase {
  final AdminRepository repository;
  const UpdateProjectAdminUseCase(this.repository);
  Future<Either<Failure, ProjectEntity>> call(ProjectEntity project) =>
      repository.updateProject(project);
}

class DeleteProjectAdminUseCase {
  final AdminRepository repository;
  const DeleteProjectAdminUseCase(this.repository);
  Future<Either<Failure, void>> call(int id) => repository.deleteProject(id);
}

class CreateSkillAdminUseCase {
  final AdminRepository repository;
  const CreateSkillAdminUseCase(this.repository);
  Future<Either<Failure, SkillEntity>> call(SkillEntity skill) =>
      repository.createSkill(skill);
}

class UpdateSkillAdminUseCase {
  final AdminRepository repository;
  const UpdateSkillAdminUseCase(this.repository);
  Future<Either<Failure, SkillEntity>> call(SkillEntity skill) =>
      repository.updateSkill(skill);
}

class DeleteSkillAdminUseCase {
  final AdminRepository repository;
  const DeleteSkillAdminUseCase(this.repository);
  Future<Either<Failure, void>> call(int id) => repository.deleteSkill(id);
}

class CreateExperienceAdminUseCase {
  final AdminRepository repository;
  const CreateExperienceAdminUseCase(this.repository);
  Future<Either<Failure, ExperienceEntity>> call(ExperienceEntity experience) =>
      repository.createExperience(experience);
}

class UpdateExperienceAdminUseCase {
  final AdminRepository repository;
  const UpdateExperienceAdminUseCase(this.repository);
  Future<Either<Failure, ExperienceEntity>> call(ExperienceEntity experience) =>
      repository.updateExperience(experience);
}

class DeleteExperienceAdminUseCase {
  final AdminRepository repository;
  const DeleteExperienceAdminUseCase(this.repository);
  Future<Either<Failure, void>> call(int id) => repository.deleteExperience(id);
}

class GetAdminMessagesUseCase {
  final AdminRepository repository;
  const GetAdminMessagesUseCase(this.repository);
  Future<Either<Failure, List<ContactMessageEntity>>> call({
    bool? unreadOnly,
  }) => repository.getMessages(unreadOnly: unreadOnly);
}

class MarkAdminMessageReadUseCase {
  final AdminRepository repository;
  const MarkAdminMessageReadUseCase(this.repository);
  Future<Either<Failure, void>> call(int id, bool isRead) =>
      repository.markMessageRead(id, isRead);
}

class DeleteAdminMessageUseCase {
  final AdminRepository repository;
  const DeleteAdminMessageUseCase(this.repository);
  Future<Either<Failure, void>> call(int id) => repository.deleteMessage(id);
}

class UploadFileUseCase {
  final AdminRepository repository;
  const UploadFileUseCase(this.repository);
  Future<Either<Failure, String>> call(List<int> fileBytes, String fileName) =>
      repository.uploadFile(fileBytes, fileName);
}

// Social Links Admin Use Cases
class GetAdminSocialLinksUseCase {
  final AdminRepository repository;
  const GetAdminSocialLinksUseCase(this.repository);
  Future<Either<Failure, List<SocialLinkEntity>>> call() =>
      repository.getSocialLinks();
}

class CreateSocialLinkUseCase {
  final AdminRepository repository;
  const CreateSocialLinkUseCase(this.repository);
  Future<Either<Failure, SocialLinkEntity>> call(SocialLinkEntity link) =>
      repository.createSocialLink(link);
}

class UpdateSocialLinkUseCase {
  final AdminRepository repository;
  const UpdateSocialLinkUseCase(this.repository);
  Future<Either<Failure, SocialLinkEntity>> call(SocialLinkEntity link) =>
      repository.updateSocialLink(link);
}

class DeleteSocialLinkUseCase {
  final AdminRepository repository;
  const DeleteSocialLinkUseCase(this.repository);
  Future<Either<Failure, void>> call(int id) => repository.deleteSocialLink(id);
}

// Books Admin Use Cases
class GetAdminBooksUseCase {
  final AdminRepository repository;
  const GetAdminBooksUseCase(this.repository);
  Future<Either<Failure, List<BookEntity>>> call() => repository.getBooks();
}

class CreateBookUseCase {
  final AdminRepository repository;
  const CreateBookUseCase(this.repository);
  Future<Either<Failure, BookEntity>> call(BookEntity book) =>
      repository.createBook(book);
}

class UpdateBookUseCase {
  final AdminRepository repository;
  const UpdateBookUseCase(this.repository);
  Future<Either<Failure, BookEntity>> call(BookEntity book) =>
      repository.updateBook(book);
}

class DeleteBookUseCase {
  final AdminRepository repository;
  const DeleteBookUseCase(this.repository);
  Future<Either<Failure, void>> call(int id) => repository.deleteBook(id);
}

// Highlights Admin Use Cases
class GetAdminHighlightsUseCase {
  final AdminRepository repository;
  const GetAdminHighlightsUseCase(this.repository);
  Future<Either<Failure, List<HighlightEntity>>> call() =>
      repository.getHighlights();
}

class CreateHighlightUseCase {
  final AdminRepository repository;
  const CreateHighlightUseCase(this.repository);
  Future<Either<Failure, HighlightEntity>> call(HighlightEntity highlight) =>
      repository.createHighlight(highlight);
}

class UpdateHighlightUseCase {
  final AdminRepository repository;
  const UpdateHighlightUseCase(this.repository);
  Future<Either<Failure, HighlightEntity>> call(HighlightEntity highlight) =>
      repository.updateHighlight(highlight);
}

class DeleteHighlightUseCase {
  final AdminRepository repository;
  const DeleteHighlightUseCase(this.repository);
  Future<Either<Failure, void>> call(int id) => repository.deleteHighlight(id);
}
