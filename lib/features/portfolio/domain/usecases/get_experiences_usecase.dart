import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/experience_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetExperiencesUseCase {
  final PortfolioRepository repository;
  const GetExperiencesUseCase(this.repository);

  Future<Either<Failure, List<ExperienceEntity>>> call() async {
    return await repository.getExperiences();
  }
}
