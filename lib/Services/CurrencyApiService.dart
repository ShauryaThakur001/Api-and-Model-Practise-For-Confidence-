import 'dart:convert';

import 'package:api/Model/CurrencyModel.dart';
import 'package:http/http.dart' as http;

class CurrencyApiService {

    final apiKey = 'de9baeed00af409ebeb492ac5360cc8b';

    Future<CurrencyModel>getCurrencyConversion()async{
      final url = Uri.parse('https://openexchangerates.org/api/latest.json?base=USD&app_id=$apiKey');

      final response = await http.get(url);

      if(response.statusCode==200){
        final Map<String, dynamic> data = jsonDecode(response.body);
        return CurrencyModel.fromJson(data);
      }
      else{
        throw Exception("Failed to do Currency Conversion");
      }
    }

}