import 'package:flutter/material.dart';
import 'package:wander_wise/resources/color.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;

  const LoginButton({required this.onTap, super.key,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
