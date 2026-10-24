import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../portfolio/data/models/book_model.dart';
import '../../../portfolio/data/models/experience_model.dart';
import '../../../portfolio/data/models/highlight_model.dart';
import '../../../portfolio/data/models/profile_model.dart';
import '../../../portfolio/data/models/project_model.dart';
import '../../../portfolio/data/models/skill_model.dart';
import '../../../portfolio/data/models/social_link_model.dart';
import '../models/contact_message_model.dart';

abstract class AdminRemoteDataSource {
  Future<ProfileModel> updateProfile(Map<String, dynamic> data);
  Future<ProjectModel> createProject(Map<String, dynamic> data);
  Future<ProjectModel> updateProject(int id, Map<String, dynamic> data);
  Future<void> deleteProject(int id);
  Future<SkillModel> createSkill(Map<String, dynamic> data);
  Future<SkillModel> updateSkill(int id, Map<String, dynamic> data);
  Future<void> deleteSkill(int id);
  Future<ExperienceModel> createExperience(Map<String, dynamic> data);
  Future<ExperienceModel> updateExperience(int id, Map<String, dynamic> data);
  Future<void> deleteExperience(int id);
  Future<List<ContactMessageModel>> getMessages({bool? unreadOnly});
  Future<void> markMessageRead(int id, bool isRead);
  Future<void> deleteMessage(int id);
  Future<List<SocialLinkModel>> getSocialLinks();
  Future<SocialLinkModel> createSocialLink(Map<String, dynamic> data);
  Future<SocialLinkModel> updateSocialLink(int id, Map<String, dynamic> data);
  Future<void> deleteSocialLink(int id);
  Future<List<BookModel>> getBooks();
  Future<BookModel> createBook(Map<String, dynamic> data);
  Future<BookModel> updateBook(int id, Map<String, dynamic> data);
  Future<void> deleteBook(int id);
  Future<List<HighlightModel>> getHighlights();
  Future<HighlightModel> createHighlight(Map<String, dynamic> data);
  Future<HighlightModel> updateHighlight(int id, Map<String, dynamic> data);
  Future<void> deleteHighlight(int id);
  Future<String> uploadFile(List<int> fileBytes, String fileName);
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final ApiClient client;

  AdminRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfileModel> updateProfile(Map<String, dynamic> data) async {
    final res = await client.put(ApiEndpoints.adminProfile, data: data);
    if (res != null && res['data'] != null) {
      return ProfileModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to update profile');
  }

  @override
  Future<ProjectModel> createProject(Map<String, dynamic> data) async {
    final res = await client.post(ApiEndpoints.adminProjects, data: data);
    if (res != null && res['data'] != null) {
      return ProjectModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to create project');
  }

  @override
  Future<ProjectModel> updateProject(int id, Map<String, dynamic> data) async {
    final res = await client.put(ApiEndpoints.adminProjectById(id), data: data);
    if (res != null && res['data'] != null) {
      return ProjectModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to update project');
  }

  @override
  Future<void> deleteProject(int id) async {
    await client.delete(ApiEndpoints.adminProjectById(id));
  }

  @override
  Future<SkillModel> createSkill(Map<String, dynamic> data) async {
    final res = await client.post(ApiEndpoints.adminSkills, data: data);
    if (res != null && res['data'] != null) {
      return SkillModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to create skill');
  }

  @override
  Future<SkillModel> updateSkill(int id, Map<String, dynamic> data) async {
    final res = await client.put(ApiEndpoints.adminSkillById(id), data: data);
    if (res != null && res['data'] != null) {
      return SkillModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to update skill');
  }

  @override
  Future<void> deleteSkill(int id) async {
    await client.delete(ApiEndpoints.adminSkillById(id));
  }

  @override
  Future<ExperienceModel> createExperience(Map<String, dynamic> data) async {
    final res = await client.post(ApiEndpoints.adminExperiences, data: data);
    if (res != null && res['data'] != null) {
      return ExperienceModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to create experience');
  }

  @override
  Future<ExperienceModel> updateExperience(
    int id,
    Map<String, dynamic> data,
  ) async {
    final res = await client.put(
      ApiEndpoints.adminExperienceById(id),
      data: data,
    );
    if (res != null && res['data'] != null) {
      return ExperienceModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to update experience');
  }

  @override
  Future<void> deleteExperience(int id) async {
    await client.delete(ApiEndpoints.adminExperienceById(id));
  }

  @override
  Future<List<ContactMessageModel>> getMessages({bool? unreadOnly}) async {
    final q = unreadOnly != null ? {'unread': unreadOnly.toString()} : null;
    final res = await client.get(
      ApiEndpoints.adminMessages,
      queryParameters: q,
    );
    if (res != null && res['data'] is List) {
      return (res['data'] as List)
          .map((m) => ContactMessageModel.fromJson(m as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> markMessageRead(int id, bool isRead) async {
    await client.patch(
      ApiEndpoints.adminMessageRead(id),
      queryParameters: {'read': isRead.toString()},
    );
  }

  @override
  Future<void> deleteMessage(int id) async {
    await client.delete(ApiEndpoints.adminMessageById(id));
  }

  // Social Links
  @override
  Future<List<SocialLinkModel>> getSocialLinks() async {
    final res = await client.get(ApiEndpoints.adminSocialLinks);
    if (res != null && res['data'] is List) {
      return (res['data'] as List)
          .map((item) => SocialLinkModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<SocialLinkModel> createSocialLink(Map<String, dynamic> data) async {
    final res = await client.post(ApiEndpoints.adminSocialLinks, data: data);
    if (res != null && res['data'] != null) {
      return SocialLinkModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to create social link');
  }

  @override
  Future<SocialLinkModel> updateSocialLink(
    int id,
    Map<String, dynamic> data,
  ) async {
    final res = await client.put(
      ApiEndpoints.adminSocialLinkById(id),
      data: data,
    );
    if (res != null && res['data'] != null) {
      return SocialLinkModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to update social link');
  }

  @override
  Future<void> deleteSocialLink(int id) async {
    await client.delete(ApiEndpoints.adminSocialLinkById(id));
  }

  // Books
  @override
  Future<List<BookModel>> getBooks() async {
    final res = await client.get(ApiEndpoints.books);
    if (res != null && res['data'] is List) {
      return (res['data'] as List)
          .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<BookModel> createBook(Map<String, dynamic> data) async {
    final res = await client.post(ApiEndpoints.adminBooks, data: data);
    if (res != null && res['data'] != null) {
      return BookModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to create book');
  }

  @override
  Future<BookModel> updateBook(int id, Map<String, dynamic> data) async {
    final res = await client.put(ApiEndpoints.adminBookById(id), data: data);
    if (res != null && res['data'] != null) {
      return BookModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to update book');
  }

  @override
  Future<void> deleteBook(int id) async {
    await client.delete(ApiEndpoints.adminBookById(id));
  }

  // Highlights
  @override
  Future<List<HighlightModel>> getHighlights() async {
    final res = await client.get(ApiEndpoints.highlights);
    if (res != null && res['data'] is List) {
      return (res['data'] as List)
          .map((item) => HighlightModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<HighlightModel> createHighlight(Map<String, dynamic> data) async {
    final res = await client.post(ApiEndpoints.adminHighlights, data: data);
    if (res != null && res['data'] != null) {
      return HighlightModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to create highlight');
  }

  @override
  Future<HighlightModel> updateHighlight(
    int id,
    Map<String, dynamic> data,
  ) async {
    final res = await client.put(
      ApiEndpoints.adminHighlightById(id),
      data: data,
    );
    if (res != null && res['data'] != null) {
      return HighlightModel.fromJson(res['data'] as Map<String, dynamic>);
    }
    throw const ServerException('Failed to update highlight');
  }

  @override
  Future<void> deleteHighlight(int id) async {
    await client.delete(ApiEndpoints.adminHighlightById(id));
  }

  @override
  Future<String> uploadFile(List<int> fileBytes, String fileName) async {
    return await client.uploadFile(
      ApiEndpoints.upload,
      fileBytes: fileBytes,
      fileName: fileName,
    );
  }
}
