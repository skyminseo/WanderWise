import 'package:flutter/material.dart';
import 'package:wander_wise/components/card_layout.dart';
import 'package:wander_wise/resources/color.dart';

class FlightCard extends StatelessWidget {
  const FlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      iconImage: Image.asset(
        'asset/img/plane.png',
      ), content: 'FLIGHT SEARCH',
    );
  }
}
