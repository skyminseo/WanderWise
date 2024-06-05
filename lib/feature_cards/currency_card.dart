import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wander_wise/components/card_layout.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      child: Lottie.asset('asset/animation/currency_ani.json'),
      content: 'Check Exchange Rates',
    );
  }
}
