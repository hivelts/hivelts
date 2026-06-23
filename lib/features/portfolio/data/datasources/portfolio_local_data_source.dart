import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/portfolio_model.dart';

abstract class PortfolioLocalDataSource {
  Future<PortfolioModel> getPortfolio(String languageCode);
}

class AssetPortfolioLocalDataSource implements PortfolioLocalDataSource {
  const AssetPortfolioLocalDataSource();

  @override
  Future<PortfolioModel> getPortfolio(String languageCode) async {
    final normalizedCode = languageCode == 'es' ? 'es' : 'en';
    final rawJson = await rootBundle.loadString(
      'assets/data/portfolio_$normalizedCode.json',
    );
    return PortfolioModel.fromJson(jsonDecode(rawJson) as Map<String, dynamic>);
  }
}
