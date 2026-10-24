import '../../domain/entities/auth_tokens_entity.dart';
import 'user_model.dart';

class AuthTokensModel extends AuthTokensEntity {
  final UserModel? user;

  const AuthTokensModel({
    required super.accessToken,
    required super.refreshToken,
    this.user,
  });

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) {
    return AuthTokensModel(
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      user: json['user'] != null && json['user'] is Map<String, dynamic>
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}
