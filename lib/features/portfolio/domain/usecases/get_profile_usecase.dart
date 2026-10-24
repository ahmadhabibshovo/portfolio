import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/profile_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetProfileUseCase {
  final PortfolioRepository repository;
  const GetProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    return await repository.getProfile();
  }
}
