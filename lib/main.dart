import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/os_state.dart';
import 'features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/domain/usecases/get_portfolio.dart';
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
          create: (_) => PortfolioState(getPortfolio: const GetPortfolio(repository))..getPortfolio('en'),
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
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFCF8FB),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0058BC),
          onPrimary: Colors.white,
          primaryContainer: Color(0xFF0070EB),
          onPrimaryContainer: Color(0xFFFEFCFF),
          secondary: Color(0xFF4C4ACA),
          tertiary: Color(0xFF9E3D00),
          surface: Color(0xFFFCF8FB),
          surfaceContainerLowest: Color(0xFFFFFFFF),
          surfaceContainerLow: Color(0xFFF6F3F5),
          surfaceContainer: Color(0xFFF0EDEF),
          surfaceContainerHigh: Color(0xFFEAE7EA),
          surfaceContainerHighest: Color(0xFFE4E2E4),
          onSurface: Color(0xFF1B1B1D),
          onSurfaceVariant: Color(0xFF414755),
          outline: Color(0xFF717786),
          outlineVariant: Color(0xFFC1C6D7),
          error: Color(0xFFBA1A1A),
        ),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF131315),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFADC6FF),
          onPrimary: Color(0xFF002E68),
          primaryContainer: Color(0xFF004493),
          onPrimaryContainer: Color(0xFFD8E2FF),
          secondary: Color(0xFFADC6FF),
          onSecondary: Color(0xFF152A78),
          secondaryContainer: Color(0xFF6664E4),
          onSecondaryContainer: Color(0xFFE2DFFF),
          tertiary: Color(0xFFFFB595),
          onTertiary: Color(0xFF1B1B1D),
          tertiaryContainer: Color(0xFFC64F00),
          surface: Color(0xFF131315),
          surfaceContainerLowest: Color(0xFF0E0E10),
          surfaceContainerLow: Color(0xFF1B1B1D),
          surfaceContainer: Color(0xFF212123),
          surfaceContainerHigh: Color(0xFF2B2B2D),
          surfaceContainerHighest: Color(0xFF333335),
          onSurface: Color(0xFFE4E2E4),
          onSurfaceVariant: Color(0xFFC1C6D7),
          outline: Color(0xFF8B91A0),
          outlineVariant: Color(0xFF414755),
          error: Color(0xFFFFB4AB),
        ),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: const Color(0xFFE4E2E4), displayColor: const Color(0xFFE4E2E4)),
      ),
      home: const DesktopScreen(),
    );
  }
}
