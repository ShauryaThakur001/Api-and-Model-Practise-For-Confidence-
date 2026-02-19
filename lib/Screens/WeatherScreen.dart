import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/WeatherProvider.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {

  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [

            /// TextField
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: "Enter City Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Loading
            if (provider.isLoading)
              const CircularProgressIndicator(),

            /// Error
            if (provider.errorMessage != null)
              Text(
                provider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),

            /// Weather Data
            if (provider.weather != null) ...[

              const SizedBox(height: 20),

              Text(
                provider.weather!.cityName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text("${provider.weather!.temperature} °C"),

              const SizedBox(height: 10),

              Text("Humidity: ${provider.weather!.humidity}%"),

              const SizedBox(height: 10),

              Text("Wind: ${provider.weather!.windSpeed} m/s"),

              const SizedBox(height: 10),

              Text(provider.weather!.description),

              const SizedBox(height: 15),

              /// Weather Icon (Simplified Model)
              Image.network(
                "https://openweathermap.org/img/wn/${provider.weather!.icon}@2x.png",
                width: 100,
                height: 100,
              ),
            ],

            const SizedBox(height: 25),

            /// Search Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 15,
                ),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                if (cityController.text.isNotEmpty) {
                  context.read<WeatherProvider>()
                      .getWeather(cityController.text.trim());
                }
              },
              child: const Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
