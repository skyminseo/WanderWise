import 'package:flutter/material.dart';
import 'package:wander_wise/components/text_theme.dart';
import 'package:wander_wise/screen/home_screen.dart';
import 'package:wander_wise/screen/start_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: textTheme,
      home: StartScreen(),
    ),
  );
}
