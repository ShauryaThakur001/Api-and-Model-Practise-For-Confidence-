import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/NewsModel.dart';

class NewsApiService {

  final String apiKey = "e7906ecf1da5434da9727af56c6ee6b4";

  Future<List<NewsModel>> fetchNews() async {

    final url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$apiKey"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final jsonData = jsonDecode(response.body);

      List articles = jsonData['articles'];

      return articles
          .map((e) => NewsModel.fromJson(e))
          .toList();
          
    } else {
      throw Exception("Failed to load news");
    }
  }
}
