import 'package:flutter/material.dart';
import '../Model/WeatherModel.dart';
import '../Services/ApiService.dart';

class WeatherProvider extends ChangeNotifier {

  final ApiService _service = ApiService();

  WeatherModel? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> getWeather(String cityName) async {

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _service.getWeather(cityName);
      _weather = result;
    } catch (e) {
      _errorMessage = "City not found or network error";
      _weather = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
