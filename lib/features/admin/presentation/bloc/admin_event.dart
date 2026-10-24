import 'package:equatable/equatable.dart';

import '../../../portfolio/domain/entities/book_entity.dart';
import '../../../portfolio/domain/entities/experience_entity.dart';
import '../../../portfolio/domain/entities/highlight_entity.dart';
import '../../../portfolio/domain/entities/profile_entity.dart';
import '../../../portfolio/domain/entities/project_entity.dart';
import '../../../portfolio/domain/entities/skill_entity.dart';
import '../../../portfolio/domain/entities/social_link_entity.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class LoadAdminDataEvent extends AdminEvent {}

class UpdateProfileEvent extends AdminEvent {
  final ProfileEntity profile;
  const UpdateProfileEvent(this.profile);
  @override
  List<Object?> get props => [profile];
}

class CreateProjectEvent extends AdminEvent {
  final ProjectEntity project;
  const CreateProjectEvent(this.project);
  @override
  List<Object?> get props => [project];
}

class UpdateProjectEvent extends AdminEvent {
  final ProjectEntity project;
  const UpdateProjectEvent(this.project);
  @override
  List<Object?> get props => [project];
}

class DeleteProjectEvent extends AdminEvent {
  final int id;
  const DeleteProjectEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class CreateSkillEvent extends AdminEvent {
  final SkillEntity skill;
  const CreateSkillEvent(this.skill);
  @override
  List<Object?> get props => [skill];
}

class UpdateSkillEvent extends AdminEvent {
  final SkillEntity skill;
  const UpdateSkillEvent(this.skill);
  @override
  List<Object?> get props => [skill];
}

class DeleteSkillEvent extends AdminEvent {
  final int id;
  const DeleteSkillEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class CreateExperienceEvent extends AdminEvent {
  final ExperienceEntity experience;
  const CreateExperienceEvent(this.experience);
  @override
  List<Object?> get props => [experience];
}

class UpdateExperienceEvent extends AdminEvent {
  final ExperienceEntity experience;
  const UpdateExperienceEvent(this.experience);
  @override
  List<Object?> get props => [experience];
}

class DeleteExperienceEvent extends AdminEvent {
  final int id;
  const DeleteExperienceEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class LoadAdminMessagesEvent extends AdminEvent {
  final bool? unreadOnly;
  const LoadAdminMessagesEvent({this.unreadOnly});
  @override
  List<Object?> get props => [unreadOnly];
}

class MarkMessageReadEvent extends AdminEvent {
  final int id;
  final bool isRead;
  const MarkMessageReadEvent(this.id, this.isRead);
  @override
  List<Object?> get props => [id, isRead];
}

class DeleteMessageEvent extends AdminEvent {
  final int id;
  const DeleteMessageEvent(this.id);
  @override
  List<Object?> get props => [id];
}

// Social Link Events
class CreateSocialLinkEvent extends AdminEvent {
  final SocialLinkEntity link;
  const CreateSocialLinkEvent(this.link);
  @override
  List<Object?> get props => [link];
}

class UpdateSocialLinkEvent extends AdminEvent {
  final SocialLinkEntity link;
  const UpdateSocialLinkEvent(this.link);
  @override
  List<Object?> get props => [link];
}

class DeleteSocialLinkEvent extends AdminEvent {
  final int id;
  const DeleteSocialLinkEvent(this.id);
  @override
  List<Object?> get props => [id];
}

// Book Events
class CreateBookEvent extends AdminEvent {
  final BookEntity book;
  const CreateBookEvent(this.book);
  @override
  List<Object?> get props => [book];
}

class UpdateBookEvent extends AdminEvent {
  final BookEntity book;
  const UpdateBookEvent(this.book);
  @override
  List<Object?> get props => [book];
}

class DeleteBookEvent extends AdminEvent {
  final int id;
  const DeleteBookEvent(this.id);
  @override
  List<Object?> get props => [id];
}

// Highlight Events
class CreateHighlightEvent extends AdminEvent {
  final HighlightEntity highlight;
  const CreateHighlightEvent(this.highlight);
  @override
  List<Object?> get props => [highlight];
}

class UpdateHighlightEvent extends AdminEvent {
  final HighlightEntity highlight;
  const UpdateHighlightEvent(this.highlight);
  @override
  List<Object?> get props => [highlight];
}

class DeleteHighlightEvent extends AdminEvent {
  final int id;
  const DeleteHighlightEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class UploadFileEvent extends AdminEvent {
  final List<int> fileBytes;
  final String fileName;
  const UploadFileEvent(this.fileBytes, this.fileName);
  @override
  List<Object?> get props => [fileBytes, fileName];
}
