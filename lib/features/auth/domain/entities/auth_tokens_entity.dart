import 'package:equatable/equatable.dart';

class AuthTokensEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthTokensEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
