import 'package:api/Model/CurrencyModel.dart';
import 'package:api/Services/CurrencyApiService.dart';
import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier{

  CurrencyApiService service = CurrencyApiService();

  CurrencyModel? _currencyModel;
  bool _isLoading=false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CurrencyModel? get currencyModel => _currencyModel;

  Future<void>getCurrencyConversion()async{
    
    _isLoading=true;
    _errorMessage=null;
    notifyListeners();

    try {
      
      final data = await service.getCurrencyConversion();
      _currencyModel=data;
      
    } catch (e) {
      _errorMessage='Failed to Convert Currency';
      _currencyModel=null;
    }

    _isLoading=false;
    notifyListeners();
  }
  
}