import 'package:flutter/material.dart';

class BannerLayout extends StatelessWidget {
  final Color boxColor;
  final String priceStatus;

  const BannerLayout({
    required this.boxColor,
    required this.priceStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: boxColor,
            shape: BoxShape.circle,
          ),
          width: 16.0,
          height: 16.0,
        ),
        SizedBox(
          width: 16.0,
        ),
        Text(
          priceStatus,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
