import 'package:flutter/material.dart';
import 'package:wander_wise/resources/color.dart';

class CardLayout extends StatelessWidget {
  final Image iconImage;
  final String content;

  const CardLayout({
    required this.iconImage,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(64.0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  color: blueColor,
                  child: Padding(
                      padding: const EdgeInsets.all(32.0), child: iconImage),
                ),
              ),
            ),
            Center(
              child: Text(
                content,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
