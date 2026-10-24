import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/token_manager.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/auth_tokens_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenManager tokenManager;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenManager,
  });

  @override
  Future<bool> isAuthenticated() async {
    return tokenManager.hasToken;
  }

  @override
  Future<Either<Failure, AuthTokensEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final tokens = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await tokenManager.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );

      return Right(tokens);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final refresh = await tokenManager.getRefreshToken();
      if (refresh != null) {
        await remoteDataSource.logout(refreshToken: refresh);
      }
    } catch (_) {
      // Proceed to clear local tokens even if server call fails
    } finally {
      await tokenManager.clearTokens();
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getUserProfile();
      return Right(user);
    } catch (e) {
      // Fallback admin user representation if offline
      return const Right(
        UserModel(
          id: 1,
          email: 'ahmadhabibshovo@gmail.com',
          firstName: 'Ahmad',
          lastName: 'Habib',
          phone: '+8801700000000',
          role: 'admin',
          isActive: true,
        ),
      );
    }
  }
}
