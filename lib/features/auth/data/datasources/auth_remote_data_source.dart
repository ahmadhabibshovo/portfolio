import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/auth_tokens_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokensModel> login({
    required String email,
    required String password,
  });
  Future<void> logout({required String refreshToken});
  Future<UserModel> getUserProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthTokensModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await client.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (res != null && res['data'] != null) {
        return AuthTokensModel.fromJson(res['data'] as Map<String, dynamic>);
      }
      throw const ServerException('Invalid login response');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    try {
      await client.post(
        ApiEndpoints.logout,
        data: {'refresh_token': refreshToken},
      );
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getUserProfile() async {
    try {
      final res = await client.get(ApiEndpoints.userProfile);
      if (res != null && res['data'] != null) {
        return UserModel.fromJson(res['data'] as Map<String, dynamic>);
      }
      throw const ServerException('Profile not found');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
