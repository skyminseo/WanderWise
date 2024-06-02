import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_wise/providers/weather_provider.dart';

class WeatherForecastScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncValue = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Center(
        child: weatherAsyncValue.when(
          data: (weather) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'City: ${weather.cityName}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Temperature: ${weather.temperature} °C',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Description: ${weather.description}',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}
