import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/highlight_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetHighlightsUseCase {
  final PortfolioRepository repository;

  GetHighlightsUseCase(this.repository);

  Future<Either<Failure, List<HighlightEntity>>> call() {
    return repository.getHighlights();
  }
}
