class CurrencyModel {
  final String base;
  final String date;
  final Map<String, double> rates;

  CurrencyModel({
    required this.base,
    required this.date,
    required this.rates,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    final rawRates = json['rates'] as Map<String, dynamic>;

    return CurrencyModel(
      base: json['base'] ?? '',
      date: json['date'] ?? '',
      rates: rawRates.map(
        (key, value) => MapEntry(key, (value as num).toDouble()),
      ),
    );
  }
}