import 'package:flutter/material.dart';
import 'package:hivelts/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'core/os_state.dart';
import 'features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/domain/usecases/portfolio_usecase.dart';
import 'features/portfolio/presentation/provider/portfolio_state.dart';
import 'screens/desktop_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hivelts/l10n/generated/app_localizations.dart';

void main() {
  runApp(const PortfolioOSBootstrap());
}

class PortfolioOSBootstrap extends StatelessWidget {
  const PortfolioOSBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    const localDataSource = AssetPortfolioLocalDataSource();
    const remoteDataSource = PortfolioRemoteDataSourcePlaceholder();

    const repository = PortfolioRepositoryImpl(localDataSource: localDataSource, remoteDataSource: remoteDataSource);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OSState()),
        ChangeNotifierProvider(
          create: (_) => PortfolioState(portfolioUseCase: const PortfolioUseCase(repository))..loadPortfolio('en'),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final osState = context.watch<OSState>();
    return MaterialApp(
      title: 'Hivelts OS',
      debugShowCheckedModeBanner: false,
      locale: osState.currentLocale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
      themeMode: osState.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const DesktopScreen(),
    );
  }
}
