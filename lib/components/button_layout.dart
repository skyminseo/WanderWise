import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_wise/resources/color.dart';

class ButtonLayout extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;

  const ButtonLayout({
    required this.onTap,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(16.0)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.notoSans(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
