import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/book_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetBooksUseCase {
  final PortfolioRepository repository;

  GetBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call() {
    return repository.getBooks();
  }
}
