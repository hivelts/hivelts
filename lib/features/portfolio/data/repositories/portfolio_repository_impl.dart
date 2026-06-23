import '../../domain/entities/portfolio.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';
import '../datasources/portfolio_remote_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;
  final PortfolioRemoteDataSource remoteDataSource;
  final bool useRemote;

  const PortfolioRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    this.useRemote = false,
  });

  @override
  Future<Portfolio> getPortfolio(String languageCode) {
    if (useRemote) {
      return remoteDataSource.getPortfolio(languageCode);
    }
    return localDataSource.getPortfolio(languageCode);
  }
}
