import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherData {
  final String cityName;
  final double temperature;
  final String description;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}

final weatherProvider = FutureProvider<WeatherData>((ref) async {
  final apiKey = dotenv.env['API_KEY'];
  if (apiKey == null) {
    throw Exception('API_KEY not found in environment variables');
  }

  final city = 'London';
  final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return WeatherData.fromJson(jsonDecode(response.body));
  } else {
    print('Failed to load weather data: ${response.body}');
    throw Exception('Failed to load weather data: ${response.body}');
  }
});
