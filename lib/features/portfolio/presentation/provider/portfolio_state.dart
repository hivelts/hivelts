import 'package:flutter/material.dart';

import '../../domain/entities/portfolio.dart';
import '../../domain/usecases/get_portfolio.dart';

class PortfolioState extends ChangeNotifier {
  final GetPortfolio getPortfolio;

  PortfolioState({
    required this.getPortfolio,
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
      _portfolio = await getPortfolio(languageCode);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}