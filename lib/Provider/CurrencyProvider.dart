import 'package:api/Model/CurrencyModel.dart';
import 'package:api/Services/CurrencyApiService.dart';
import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  CurrencyApiService service = CurrencyApiService();

  CurrencyModel? _currencyModel;
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, String>? _currencies = {};

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CurrencyModel? get currencyModel => _currencyModel;
  Map<String, String>? get currencies => _currencies;

  Future<void> getCurrencyConversion() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await service.getLatestRates();
      _currencyModel = data;
    } catch (e) {
      _errorMessage = 'Failed to Convert Currency';
      _currencyModel = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCurrencies() async {
    try {
      final data = await service.getCurrencies();
      _currencies=data;
      notifyListeners();
    } catch (e) {
      _currencies=null;
      notifyListeners();
      rethrow;
    }
  }
}
