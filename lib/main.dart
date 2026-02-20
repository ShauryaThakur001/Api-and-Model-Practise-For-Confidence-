import 'package:api/Provider/CurrencyProvider.dart';
import 'package:api/Provider/NewsProvider.dart';
import 'package:api/Provider/WeatherProvider.dart';
import 'package:api/Screens/CurrencyScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => WeatherProvider()),
    ChangeNotifierProvider(create: (context) => NewsProvider()),
    ChangeNotifierProvider(create: (context) => CurrencyProvider()),
  ],
  child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Api Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
      ),
      home: CurrencyScreen(),
    );
  }
}
