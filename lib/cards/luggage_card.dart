import 'package:flutter/material.dart';
import 'package:wander_wise/components/card_layout.dart';
import 'package:wander_wise/resources/color.dart';

class LuggageCard extends StatelessWidget {
  const LuggageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      iconImage: Image.asset(
        'asset/img/travel-luggage.png',
      ), content: 'CHECKED BAGGAGE ALLOWANCE',
    );
  }
}
