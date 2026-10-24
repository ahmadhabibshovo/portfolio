import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/social_link_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetSocialLinksUseCase {
  final PortfolioRepository repository;

  GetSocialLinksUseCase(this.repository);

  Future<Either<Failure, List<SocialLinkEntity>>> call() {
    return repository.getSocialLinks();
  }
}
