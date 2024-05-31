import 'package:flutter/material.dart';

class BannerLayout extends StatelessWidget {
  final Color boxColor;
  final String priceStatus;
  final BorderRadiusGeometry? borderRadius;

  const BannerLayout({
    required this.boxColor,
    required this.priceStatus,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: boxColor,
        shape: BoxShape.rectangle,
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Text(
          priceStatus,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
      height: 30,
      width: 68,
    );
  }
}
