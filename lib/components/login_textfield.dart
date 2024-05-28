import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const LoginTextfield({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.grey.shade600,
              ),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500],
            )),
      ),
    );
  }
}
