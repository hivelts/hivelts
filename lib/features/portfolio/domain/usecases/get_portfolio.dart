import '../entities/portfolio.dart';
import '../repositories/portfolio_repository.dart';

class GetPortfolio {
  final PortfolioRepository repository;

  const GetPortfolio(this.repository);

  Future<Portfolio> call(String languageCode) {
    return repository.getPortfolio(languageCode);
  }
}
