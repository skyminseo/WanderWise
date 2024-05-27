import 'package:flutter/material.dart';

final ThemeData textTheme = ThemeData(
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.blue[600],
      fontSize: 60.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'parisienne',
    ),
    displayMedium: TextStyle(
      color: Colors.blueAccent[200],
      fontSize: 30.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'sunflower',
    ),
    bodyLarge: TextStyle(
      color: Colors.blueGrey[600],
      fontSize: 20.0,
      fontFamily: 'sunflower',
    ),
    bodyMedium: TextStyle(
      color: Colors.blueGrey,
      fontSize: 30.0,
      fontFamily: 'sunflower',
    ),
  ),
);
