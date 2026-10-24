import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/project_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetProjectsUseCase {
  final PortfolioRepository repository;
  const GetProjectsUseCase(this.repository);

  Future<Either<Failure, List<ProjectEntity>>> call({
    String? category,
    bool? featured,
  }) async {
    return await repository.getProjects(category: category, featured: featured);
  }
}
