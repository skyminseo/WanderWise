import 'package:flutter/material.dart';
import 'package:wander_wise/components/card_layout.dart';
import 'package:wander_wise/resources/color.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      iconImage: Image.asset(
        'asset/img/weather.png',
      ), content: 'WEATHER FORECAST',
    );
  }
}
