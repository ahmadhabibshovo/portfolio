import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/skill_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetSkillsUseCase {
  final PortfolioRepository repository;
  const GetSkillsUseCase(this.repository);

  Future<Either<Failure, List<SkillEntity>>> call({String? category}) async {
    return await repository.getSkills(category: category);
  }
}
