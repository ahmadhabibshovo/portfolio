import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/project_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetProjectDetailUseCase {
  final PortfolioRepository repository;
  const GetProjectDetailUseCase(this.repository);

  Future<Either<Failure, ProjectEntity>> call(String idOrSlug) async {
    return await repository.getProjectById(idOrSlug);
  }
}
