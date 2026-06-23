import '../models/portfolio_model.dart';

abstract class PortfolioRemoteDataSource {
  Future<PortfolioModel> getPortfolio(String languageCode);
}

class PortfolioRemoteDataSourcePlaceholder
    implements PortfolioRemoteDataSource {
  const PortfolioRemoteDataSourcePlaceholder();

  @override
  Future<PortfolioModel> getPortfolio(String languageCode) {
    throw UnimplementedError(
      'Connect Firebase, Supabase, or a REST API here without changing UI or domain logic.',
    );
  }
}
