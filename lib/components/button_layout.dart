import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonLayout extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final IconData? buttonIcon;
  final double? width;
  final double? height;

  const ButtonLayout({
    required this.onTap,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    this.buttonIcon,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Center text and icon
            children: [
              Text(
                text,
                style: GoogleFonts.notoSans(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              if (buttonIcon != null) ...[
                SizedBox(width: 16), // Add spacing between text and icon
                Icon(buttonIcon, color: textColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
