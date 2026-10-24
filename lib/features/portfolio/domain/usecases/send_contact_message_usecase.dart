import '../../../../core/error/failures.dart';
import '../../../../core/utils/either.dart';
import '../repositories/portfolio_repository.dart';

class SendContactMessageUseCase {
  final PortfolioRepository repository;
  const SendContactMessageUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    return await repository.sendContactMessage(
      name: name,
      email: email,
      subject: subject,
      message: message,
    );
  }
}
