import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherData {
  final String cityName;
  final double currentTemperature;
  final double minTemperature;
  final double maxTemperature;
  final String description;
  final String mainCondition;
  final DateTime date;

  WeatherData({
    required this.cityName,
    required this.currentTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.mainCondition,
    required this.date,
  });

  factory WeatherData.fromWeather(Weather weather) {
    return WeatherData(
      cityName: weather.areaName ?? '',
      currentTemperature: double.parse((weather.temperature?.celsius ?? 0.0).toStringAsFixed(1)),
      minTemperature: double.parse((weather.tempMin?.celsius ?? 0.0).toStringAsFixed(1)),
      maxTemperature: double.parse((weather.tempMax?.celsius ?? 0.0).toStringAsFixed(1)),
      description: weather.weatherDescription ?? '',
      mainCondition: weather.weatherMain ?? '',
      date: weather.date ?? DateTime.now(),
    );
  }
}

final weatherProvider = FutureProvider.family<WeatherData, String>((ref, city) async {
  final apiKey = dotenv.env['API_KEY'];
  if (apiKey == null) {
    throw Exception('API_KEY not found in environment variables');
  }

  WeatherFactory weatherFactory = WeatherFactory(apiKey);
  Weather weather = await weatherFactory.currentWeatherByCityName(city);

  return WeatherData.fromWeather(weather);
});

final forecastProvider = FutureProvider.family<List<WeatherData>, String>((ref, city) async {
  final apiKey = dotenv.env['API_KEY'];
  if (apiKey == null) {
    throw Exception('API_KEY not found in environment variables');
  }

  WeatherFactory weatherFactory = WeatherFactory(apiKey);
  List<Weather> forecast = await weatherFactory.fiveDayForecastByCityName(city);

  return forecast.map((weather) => WeatherData.fromWeather(weather)).toList();
});
