import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final apiKey = 'a872b7041ae0a5d57dcb48d4d51e7602'; // Replace this with your actual API key
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
