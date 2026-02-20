import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/CurrencyModel.dart';

class CurrencyApiService {
  final String apiKey = 'de9baeed00af409ebeb492ac5360cc8b';

  /// 🔹 Fetch latest conversion rates (latest.json)
  Future<CurrencyModel> getLatestRates() async {
    final url = Uri.parse(
      'https://openexchangerates.org/api/latest.json?base=USD&app_id=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CurrencyModel.fromJson(data);
    } else {
      throw Exception("Failed to load latest rates");
    }
  }

  /// 🔹 Fetch all currency names (currencies.json)
  Future<Map<String, String>> getCurrencies() async {
    final url = Uri.parse(
      'https://openexchangerates.org/api/currencies.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Convert dynamic map → Map<String, String>
      return data.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    } else {
      throw Exception("Failed to load currencies");
    }
  }
}