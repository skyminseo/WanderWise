import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wander_wise/components/card_layout.dart';
import 'package:wander_wise/resources/color.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      child: Lottie.asset('asset/animation/map_ani.json'),
      content: 'Get Travel Tips from our Community',
    );
  }
}
