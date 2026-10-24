import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/book_model.dart';
import '../models/experience_model.dart';
import '../models/highlight_model.dart';
import '../models/profile_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/social_link_model.dart';

abstract class PortfolioRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<List<ProjectModel>> getProjects({String? category, bool? featured});
  Future<ProjectModel> getProjectById(String idOrSlug);
  Future<List<SkillModel>> getSkills({String? category});
  Future<List<ExperienceModel>> getExperiences();
  Future<List<SocialLinkModel>> getSocialLinks();
  Future<List<BookModel>> getBooks();
  Future<List<HighlightModel>> getHighlights();
  Future<String> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  });
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final ApiClient client;

  PortfolioRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final res = await client.get(ApiEndpoints.profile);
      if (res != null && res['data'] != null) {
        return ProfileModel.fromJson(res['data'] as Map<String, dynamic>);
      }
      throw const ServerException('Empty profile data returned');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProjectModel>> getProjects({
    String? category,
    bool? featured,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (featured != null) {
        queryParams['featured'] = featured.toString();
      }

      final res = await client.get(
        ApiEndpoints.projects,
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      if (res != null && res['data'] is List) {
        return (res['data'] as List)
            .map((item) => ProjectModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProjectModel> getProjectById(String idOrSlug) async {
    try {
      final res = await client.get(ApiEndpoints.projectById(idOrSlug));
      if (res != null && res['data'] != null) {
        return ProjectModel.fromJson(res['data'] as Map<String, dynamic>);
      }
      throw const ServerException('Project not found');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<SkillModel>> getSkills({String? category}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      final res = await client.get(
        ApiEndpoints.skills,
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      if (res != null && res['data'] is List) {
        return (res['data'] as List)
            .map((item) => SkillModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ExperienceModel>> getExperiences() async {
    try {
      final res = await client.get(ApiEndpoints.experiences);
      if (res != null && res['data'] is List) {
        return (res['data'] as List)
            .map(
              (item) => ExperienceModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<SocialLinkModel>> getSocialLinks() async {
    try {
      final res = await client.get(ApiEndpoints.socialLinks);
      if (res != null && res['data'] is List) {
        return (res['data'] as List)
            .map(
              (item) => SocialLinkModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BookModel>> getBooks() async {
    try {
      final res = await client.get(ApiEndpoints.books);
      if (res != null && res['data'] is List) {
        return (res['data'] as List)
            .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<HighlightModel>> getHighlights() async {
    try {
      final res = await client.get(ApiEndpoints.highlights);
      if (res != null && res['data'] is List) {
        return (res['data'] as List)
            .map(
              (item) => HighlightModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final res = await client.post(
        ApiEndpoints.contact,
        data: {
          'name': name,
          'email': email,
          'subject': subject,
          'message': message,
        },
      );
      return res['message']?.toString() ?? 'Message sent successfully';
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
