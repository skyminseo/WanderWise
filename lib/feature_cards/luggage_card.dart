import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wander_wise/components/card_layout.dart';
import 'package:wander_wise/resources/color.dart';

class LuggageCard extends StatelessWidget {
  const LuggageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      child: Lottie.asset('asset/animation/luggage_ani.json'),
      content: 'Baggage Allowance',
    );
  }
}
