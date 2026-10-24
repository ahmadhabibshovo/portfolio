import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/auth_tokens_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  const LoginUseCase(this.repository);

  Future<Either<Failure, AuthTokensEntity>> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
