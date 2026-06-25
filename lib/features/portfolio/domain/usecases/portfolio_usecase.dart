import '../entities/portfolio.dart';
import '../repositories/portfolio_repository.dart';

class PortfolioUseCase {
  final PortfolioRepository repository;

  const PortfolioUseCase(this.repository);

  Future<Portfolio> getPortafolio(String languageCode) {
    return repository.getPortfolio(languageCode);
  }
}
