import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/WeatherModel.dart';

class WeatherApiService {

  final String apiKey = "f011cca49027075b4b1357f7431ff529";

  Future<WeatherModel> getWeather(String cityName) async {

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return WeatherModel.fromJson(jsonData);
    } 
    else {
      throw Exception("Failed to load weather");
    }
  }
}

