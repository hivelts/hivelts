
import 'package:flutter/material.dart';
import 'package:hivelts/features/portfolio/presentation/provider/portfolio_state.dart';
import 'package:provider/provider.dart';

import '../../../../core/os_state.dart';

class PortfolioStateView extends StatefulWidget {
  final Widget Function(
      BuildContext context,
      PortfolioState provider,
      ) builder;

  const PortfolioStateView({
    super.key,
    required this.builder,
  });

  @override
  State<PortfolioStateView> createState() => _PortfolioStateViewState();
}

class _PortfolioStateViewState extends State<PortfolioStateView> {
  String? _loadedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final languageCode =
        context.watch<OSState>().currentLocale.languageCode;

    if (_loadedLanguage != languageCode) {
      _loadedLanguage = languageCode;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PortfolioState>()
            .loadPortfolio(languageCode);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioState>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.error != null) {
          return Center(
            child: Text(
              provider.error!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        }

        if (provider.portfolio != null) {
          return widget.builder(context, provider);
        }

        return const SizedBox.shrink();
      },
    );
  }
}