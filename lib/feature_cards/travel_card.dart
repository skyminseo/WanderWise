import 'package:flutter/material.dart';
import 'package:wander_wise/components/card_layout.dart';
import 'package:wander_wise/resources/color.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      iconImage: Image.asset(
        'asset/img/travel_globe.png',
      ), content: 'DESTINATION RECOMMENDATIONS',
    );
  }
}
