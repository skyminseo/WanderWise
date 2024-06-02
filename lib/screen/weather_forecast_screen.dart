import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:wander_wise/providers/weather_provider.dart';
import 'package:wander_wise/resources/weather_cities.dart';

class WeatherForecastScreen extends ConsumerStatefulWidget {
  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends ConsumerState<WeatherForecastScreen> {
  String _city = 'Singapore'; // Default city

  void _searchWeather(String city) {
    setState(() {
      _city = city.trim();
      FocusScope.of(context).unfocus(); // Dismiss the keyboard
    });
  }

  String getAnimationForCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'asset/animation/sunny.json';
      case 'clouds':
        return 'asset/animation/cloudy.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'asset/animation/slight_cloudy.json';
      case 'rain':
        return 'asset/animation/lightening_rain.json';
      case 'drizzle':
      case 'shower rain':
        return 'asset/animation/sun_rainny.json';
      case 'thunderstorm':
        return 'asset/animation/lightening_rain.json';
      case 'snow':
        return 'asset/animation/snow.json';
      default:
        return 'asset/animation/sunny.json'; // Default to sunny
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherAsyncValue = ref.watch(weatherProvider(_city));
    final forecastAsyncValue = ref.watch(forecastProvider(_city));

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton2(
              isExpanded: true,
              hint: Text(
                'Select City',
                style: TextStyle(fontSize: 14),
              ),
              items: weatherCityNames
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                _searchWeather(value as String);
              },
            ),
            SizedBox(height: 28),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    weatherAsyncValue.when(
                      data: (weather) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[50],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 20,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${weather.cityName}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Lottie.asset(
                                  getAnimationForCondition(
                                      weather.mainCondition),
                                  height: 160,
                                  width: 160,
                                ),
                                Text(
                                  '${weather.mainCondition}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${weather.description}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${weather.currentTemperature.toStringAsFixed(1)} °C',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Min Temperature: \n${weather.minTemperature.toStringAsFixed(1)} °C',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Max Temperature: \n${weather.maxTemperature.toStringAsFixed(1)} °C',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Forecast',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    forecastAsyncValue.when(
                      data: (forecast) {
                        final groupedForecast = _groupForecastByDay(forecast);
                        return Container(
                          height: 240,
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: groupedForecast.length,
                            itemBuilder: (context, index) {
                              final dayForecast = groupedForecast[index];
                              return Container(
                                width: 140,
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 12,
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${DateFormat('MMM, E d').format(dayForecast.first.date)}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Lottie.asset(getAnimationForCondition(
                                          dayForecast.first.mainCondition)),
                                      Text(
                                        'Min: ${dayForecast.map((w) => w.minTemperature).reduce((a, b) => a < b ? a : b).toStringAsFixed(1)} °C',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        'Max: ${dayForecast.map((w) => w.maxTemperature).reduce((a, b) => a > b ? a : b).toStringAsFixed(1)} °C',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        '${dayForecast.first.mainCondition}',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<List<WeatherData>> _groupForecastByDay(List<WeatherData> forecast) {
    Map<String, List<WeatherData>> groupedForecast = {};
    for (var weather in forecast) {
      String dateKey = DateFormat('yyyy-MM-dd').format(weather.date);
      if (!groupedForecast.containsKey(dateKey)) {
        groupedForecast[dateKey] = [];
      }
      groupedForecast[dateKey]!.add(weather);
    }
    return groupedForecast.values.toList();
  }
}
