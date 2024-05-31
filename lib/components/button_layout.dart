import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonLayout extends StatefulWidget {
  final Function()? onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final IconData? buttonIcon;
  final double? width;
  final double? height;
  final BoxBorder? border;

  const ButtonLayout({
    required this.onTap,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    this.buttonIcon,
    this.width,
    this.height,
    this.border,
    super.key,
  });

  @override
  _ButtonLayoutState createState() => _ButtonLayoutState();
}

class _ButtonLayoutState extends State<ButtonLayout> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onTap?.call();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Transform.scale(
        scale: _isPressed ? 0.95 : 1.0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: widget.border,
            color: widget.buttonColor,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.notoSans(
                    color: widget.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                if (widget.buttonIcon != null) ...[
                  SizedBox(width: 16), // Add spacing between text and icon
                  Icon(widget.buttonIcon, color: widget.textColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
