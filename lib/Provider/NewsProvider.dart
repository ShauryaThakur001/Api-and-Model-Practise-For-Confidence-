import 'package:flutter/material.dart';
import '../Model/NewsModel.dart';
import '../Services/NewsApiService.dart';

class NewsProvider extends ChangeNotifier {

  final NewsApiService _service = NewsApiService();

  bool _isLoading = false;
  String? _errorMessage;
  List<NewsModel> _newsModel = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<NewsModel> get newsModel => _newsModel;

  Future<void> fetchNews() async {

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _service.fetchNews();
      _newsModel = result;
    } catch (e) {
      _errorMessage = 'Failed to Fetch News';
      _newsModel = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
