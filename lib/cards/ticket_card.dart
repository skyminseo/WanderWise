import 'package:flutter/material.dart';
import 'package:wander_wise/components/card_layout.dart';
import 'package:wander_wise/resources/color.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      iconImage: Image.asset(
        'asset/img/plane-ticket.png',
      ), content: 'TICKET PRICE PREDICTION FOR YOU',
    );
  }
}
