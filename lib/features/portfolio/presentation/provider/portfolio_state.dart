import 'package:flutter/material.dart';

import '../../domain/entities/portfolio.dart';
import '../../domain/usecases/portfolio_usecase.dart';

class PortfolioState extends ChangeNotifier {
  final PortfolioUseCase portfolioUseCase;

  PortfolioState({
    required this.portfolioUseCase,
  });

  bool _isLoading = false;
  Portfolio? _portfolio;
  String? _error;

  bool get isLoading => _isLoading;
  Portfolio? get portfolio => _portfolio;
  String? get error => _error;

  Future<void> loadPortfolio(String languageCode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _portfolio = await portfolioUseCase.getPortafolio(languageCode);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}