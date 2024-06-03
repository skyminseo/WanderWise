import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wander_wise/resources/color.dart';

class CardLayout extends StatelessWidget {
  final Widget child;
  final String content;

  const CardLayout({
    required this.child,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 14,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(64),
            topRight: Radius.circular(64),
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              child: Container(
                height: 240,
                color: darkPrimaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32.0,
                    right: 32,
                  ),
                  child: child,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 70,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              margin: EdgeInsets.only(
                top: 16,
                left: 4,
                right: 4,
              ),
              child: Center(
                child: Text(
                  content,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
